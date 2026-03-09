import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/client.dart';

/// Validated auditor session from token.
class AuditorSession {
  const AuditorSession({
    required this.inspectionRecordId,
    this.scopeDescription,
    this.expiresAt,
    this.siteName,
  });
  final int inspectionRecordId;
  final String? scopeDescription;
  final String? expiresAt;
  final String? siteName;
}

/// Validates auditor token and provides session for page logging.
final auditorSessionProvider =
    FutureProvider.family<AuditorSession?, String>((ref, token) async {
  if (token.isEmpty) return null;
  try {
    final result =
        await client.inspection.validateAuditorToken(token: token);
    if (result == null) return null;
    final id = result['inspectionRecordId'] as int?;
    if (id == null) return null;
    return AuditorSession(
      inspectionRecordId: id,
      scopeDescription: result['scopeDescription'] as String?,
      expiresAt: result['expiresAt'] as String?,
      siteName: result['siteName'] as String?,
    );
  } catch (_) {
    return null;
  }
});
