import 'package:flutter/foundation.dart';
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
        const SizedBox(height: 4),
        Text(
          'Keep your learners compliant',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate600,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
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
        if (!kReleaseMode)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextButton(
              onPressed: () => setState(() => _demoMode = true),
              child: const Text('Use demo mode (role selection)'),
            ),
          ),
        if (kReleaseMode) const SizedBox(height: 16),
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
        const SizedBox(height: 4),
        Text(
          'Keep your learners compliant',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.slate600,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          AppConstants.complianceBanner,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.slate500,
              ),
        ),
        const SizedBox(height: 24),
        Text(
          'Select Role to Continue',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.slate700,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _RoleChip(
              label: 'Employee',
              icon: Icons.person,
              isSelected: _selectedRole == AppRole.employee,
              onTap: () => setState(() => _selectedRole = AppRole.employee),
            ),
            _RoleChip(
              label: 'Admin',
              icon: Icons.admin_panel_settings,
              isSelected: _selectedRole == AppRole.admin,
              onTap: () => setState(() => _selectedRole = AppRole.admin),
            ),
            _RoleChip(
              label: 'QA',
              icon: Icons.verified,
              isSelected: _selectedRole == AppRole.qa,
              onTap: () => setState(() => _selectedRole = AppRole.qa),
            ),
            _RoleChip(
              label: 'SME',
              icon: Icons.school,
              isSelected: _selectedRole == AppRole.trainer,
              onTap: () => setState(() => _selectedRole = AppRole.trainer),
            ),
            _RoleChip(
              label: 'Auditor',
              icon: Icons.search,
              isSelected: _selectedRole == AppRole.auditor,
              onTap: () => setState(() => _selectedRole = AppRole.auditor),
            ),
            _RoleChip(
              label: 'Analytics',
              icon: Icons.analytics,
              isSelected: _selectedRole == AppRole.analytics,
              onTap: () => setState(() => _selectedRole = AppRole.analytics),
            ),
          ],
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

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.indigo50 : AppColors.slate100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.indigo600 : AppColors.slate300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.indigo600 : AppColors.slate600,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppColors.indigo700 : AppColors.slate700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
