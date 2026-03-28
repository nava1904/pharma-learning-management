import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// A premium, in-place dialog for all email auth flows (login, register, verify, reset).
/// Place this widget where your sign-in form is, not as a separate modal.
class EmailAuthPremiumDialog extends StatefulWidget {
  final EmailAuthController controller;
  final VoidCallback? onAuthenticated;
  final VoidCallback? onClose;
  const EmailAuthPremiumDialog({
    super.key,
    required this.controller,
    this.onAuthenticated,
    this.onClose,
  });

  @override
  State<EmailAuthPremiumDialog> createState() => _EmailAuthPremiumDialogState();
}

class _EmailAuthPremiumDialogState extends State<EmailAuthPremiumDialog> {
  late EmailAuthController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
    if (controller.isAuthenticated && widget.onAuthenticated != null) {
      widget.onAuthenticated!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = controller.currentScreen;
    final isLoading = controller.isLoading;
    final error = controller.errorMessage;
    return Center(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(32),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
              ),
              if (screen == EmailFlowScreen.login) ...[
                _buildLogin(isLoading, error),
              ] else if (screen == EmailFlowScreen.startRegistration) ...[
                _buildStartRegistration(isLoading, error),
              ] else if (screen == EmailFlowScreen.verifyRegistration) ...[
                _buildVerifyCode(isLoading, error, isReset: false),
              ] else if (screen == EmailFlowScreen.completeRegistration) ...[
                _buildSetPassword(isLoading, error, isReset: false),
              ] else if (screen == EmailFlowScreen.requestPasswordReset) ...[
                _buildRequestReset(isLoading, error),
              ] else if (screen == EmailFlowScreen.verifyPasswordReset) ...[
                _buildVerifyCode(isLoading, error, isReset: true),
              ] else if (screen == EmailFlowScreen.completePasswordReset) ...[
                _buildSetPassword(isLoading, error, isReset: true),
              ] else ...[
                const Text('Unknown state'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogin(bool isLoading, String? error) {
    return Column(
      children: [
        const Text('Sign in', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          enabled: !isLoading,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          enabled: !isLoading,
        ),
        if (error != null && error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading ? null : () => controller.login(),
          child: isLoading ? const CircularProgressIndicator() : const Text('Sign in'),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.navigateTo(EmailFlowScreen.startRegistration),
          child: const Text("Don't have an account? Register"),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.navigateTo(EmailFlowScreen.requestPasswordReset),
          child: const Text('Forgot password?'),
        ),
      ],
    );
  }

  Widget _buildStartRegistration(bool isLoading, String? error) {
    return Column(
      children: [
        const Text('Register', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          enabled: !isLoading,
        ),
        if (error != null && error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading ? null : () => controller.startRegistration(),
          child: isLoading ? const CircularProgressIndicator() : const Text('Send verification code'),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.navigateBack(),
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }

  Widget _buildRequestReset(bool isLoading, String? error) {
    return Column(
      children: [
        const Text('Reset password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          enabled: !isLoading,
        ),
        if (error != null && error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading ? null : () => controller.startPasswordReset(),
          child: isLoading ? const CircularProgressIndicator() : const Text('Send reset code'),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.navigateBack(),
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }

  Widget _buildVerifyCode(bool isLoading, String? error, {required bool isReset}) {
    return Column(
      children: [
        Text(isReset ? 'Verify reset code' : 'Verify registration code', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: controller.verificationCodeController,
          decoration: const InputDecoration(labelText: 'Verification code'),
          keyboardType: TextInputType.number,
          enabled: !isLoading,
        ),
        if (error != null && error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () => isReset
                  ? controller.verifyPasswordResetCode()
                  : controller.verifyRegistrationCode(),
          child: isLoading ? const CircularProgressIndicator() : const Text('Verify'),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.resendVerificationCode(),
          child: const Text('Resend code'),
        ),
        TextButton(
          onPressed: isLoading ? null : () => controller.navigateBack(),
          child: const Text('Back'),
        ),
      ],
    );
  }

  Widget _buildSetPassword(bool isLoading, String? error, {required bool isReset}) {
    return Column(
      children: [
        Text(isReset ? 'Set new password' : 'Set password', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: controller.passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          enabled: !isLoading,
        ),
        if (error != null && error.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: Colors.red)),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () => isReset
                  ? controller.finishPasswordReset()
                  : controller.finishRegistration(),
          child: isLoading ? const CircularProgressIndicator() : const Text('Continue'),
        ),
      ],
    );
  }
}
