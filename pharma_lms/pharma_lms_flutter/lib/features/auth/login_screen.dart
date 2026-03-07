import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  AppRole? _selectedRole;
  bool _demoMode = false;

  @override
  void initState() {
    super.initState();
    if (client.auth.isAuthenticated && ref.read(selectedRoleProvider) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onAuthenticated());
    }
  }

  Future<void> _runSeed(BuildContext context) async {
    try {
      final msg = await client.seed.runSeed();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Seed failed: $e'),
            backgroundColor: AppColors.destructive,
          ),
        );
      }
    }
  }

  Future<void> _onAuthenticated() async {
    try {
      final profile =
          await client.modules.serverpod_auth_core.userProfileInfo.get();
      final email = profile.email;
      if (email != null && email.isNotEmpty && mounted) {
        loginWithAuthEmail(ref, context, email);
      } else if (mounted) {
        loginWithAuthEmail(ref, context, 'employee@pharmacorp.demo');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not load profile: $e'),
            backgroundColor: AppColors.destructive,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEFF6FF),
              Color(0xFFE0E7FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: _demoMode ? _buildDemoForm() : _buildAuthForm(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Session timeout: 15 minutes | NTP Synchronized',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.indigo600,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learning Management System',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.complianceBanner,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.slate500,
              ),
        ),
        const SizedBox(height: 32),
        SignInWidget(
          client: client,
          onAuthenticated: _onAuthenticated,
          onError: (error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Authentication failed: $error'),
                  backgroundColor: AppColors.destructive,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => setState(() => _demoMode = true),
          child: const Text('Use demo mode (role selection)'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => _runSeed(context),
          child: const Text('Seed sample data'),
        ),
      ],
    );
  }

  Widget _buildDemoForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.indigo600,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Learning Management System',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.complianceBanner,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.slate500,
              ),
        ),
        const SizedBox(height: 32),
        DropdownButtonFormField<AppRole>(
          value: _selectedRole,
          decoration: const InputDecoration(
            labelText: 'Select Role to Continue',
          ),
          items: const [
            DropdownMenuItem(
              value: AppRole.employee,
              child: Text('Employee / Trainee'),
            ),
            DropdownMenuItem(
              value: AppRole.admin,
              child: Text('Training Administrator'),
            ),
            DropdownMenuItem(
              value: AppRole.qa,
              child: Text('Quality Assurance (QA)'),
            ),
            DropdownMenuItem(
              value: AppRole.trainer,
              child: Text('Subject Matter Expert (SME)'),
            ),
            DropdownMenuItem(
              value: AppRole.auditor,
              child: Text('Auditor Portal'),
            ),
          ],
          onChanged: (role) {
            setState(() => _selectedRole = role);
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedRole == null
                ? null
                : () => loginWithRole(ref, context, _selectedRole!),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.indigo600,
              disabledBackgroundColor: AppColors.slate300,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Access LMS'),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => setState(() => _demoMode = false),
          child: const Text('Back to email/password login'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => _runSeed(context),
          child: const Text('Seed sample data'),
        ),
      ],
    );
  }
}
