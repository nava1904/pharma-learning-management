import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'oidc_idp_config.dart';

/// OIDC identity provider. Supports Auth0, Okta, Azure AD via discovery.
class OidcIdp {
  OidcIdp({
    required this.config,
    required TokenIssuer tokenIssuer,
    required AuthUsers authUsers,
    required UserProfiles userProfiles,
  })  : _tokenIssuer = tokenIssuer,
        _authUsers = authUsers,
        _userProfiles = userProfiles;

  static const String method = 'oidc';

  final OidcIdpConfig config;
  final TokenIssuer _tokenIssuer;
  final AuthUsers _authUsers;
  final UserProfiles _userProfiles;

  late final OAuth2PkceUtil _oauth2Util = OAuth2PkceUtil(config: config.oauth2Config);

  Future<AuthSuccess> login(
    Session session, {
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) async {
    return DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        await config.ensureDiscovery();
        final tokenResponse = await _oauth2Util.exchangeCodeForToken(
          code: code,
          codeVerifier: codeVerifier,
          redirectUri: redirectUri,
        );
        final userInfo = await _fetchUserInfo(session, tokenResponse.accessToken);
        final account = await _authenticate(session, userInfo, transaction);
        if (account.newAccount) {
          await _createUserProfile(
            session,
            account.authUserId,
            userInfo,
            transaction,
          );
        }
        return _tokenIssuer.issueToken(
          session,
          authUserId: account.authUserId,
          transaction: transaction,
          method: method,
          scopes: account.scopes,
        );
      },
    );
  }

  Future<Map<String, dynamic>> _fetchUserInfo(Session session, String accessToken) async {
    final uri = Uri.parse(config.userinfoEndpoint);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      session.log(
        'OIDC userinfo failed: ${response.statusCode}',
        level: LogLevel.error,
      );
      throw OidcAuthException('Failed to fetch user information');
    }
    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      session.log('OIDC userinfo parse error: $e', level: LogLevel.error);
      throw OidcAuthException('Invalid user information format');
    }
  }

  Future<_AccountResult> _authenticate(
    Session session,
    Map<String, dynamic> userInfo,
    Transaction transaction,
  ) async {
    final providerId = userInfo['sub']?.toString() ?? userInfo['id']?.toString();
    if (providerId == null || providerId.isEmpty) {
      throw OidcAuthException('Missing sub/id from OIDC userinfo');
    }
    var account = await OidcAccount.db.findFirstRow(
      session,
      where: (t) => t.providerId.equals(providerId),
      transaction: transaction,
    );
    final isNewAccount = account == null;
    if (isNewAccount) {
      final authUser = await _authUsers.create(
        session,
        transaction: transaction,
      );
      final email = userInfo['email'] as String? ?? userInfo['preferred_username'] as String?;
      account = await OidcAccount.db.insertRow(
        session,
        OidcAccount(
          authUserId: authUser.id.toString(),
          providerId: providerId,
          email: email,
        ),
        transaction: transaction,
      );
      return (
        authUserId: authUser.id,
        newAccount: true,
        scopes: authUser.scopes,
      );
    } else {
      final authUserId = UuidValue.fromString(account.authUserId);
      final authUser = await _authUsers.get(
        session,
        authUserId: authUserId,
        transaction: transaction,
      );
      return (
        authUserId: authUser.id,
        newAccount: false,
        scopes: authUser.scopes,
      );
    }
  }

  Future<void> _createUserProfile(
    Session session,
    UuidValue authUserId,
    Map<String, dynamic> userInfo,
    Transaction transaction,
  ) async {
    try {
      final name = userInfo['name'] as String? ??
          _join(
            userInfo['given_name'] as String?,
            userInfo['family_name'] as String?,
          );
      final email = userInfo['email'] as String? ?? userInfo['preferred_username'] as String?;
      await _userProfiles.createUserProfile(
        session,
        authUserId,
        UserProfileData(
          fullName: name,
          email: email,
        ),
        transaction: transaction,
      );
    } catch (e, stackTrace) {
      session.log(
        'OIDC profile creation failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  String? _join(String? a, String? b) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    return '$a $b';
  }
}

typedef _AccountResult = ({
  UuidValue authUserId,
  bool newAccount,
  Set<Scope> scopes,
});

class OidcAuthException implements Exception {
  OidcAuthException(this.message);
  final String message;
  @override
  String toString() => 'OidcAuthException: $message';
}
