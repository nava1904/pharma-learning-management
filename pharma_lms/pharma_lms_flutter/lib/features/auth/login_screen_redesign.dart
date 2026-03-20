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
/// PHARMA LMS — LOGIN SCREEN (Render-inspired Design)
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

    if (client.auth.isAuthenticated && ref.read(selectedRoleProvider) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onAuthenticated());
    }
  }

  @override
  void dispose() {
    _gridAnimController.dispose();
    _beamAnimController.dispose();
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
            child: const Icon(
              Icons.biotech_rounded,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: s2), // 16px
          const Text(
            'Pharma LMS',
            style: TextStyle(
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
                    VyuhLogo(height: s4, width: s4), // 32px
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
                    _buildStatItem('500+', 'Pharma\nCompanies'),
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

        // Serverpod SignInWidget
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
