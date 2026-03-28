import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../design_system/pharma_components.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/auth_provider.dart';
import 'oidc_sign_in_widget.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// Vyuh lms — login screen (Render-inspired design)
/// ═══════════════════════════════════════════════════════════════════════════════
///
/// Design System:
/// - 8pt spatial grid (8, 16, 24, 32, 40, 48, 56, 64px)
/// - Render-style animated grid with gradient beams and fading edges
/// - Clean form panel with proper visual hierarchy
/// - Trust signals and compliance badges
/// ═══════════════════════════════════════════════════════════════════════════════
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _gridAnimController;
  late AnimationController _beamAnimController;
  late EmailAuthController _emailAuthController;

  // ─── Design Tokens (8pt grid) ───
  static const double s1 = 8;
  static const double s2 = 16;
  static const double s3 = 24;
  static const double s4 = 32;
  static const double s5 = 40;
  static const double s6 = 48;

  // ─── Brand Colors ───
  static const Color brandAccent = Color(0xFF00D4AA);
  static const Color textPrimary = Color(0xFF0A1628);
  static const Color textSecondary = Color(0xFF475569);
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Form controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _gridAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    
    _beamAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _emailAuthController = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.login,
      onAuthenticated: _onAuthenticated,
      onError: (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication failed: $error'),
            backgroundColor: AppColors.destructive,
          ),
        );
      },
    )..addListener(_onEmailAuthChanged);

    if (client.auth.isAuthenticated && ref.read(selectedRoleProvider) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onAuthenticated());
    }
  }

  void _onEmailAuthChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _gridAnimController.dispose();
    _beamAnimController.dispose();
    _emailAuthController
      ..removeListener(_onEmailAuthChanged)
      ..dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onAuthenticated() async {
    try {
      final profile =
          await client.modules.serverpod_auth_core.userProfileInfo.get();
      final email = profile.email;
      if (email == null || email.isEmpty) {
        if (mounted) loginWithAuthEmail(ref, context, 'employee@pharmacorp.demo');
        return;
      }
      final mfaStatus = await client.mfa.getMfaStatus();
      if (mounted && mfaStatus.mfaEnabled) {
        final verified = await _showMfaVerifyDialog(context);
        if (!verified) {
          try {
            client.auth.signOutDevice();
          } catch (_) {}
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('MFA verification required. Please sign in again.'),
                backgroundColor: AppColors.destructive,
              ),
            );
          }
          return;
        }
      }
      if (mounted) loginWithAuthEmail(ref, context, email);
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

  Future<bool> _showMfaVerifyDialog(BuildContext context) async {
    String code = '';
    String? error;
    var verifying = false;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2540).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.security, color: Color(0xFF0A2540)),
                ),
                const SizedBox(width: 12),
                const Text('Two-Factor Authentication'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter the 6-digit code from your authenticator app to verify your identity.',
                  style: TextStyle(color: Color(0xFF425466)),
                ),
                if (error != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.destructive.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: AppColors.destructive, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            error!,
                            style: TextStyle(color: AppColors.destructive, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  autofocus: true,
                  enabled: !verifying,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 8,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                    hintText: '• • • • • •',
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFFF6F9FC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE3E8EE)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE3E8EE)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF0A2540), width: 2),
                    ),
                  ),
                  onChanged: (v) => setState(() => code = v),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: verifying ? null : () => Navigator.of(ctx).pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.slate600),
                ),
              ),
              ElevatedButton(
                onPressed: verifying
                    ? null
                    : () async {
                        if (code.length != 6) {
                          setState(() => error = 'Please enter a complete 6-digit code');
                          return;
                        }
                        setState(() {
                          verifying = true;
                          error = null;
                        });
                        try {
                          final ok = await client.mfa.verifyMfa(code);
                          if (ctx.mounted) Navigator.of(ctx).pop(ok);
                        } catch (_) {
                          if (ctx.mounted) {
                            setState(() {
                              verifying = false;
                              error = 'Invalid code. Please try again.';
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2540),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: verifying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Verify'),
              ),
            ],
          );
        },
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900;

    return Scaffold(
      body: isWideScreen ? _buildSplitLayout() : _buildMobileLayout(),
    );
  }

  /// Split-panel layout for wide screens (desktop/tablet landscape)
  Widget _buildSplitLayout() {
    return Row(
      children: [
        // Left panel - Dark brand side
        Expanded(
          flex: 5,
          child: _buildBrandPanel(),
        ),
        // Right panel - Light form side
        Expanded(
          flex: 4,
          child: _buildFormPanel(),
        ),
      ],
    );
  }

  /// Single column layout for mobile
  Widget _buildMobileLayout() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A1628), Color(0xFF0D2137)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Compact brand header for mobile
              _buildMobileBrandHeader(),
              // Form card with proper spacing
              Container(
                margin: const EdgeInsets.all(s2), // 16px
                decoration: BoxDecoration(
                  color: surfaceLight,
                  borderRadius: BorderRadius.circular(s3), // 24px
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: _buildFormContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Mobile brand header (compact version with proper spacing)
  Widget _buildMobileBrandHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(s3, s4, s3, s2), // 24, 32, 24, 16
      child: Column(
        children: [
          // Logo with accent border
          Container(
            padding: const EdgeInsets.all(s2), // 16px
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(s2), // 16px
              border: Border.all(
                color: brandAccent.withValues(alpha: 0.3),
              ),
            ),
            child: VyuhLogo(
              height: 36,
              width: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: s2), // 16px
          Text(
            PharmaBrand.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: s1), // 8px
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: s2, // 16px
              vertical: s1 / 2, // 4px
            ),
            decoration: BoxDecoration(
              color: brandAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(s2), // 16px pill
            ),
            child: const Text(
              'ENTERPRISE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: brandAccent,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: s1), // 8px
          Text(
            'Enterprise Learning Management',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Left panel with brand identity, trust signals, and Render-style animated grid
  Widget _buildBrandPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF0D2137)],
        ),
      ),
      child: Stack(
        children: [
          // Render-style animated grid background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _gridAnimController,
              builder: (context, child) {
                return AnimatedBuilder(
                  animation: _beamAnimController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _RenderGridPainter(
                        gridAnimation: _gridAnimController.value,
                        beamAnimation: _beamAnimController.value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Gradient fade at edges (Render-style)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A1628).withValues(alpha: 0.3),
                    const Color(0xFF0A1628).withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),
          // Content with proper 8pt grid spacing
          Padding(
            padding: const EdgeInsets.all(s6), // 48px
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo and brand name
                Row(
                  children: [
                    VyuhLogo(height: s4, width: s4, color: Colors.white), // 32px
                    const SizedBox(width: s2), // 16px
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PharmaBrand.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: s1 / 2), // 4px
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: s1, // 8px
                            vertical: s1 / 2, // 4px
                          ),
                          decoration: BoxDecoration(
                            color: brandAccent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(s1 / 2),
                          ),
                          child: const Text(
                            'ENTERPRISE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: brandAccent,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Main headline with gradient accent
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xFFE0E0E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Training\nCompliance\nSimplified.',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                const SizedBox(height: s3), // 24px
                Text(
                  'The enterprise learning management system built for\nregulated pharmaceutical environments.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: s5), // 40px

                // Compliance badges - proper spacing
                Wrap(
                  spacing: s1, // 8px
                  runSpacing: s1, // 8px
                  children: [
                    _buildComplianceBadge('21 CFR Part 11', Icons.verified_user),
                    _buildComplianceBadge('EU GMP Annex 11', Icons.euro),
                    _buildComplianceBadge('GAMP 5', Icons.category),
                    _buildComplianceBadge('ALCOA+', Icons.check_circle),
                  ],
                ),

                const SizedBox(height: s5), // 40px

                // Stats row with proper spacing
                Row(
                  children: [
                    _buildStatItem('500+', 'Enterprise\norganizations'),
                    const SizedBox(width: s4), // 32px
                    _buildStatItem('2M+', 'Trained\nUsers'),
                    const SizedBox(width: s4), // 32px
                    _buildStatItem('99.9%', 'Audit\nSuccess'),
                  ],
                ),

                const Spacer(),

                // Footer - subtle
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: s1), // 8px
                    Text(
                      'SOC 2 Type II  •  ISO 27001  •  HIPAA',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.4),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceBadge(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: s2, vertical: s1), // 16px, 8px
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(s3), // 24px - pill shape
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: brandAccent),
          const SizedBox(width: s1), // 8px
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: brandAccent,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: s1 / 2), // 4px
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.5),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// Right panel with login form - clean white surface
  Widget _buildFormPanel() {
    return Container(
      color: surfaceLight,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(s6), // 48px
            child: _buildFormContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Padding(
        padding: const EdgeInsets.all(s3), // 24px
        child: _buildAuthForm(),
      ),
    );
  }

  Widget _buildAuthForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header - clean typography
        const Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: s1), // 8px
        Text(
          'Sign in to access your training dashboard',
          style: TextStyle(
            fontSize: 15,
            color: textSecondary.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        const SizedBox(height: s4), // 32px

        // MFA Badge - refined
        Container(
          padding: const EdgeInsets.all(s2), // 16px
          decoration: BoxDecoration(
            color: brandAccent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(s2), // 16px
            border: Border.all(
              color: brandAccent.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(s1), // 8px
                decoration: BoxDecoration(
                  color: brandAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(s1), // 8px
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: brandAccent,
                ),
              ),
              const SizedBox(width: s2), // 16px
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Protected by MFA',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Two-factor authentication enabled',
                      style: TextStyle(
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: s3), // 24px

        // Custom Serverpod email auth flow
        _buildCustomEmailAuthWidget(),
        const SizedBox(height: s3), // 24px

        // Divider - refined
        Row(
          children: [
            Expanded(child: Divider(color: borderLight)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: s2), // 16px
              child: Text(
                'or continue with',
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),
            Expanded(child: Divider(color: borderLight)),
          ],
        ),
        const SizedBox(height: s3), // 24px

        // SSO Button
        OidcSignInWidget(
          onAuthenticated: _onAuthenticated,
          onError: (error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('SSO sign-in failed: $error'),
                  backgroundColor: AppColors.destructive,
                ),
              );
            }
          },
        ),

        const SizedBox(height: s4), // 32px

        // Footer - audit trail info
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history,
                size: 12,
                color: textSecondary.withValues(alpha: 0.4),
              ),
              const SizedBox(width: s1), // 8px
              Text(
                'All actions are logged for audit compliance',
                style: TextStyle(
                  fontSize: 11,
                  color: textSecondary.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: s1), // 8px
        Center(
          child: Text(
            'Session timeout: 15 min  •  NTP synchronized',
            style: TextStyle(
              fontSize: 10,
              color: textSecondary.withValues(alpha: 0.3),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomEmailAuthWidget() {
    final screen = _emailAuthController.currentScreen;
    final loading = _emailAuthController.isLoading;
    final error = _emailAuthController.errorMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && error.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.only(bottom: s2),
            padding: const EdgeInsets.all(s2),
            decoration: BoxDecoration(
              color: AppColors.destructive.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.destructive.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              error,
              style: const TextStyle(
                color: AppColors.destructive,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        Text(
          _authTitleFor(screen),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: s1),
        Text(
          _authSubtitleFor(screen),
          style: TextStyle(
            fontSize: 14,
            color: textSecondary.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        const SizedBox(height: s3),
        _buildAuthInputSection(screen, loading),
        const SizedBox(height: s2),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: loading ? null : _submitCurrentAuthStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: brandAccent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _actionLabelFor(screen),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: s2),
        _buildAuthFooterActions(screen, loading),
      ],
    );
  }

  Widget _buildAuthInputSection(EmailFlowScreen screen, bool loading) {
    switch (screen) {
      case EmailFlowScreen.login:
        return Column(
          children: [
            _buildAuthTextField(
              controller: _emailAuthController.emailController,
              hintText: 'Email',
              icon: Icons.email_outlined,
              enabled: !loading,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            _buildAuthTextField(
              controller: _emailAuthController.passwordController,
              hintText: 'Password',
              icon: Icons.lock_outline,
              enabled: !loading,
              obscureText: true,
            ),
          ],
        );
      case EmailFlowScreen.startRegistration:
      case EmailFlowScreen.requestPasswordReset:
        return _buildAuthTextField(
          controller: _emailAuthController.emailController,
          hintText: 'Email',
          icon: Icons.email_outlined,
          enabled: !loading,
          keyboardType: TextInputType.emailAddress,
        );
      case EmailFlowScreen.verifyRegistration:
      case EmailFlowScreen.verifyPasswordReset:
        return Column(
          children: [
            _buildAuthTextField(
              controller: _emailAuthController.verificationCodeController,
              hintText: 'Verification code',
              icon: Icons.verified_user_outlined,
              enabled: !loading,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: s1),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: loading
                    ? null
                    : () => _emailAuthController.resendVerificationCode(),
                child: const Text('Resend code'),
              ),
            ),
          ],
        );
      case EmailFlowScreen.completeRegistration:
      case EmailFlowScreen.completePasswordReset:
        return _buildAuthTextField(
          controller: _emailAuthController.passwordController,
          hintText: screen == EmailFlowScreen.completeRegistration
              ? 'Create password'
              : 'New password',
          icon: Icons.lock_outline,
          enabled: !loading,
          obscureText: true,
        );
    }
  }

  Widget _buildAuthTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool enabled = true,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: s2, vertical: 14),
        prefixIcon: Icon(icon, size: 18, color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: brandAccent.withValues(alpha: 0.9)),
        ),
      ),
    );
  }

  Widget _buildAuthFooterActions(EmailFlowScreen screen, bool loading) {
    if (screen == EmailFlowScreen.login) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: loading
                ? null
                : () => _emailAuthController
                    .navigateTo(EmailFlowScreen.startRegistration),
            child: const Text('Create account'),
          ),
          TextButton(
            onPressed: loading
                ? null
                : () => _emailAuthController
                    .navigateTo(EmailFlowScreen.requestPasswordReset),
            child: const Text('Forgot password?'),
          ),
        ],
      );
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: loading
            ? null
            : () => _emailAuthController.navigateTo(EmailFlowScreen.login),
        child: const Text('Back to sign in'),
      ),
    );
  }

  Future<void> _submitCurrentAuthStep() async {
    switch (_emailAuthController.currentScreen) {
      case EmailFlowScreen.login:
        await _emailAuthController.login();
        break;
      case EmailFlowScreen.startRegistration:
        await _emailAuthController.startRegistration();
        break;
      case EmailFlowScreen.verifyRegistration:
        await _emailAuthController.verifyRegistrationCode();
        break;
      case EmailFlowScreen.completeRegistration:
        await _emailAuthController.finishRegistration();
        break;
      case EmailFlowScreen.requestPasswordReset:
        await _emailAuthController.startPasswordReset();
        break;
      case EmailFlowScreen.verifyPasswordReset:
        await _emailAuthController.verifyPasswordResetCode();
        break;
      case EmailFlowScreen.completePasswordReset:
        await _emailAuthController.finishPasswordReset();
        break;
    }
  }

  String _authTitleFor(EmailFlowScreen screen) {
    switch (screen) {
      case EmailFlowScreen.login:
        return 'Welcome back';
      case EmailFlowScreen.startRegistration:
        return 'Create account';
      case EmailFlowScreen.verifyRegistration:
        return 'Verify email';
      case EmailFlowScreen.completeRegistration:
        return 'Set password';
      case EmailFlowScreen.requestPasswordReset:
        return 'Reset password';
      case EmailFlowScreen.verifyPasswordReset:
        return 'Verify reset code';
      case EmailFlowScreen.completePasswordReset:
        return 'Set new password';
    }
  }

  String _authSubtitleFor(EmailFlowScreen screen) {
    switch (screen) {
      case EmailFlowScreen.login:
        return 'Sign in to access your training dashboard';
      case EmailFlowScreen.startRegistration:
        return 'Register your work email to get started';
      case EmailFlowScreen.verifyRegistration:
        return 'Enter the verification code sent to your email';
      case EmailFlowScreen.completeRegistration:
        return 'Create a secure password for your account';
      case EmailFlowScreen.requestPasswordReset:
        return 'Enter your email to receive a reset code';
      case EmailFlowScreen.verifyPasswordReset:
        return 'Enter the code we sent to your email';
      case EmailFlowScreen.completePasswordReset:
        return 'Choose a new password for your account';
    }
  }

  String _actionLabelFor(EmailFlowScreen screen) {
    switch (screen) {
      case EmailFlowScreen.login:
        return 'Sign in';
      case EmailFlowScreen.startRegistration:
        return 'Continue';
      case EmailFlowScreen.verifyRegistration:
      case EmailFlowScreen.verifyPasswordReset:
        return 'Verify';
      case EmailFlowScreen.completeRegistration:
        return 'Create account';
      case EmailFlowScreen.requestPasswordReset:
        return 'Send reset code';
      case EmailFlowScreen.completePasswordReset:
        return 'Update password';
    }
  }
}

/// ═══════════════════════════════════════════════════════════════════════════════
/// RENDER-STYLE ANIMATED GRID PAINTER
/// ═══════════════════════════════════════════════════════════════════════════════
/// 
/// Inspired by Render.com dashboard hero animation:
/// - Subtle grid lines that fade at edges
/// - Moving beams of light traversing the grid
/// - Pulsing glow at grid intersections
/// - Gradient fade to background at edges
/// ═══════════════════════════════════════════════════════════════════════════════
class _RenderGridPainter extends CustomPainter {
  _RenderGridPainter({
    required this.gridAnimation,
    required this.beamAnimation,
  });

  final double gridAnimation;
  final double beamAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    const gridSpacing = 48.0; // 48px grid
    const lineOpacity = 0.06;
    const accentColor = Color(0xFF00D4AA);
    
    // ─── Base Grid Lines ───
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: lineOpacity)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSpacing) {
      // Fade at edges
      final edgeFade = _calculateEdgeFade(x, size.width);
      gridPaint.color = Colors.white.withValues(alpha: lineOpacity * edgeFade);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSpacing) {
      final edgeFade = _calculateEdgeFade(y, size.height);
      gridPaint.color = Colors.white.withValues(alpha: lineOpacity * edgeFade);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // ─── Animated Beam (Render-style traveling light) ───
    final beamY = size.height * beamAnimation;
    final beamGradient = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          accentColor.withValues(alpha: 0.3),
          accentColor.withValues(alpha: 0.5),
          accentColor.withValues(alpha: 0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, beamY - 2, size.width, 4));

    canvas.drawRect(
      Rect.fromLTWH(0, beamY - 1, size.width, 2),
      beamGradient,
    );

    // Vertical beam
    final beamX = size.width * ((beamAnimation + 0.3) % 1.0);
    final beamGradientV = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          accentColor.withValues(alpha: 0.2),
          accentColor.withValues(alpha: 0.4),
          accentColor.withValues(alpha: 0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(beamX - 2, 0, 4, size.height));

    canvas.drawRect(
      Rect.fromLTWH(beamX - 1, 0, 2, size.height),
      beamGradientV,
    );

    // ─── Intersection Dots with Pulse ───
    for (double x = 0; x <= size.width; x += gridSpacing) {
      for (double y = 0; y <= size.height; y += gridSpacing) {
        final edgeFadeX = _calculateEdgeFade(x, size.width);
        final edgeFadeY = _calculateEdgeFade(y, size.height);
        final edgeFade = edgeFadeX * edgeFadeY;
        
        if (edgeFade < 0.1) continue; // Skip nearly invisible dots
        
        // Pulse effect based on distance from beam
        final distFromBeamY = (y - beamY).abs();
        final distFromBeamX = (x - beamX).abs();
        final beamProximity = math.max(
          0.0,
          1.0 - math.min(distFromBeamY, distFromBeamX) / 100,
        );
        
        final dotRadius = 1.5 + beamProximity * 2;
        final dotOpacity = 0.15 + beamProximity * 0.4;
        
        final dotPaint = Paint()
          ..color = accentColor.withValues(alpha: dotOpacity * edgeFade)
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
        
        // Glow ring for dots near beam
        if (beamProximity > 0.5) {
          final glowPaint = Paint()
            ..color = accentColor.withValues(alpha: 0.1 * beamProximity * edgeFade)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1;
          canvas.drawCircle(Offset(x, y), dotRadius + 4, glowPaint);
        }
      }
    }
  }

  double _calculateEdgeFade(double position, double maxSize) {
    const fadeDistance = 80.0;
    if (position < fadeDistance) {
      return position / fadeDistance;
    } else if (position > maxSize - fadeDistance) {
      return (maxSize - position) / fadeDistance;
    }
    return 1.0;
  }

  @override
  bool shouldRepaint(_RenderGridPainter oldDelegate) =>
      gridAnimation != oldDelegate.gridAnimation ||
      beamAnimation != oldDelegate.beamAnimation;
}
