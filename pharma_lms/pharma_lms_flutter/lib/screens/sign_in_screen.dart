import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/client.dart';

class SignInScreen extends StatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignedIn = false;
  late final EmailAuthController _emailAuth;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
    _emailAuth = EmailAuthController(
      client: client,
      onAuthenticated: () {
        if (mounted) setState(() => _isSignedIn = true);
      },
    );
    _emailAuth.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    _emailAuth.dispose();
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() => _errorMessage = null);
    try {
      await _emailAuth.login();
      if (!mounted) return;
      if (_emailAuth.state == EmailAuthState.error) {
        final msg = _emailAuth.errorMessage ?? 'Authentication failed.';
        setState(() => _errorMessage = msg);
        if (context.mounted) {
          context.showSnackBar(
            message: msg,
            backgroundColor: Colors.red,
          );
        }
      } else if (client.auth.isAuthenticated) {
        if (context.mounted) {
          context.showSnackBar(
            message: 'User authenticated.',
            backgroundColor: Colors.green,
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      final msg = 'Authentication failed: $e';
      setState(() => _errorMessage = msg);
      if (context.mounted) {
        context.showSnackBar(
          message: msg,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn) return widget.child;

    return Center(
      child: SizedBox(
        width: 350,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Sign in', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailAuth.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.username],
                  enabled: !_emailAuth.isLoading,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailAuth.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  enabled: !_emailAuth.isLoading,
                ),
                const SizedBox(height: 20),
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: _emailAuth.isLoading ? null : () => _signIn(context),
                  child: _emailAuth.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Sign in'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _emailAuth.isLoading ? null : () {
                    // TODO: Implement navigation to registration or forgot password
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
