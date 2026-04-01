import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/client.dart';
import '../../design_system/pharma_components.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/auth_provider.dart';
import 'oidc_sign_in_widget.dart';

/// ═══════════════════════════════════════════════════════════════════════════════════
/// Vyuh lms — login screen
/// ═══════════════════════════════════════════════════════════════════════════════════
///
/// DESIGN PHILOSOPHY (Inspired by world-class design principles)
/// ───────────────────────────────────────────────────────────────────────────────────
///
/// REFACTORING UI (Wathan & Schoger):
/// • Use whitespace generously — let elements breathe
/// • Shadows indicate elevation, not borders
/// • Limit color palette, use shades for hierarchy
/// • Typography: fewer sizes, more weight variation
///
/// DON'T MAKE ME THINK (Krug):
/// • Self-evident navigation — no instructions needed
/// • Clear visual hierarchy guides the eye
/// • Reduce noise, increase signal
///
/// LAWS OF UX (Yablonski):
/// • Fitts's Law: Large, easy-to-hit touch targets (min 44px)
/// • Hick's Law: Reduce choices to reduce decision time
/// • Miller's Law: Chunk information (7±2 items)
/// • Aesthetic-Usability: Beautiful things work better
///
/// APPLE HUMAN INTERFACE GUIDELINES:
/// • Clarity: Content is the focus
/// • Deference: UI helps, never competes
/// • Depth: Layers create hierarchy and context
///
/// UI IS COMMUNICATION (McKay):
/// • Every element communicates purpose
/// • Labels describe, placeholders suggest
/// • Error states are helpful, not punitive
/// ═══════════════════════════════════════════════════════════════════════════════════
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  // ─── State ───
  int _activeTab = 0; // 0 = Sign In, 1 = Create Account
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;
  int _passwordStrength = 0;
  final bool _rememberMe = true;

  // ─── Controllers ───
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  late AnimationController _meshAnimController;
  late AnimationController _revealAnimController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  // ═══════════════════════════════════════════════════════════════════════════════
  // DESIGN SYSTEM — Vyuh lms brand
  // ═══════════════════════════════════════════════════════════════════════════════
  // 
  // SPATIAL SYSTEM (4pt base, 8pt comfortable)
  // Following Apple's 8pt grid system for visual consistency
  // ───────────────────────────────────────────────────────────────────────────────
  static const double _space2 = 8;    // Tight spacing
  static const double _space3 = 12;   // Small spacing
  static const double _space4 = 16;   // Default spacing
  static const double _space5 = 20;   // Medium spacing
  static const double _space6 = 24;   // Comfortable spacing
  static const double _space8 = 32;   // Section spacing
  static const double _space10 = 40;  // Large spacing
  static const double _space12 = 48;  // XL spacing
  static const double _space16 = 64;  // XXL spacing

  // ───────────────────────────────────────────────────────────────────────────────
  // COLOR PALETTE
  // Refined palette with clear purpose for each color
  // ───────────────────────────────────────────────────────────────────────────────
  
  // Primary Brand — Vyuh Blue (Trustworthy, Professional)
  static const Color _brandPrimary = Color(0xFF0066FF);
  static const Color _brandPrimaryHover = Color(0xFF0052CC);
  static const Color _brandPrimaryLight = Color(0xFFE6F0FF);
  
  // Secondary — Teal (Security, Compliance)
  static const Color _brandTeal = Color(0xFF0D9488);
  static const Color _brandTealLight = Color(0xFFCCFBF1);
  
  // Accent — Amber (Attention, Audit)
  static const Color _brandAmber = Color(0xFFD97706);
  static const Color _brandAmberLight = Color(0xFFFEF3C7);
  
  // Semantic Colors
  static const Color _success = Color(0xFF059669);
  static const Color _warning = Color(0xFFEAB308);
  static const Color _error = Color(0xFFDC2626);
  static const Color _errorLight = Color(0xFFFEE2E2);
  
  // Neutral Palette (Based on Tailwind Gray)
  static const Color _gray50 = Color(0xFFF9FAFB);
  static const Color _gray100 = Color(0xFFF3F4F6);
  static const Color _gray200 = Color(0xFFE5E7EB);
  static const Color _gray300 = Color(0xFFD1D5DB);
  static const Color _gray400 = Color(0xFF9CA3AF);
  static const Color _gray500 = Color(0xFF6B7280);
  static const Color _gray600 = Color(0xFF4B5563);
  static const Color _gray700 = Color(0xFF374151);
  static const Color _gray800 = Color(0xFF1F2937);
  static const Color _gray900 = Color(0xFF111827);
  
  // Text Colors (Clear hierarchy per Refactoring UI)
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF4B5563);
  static const Color _textTertiary = Color(0xFF6B7280);
  static const Color _textMuted = Color(0xFF9CA3AF);
  
  // Surface Colors
  static const Color _surfaceWhite = Color(0xFFFFFFFF);
  static const Color _surfaceBg = Color(0xFFF9FAFB);
  
  // Dark Theme (Left Panel)
  static const Color _darkBg = Color(0xFF0F172A);
  static const Color _darkSurface = Color(0xFF1E293B);
  static const Color _darkBorder = Color(0xFF334155);

  // ───────────────────────────────────────────────────────────────────────────────
  // TYPOGRAPHY (Following Apple SF Pro principles)
  // Large titles: Bold, tight tracking
  // Body: Regular weight, comfortable line height
  // Labels: Medium weight, slight tracking
  // ───────────────────────────────────────────────────────────────────────────────
  static const TextStyle _displayLarge = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    letterSpacing: -2.0,
    height: 1.1,
    color: Colors.white,
  );
  
  static const TextStyle _headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.2,
    color: _textPrimary,
  );
  
  static const TextStyle _headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    color: _textPrimary,
  );
  
  static const TextStyle _titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.4,
    color: _textPrimary,
  );
  
  static const TextStyle _bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: _textSecondary,
  );
  
  static const TextStyle _bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: _textSecondary,
  );
  
  static const TextStyle _labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.4,
    color: _textPrimary,
  );
  
  static const TextStyle _labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: _textSecondary,
  );
  
  static const TextStyle _labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
    color: _textTertiary,
  );

  // ───────────────────────────────────────────────────────────────────────────────
  // ELEVATION & SHADOWS (Refactoring UI: Shadows > Borders)
  // ───────────────────────────────────────────────────────────────────────────────
  static List<BoxShadow> get _shadowSm => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.05),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
  
  static List<BoxShadow> get _shadowMd => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.04),
      blurRadius: 2,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get _shadowLg => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.1),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get _shadowXl => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.12),
      blurRadius: 48,
      offset: const Offset(0, 24),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // ───────────────────────────────────────────────────────────────────────────────
  // BORDER RADIUS (Consistent roundness)
  // ───────────────────────────────────────────────────────────────────────────────
  static const double _radiusSm = 6;
  static const double _radiusMd = 10;
  static const double _radiusLg = 14;
  static const double _radiusXl = 20;
  static const double _radiusFull = 9999;

  // ───────────────────────────────────────────────────────────────────────────────
  // SHORTHAND ALIASES — For cleaner code (non-const contexts only)
  // ───────────────────────────────────────────────────────────────────────────────
  // Spacing
  static const s1 = 4.0;
  static const s2 = _space2;
  static const s3 = _space3;
  static const s4 = _space4;
  static const s5 = _space5;
  static const s6 = _space6;
  static const s7 = _space8;
  
  // Colors
  static const brandPrimary = _brandPrimary;
  static const brandTeal = _brandTeal;
  static const brandGold = _brandAmber;
  static const danger = _error;
  static const success = _success;
  static const warning = _warning;
  static const gray50 = _gray50;
  static const gray100 = _gray100;
  static const gray200 = _gray200;
  static const gray400 = _gray400;
  static const surfacePrimary = _surfaceWhite;
  static const surfaceBg = _surfaceBg;
  static const textPrimary = _textPrimary;
  static const textSecondary = _textSecondary;
  static const textTertiary = _textTertiary;
  static const textQuaternary = _textMuted;

  @override
  void initState() {
    super.initState();
    _meshAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);

    _revealAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _emailController.addListener(_clearEmailError);
    _passwordController.addListener(_onPasswordChanged);

    if (client.auth.isAuthenticated && ref.read(selectedRoleProvider) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onAuthenticated());
    }
  }

  @override
  void dispose() {
    _meshAnimController.dispose();
    _revealAnimController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _clearEmailError() {
    if (_emailError != null) setState(() => _emailError = null);
  }

  void _onPasswordChanged() {
    if (_passwordError != null) setState(() => _passwordError = null);
    _calcPasswordStrength(_passwordController.text);
  }

  void _calcPasswordStrength(String val) {
    int score = 0;
    if (val.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(val) && RegExp(r'[a-z]').hasMatch(val)) {
      score++;
    }
    if (RegExp(r'\d').hasMatch(val)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(val)) score++;
    setState(() => _passwordStrength = score);
  }

  bool _validateForm() {
    bool valid = true;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Email validation
    final emailRe = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (email.isEmpty || !emailRe.hasMatch(email)) {
      setState(() => _emailError = 'Please enter a valid work email address.');
      valid = false;
    }

    // Password validation
    if (password.isEmpty) {
      setState(() => _passwordError = 'Please enter your password.');
      valid = false;
    }

    return valid;
  }

  Future<void> _handleSignIn() async {
    if (!_validateForm()) {
      if (_emailError != null) {
        _emailFocusNode.requestFocus();
      } else if (_passwordError != null) {
        _passwordFocusNode.requestFocus();
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Use Serverpod's EmailAuthController for real authentication
      final authController = EmailAuthController(
        client: client,
        onAuthenticated: () {
          // Real Serverpod session is now established — resolve role & navigate
          if (mounted) _onAuthenticated();
        },
        onError: (error) {
          if (mounted) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Sign-in failed: $error'),
                backgroundColor: danger,
              ),
            );
          }
        },
      );

      authController.emailController.text = email;
      authController.passwordController.text = password;
      await authController.login();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in failed: $e'),
            backgroundColor: danger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _onAuthenticated() async {
    try {
      final profile = await client.modules.serverpod_auth_core.userProfileInfo
          .get();
      final email = profile.email;
      if (email == null || email.isEmpty) {
        if (mounted) {
          loginWithAuthEmail(ref, context, 'employee@pharmacorp.demo');
        }
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
                content: Text(
                  'MFA verification required. Please sign in again.',
                ),
                backgroundColor: danger,
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
            backgroundColor: danger,
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
        builder: (ctx, setDialogState) {
          return AlertDialog(
            backgroundColor: surfacePrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: brandTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(PharmaRadius.lg),
                  ),
                  child: const Icon(Icons.shield, color: brandTeal, size: 18),
                ),
                const SizedBox(width: s2),
                const Text(
                  'Two-Factor Authentication',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter the 6-digit code from your authenticator app.',
                  style: TextStyle(
                    fontSize: 15,
                    color: textTertiary,
                    height: 1.5,
                  ),
                ),
                if (error != null) ...[
                  const SizedBox(height: s2),
                  Container(
                    padding: const EdgeInsets.all(s2),
                    decoration: BoxDecoration(
                      color: danger.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      border: Border.all(color: danger.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: danger,
                          size: 18,
                        ),
                        const SizedBox(width: s1),
                        Expanded(
                          child: Text(
                            error!,
                            style: const TextStyle(fontSize: 13, color: danger),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: s3),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  autofocus: true,
                  enabled: !verifying,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 12,
                    color: textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: '• • • • • •',
                    hintStyle: const TextStyle(
                      fontSize: 28,
                      color: gray400,
                      letterSpacing: 12,
                    ),
                    counterText: '',
                    filled: true,
                    fillColor: gray50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      borderSide: const BorderSide(color: gray200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      borderSide: const BorderSide(color: gray200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(PharmaRadius.lg),
                      borderSide: const BorderSide(
                        color: brandPrimary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: s2),
                  ),
                  onChanged: (v) => setDialogState(() => code = v),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: verifying
                    ? null
                    : () => Navigator.of(ctx).pop(false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: verifying
                    ? null
                    : () async {
                        if (code.length != 6) {
                          setDialogState(
                            () => error = 'Enter a complete 6-digit code',
                          );
                          return;
                        }
                        setDialogState(() {
                          verifying = true;
                          error = null;
                        });
                        try {
                          final ok = await client.mfa.verifyMfa(code);
                          if (ctx.mounted) Navigator.of(ctx).pop(ok);
                        } catch (_) {
                          if (ctx.mounted) {
                            setDialogState(() {
                              verifying = false;
                              error = 'Invalid code. Please try again.';
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: s3,
                    vertical: s2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(PharmaRadius.lg),
                  ),
                ),
                child: verifying
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Verify',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
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
    final isWideScreen = screenWidth > 960;

    return Scaffold(
      backgroundColor: surfaceBg,
      body: isWideScreen ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT — Split panel
  // ═══════════════════════════════════════════════════════════════════════════════
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // ─── LEFT PANEL (Brand) ───
        Expanded(child: _buildBrandPanel()),
        // ─── RIGHT PANEL (Form) — 480px fixed width ───
        Container(
          width: 480,
          decoration: BoxDecoration(
            color: surfacePrimary,
            border: Border(
              left: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 64,
                offset: const Offset(-24, 0),
              ),
            ],
          ),
          child: _buildFormPanel(),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT — Stacked
  // ═══════════════════════════════════════════════════════════════════════════════
  Widget _buildMobileLayout() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A1628), Color(0xFF0D1F3C)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(s2),
          child: Column(
            children: [
              _buildMobileHeader(),
              const SizedBox(height: s3),
              Container(
                decoration: BoxDecoration(
                  color: surfacePrimary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 12),
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

  Widget _buildMobileHeader() {
    return Column(
      children: [
        const SizedBox(height: s2),
        VyuhLogo(height: 48, color: Colors.white),
        const SizedBox(height: s2),
        Text(
          'Enterprise Edition',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.02,
            color: Colors.white.withValues(alpha: 0.36),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // BRAND PANEL — Left side with mesh gradient + trust signals
  // Principle: Aesthetic Integrity, Visibility (trust before action)
  // ═══════════════════════════════════════════════════════════════════════════════
  Widget _buildBrandPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF0D1F3C), Color(0xFF071624)],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated mesh gradient background
          AnimatedBuilder(
            animation: _meshAnimController,
            builder: (context, child) {
              return CustomPaint(
                painter: _MeshGradientPainter(
                  animation: _meshAnimController.value,
                ),
                child: const SizedBox.expand(),
              );
            },
          ),
          // Grid pattern overlay
          CustomPaint(
            painter: _GridPatternPainter(),
            child: const SizedBox.expand(),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(s5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Nav ───
                  _buildNav(),
                  const Spacer(),
                  // ─── Hero ───
                  _buildHero(),
                  const SizedBox(height: s6),
                  // ─── Compliance Chips ───
                  _buildComplianceChips(),
                  const Spacer(),
                  // ─── Stats ───
                  _buildStats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNav() {
    return FadeTransition(
      opacity: _revealAnimController,
      child: SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _revealAnimController,
                curve: Curves.easeOut,
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(
              children: [
                VyuhLogo(height: 28, color: Colors.white),
                const SizedBox(width: s2),
                Text(
                  'Enterprise Edition',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.02,
                    color: Colors.white.withValues(alpha: 0.36),
                  ),
                ),
              ],
            ),
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: success,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: success.withValues(alpha: 0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'All Systems Operational',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.04,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoMark() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xE6006FED), Color(0xF20050B4)],
        ),
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: brandPrimary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.school_rounded,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kicker
        Row(
          children: [
            Container(
              width: 24,
              height: 1.5,
              decoration: BoxDecoration(
                color: brandPrimary.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            const SizedBox(width: s1),
            Text(
              'VALIDATED · GxP COMPLIANT · FDA READY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.12 * 11,
                color: const Color(0xFF0093FF).withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: s4),
        // Headline
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.04 * 48,
              height: 1.06,
              color: Colors.white,
            ),
            children: [
              const TextSpan(text: 'Training\n'),
              TextSpan(
                text: 'Validated.\n',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF60A5FA), Color(0xFF34D3C0)],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
              const TextSpan(text: 'Compliant.'),
            ],
          ),
        ),
        const SizedBox(height: s3),
        // Body
        Text(
          'The enterprise LMS built ground-up for pharmaceutical regulations.\nFull audit trail, cryptographic e-signatures, and SOP-triggered\nretraining — validated out of the box.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.7,
            color: Colors.white.withValues(alpha: 0.42),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceChips() {
    final chips = [
      '21 CFR Part 11',
      'EU GMP Annex 11',
      'ALCOA+',
      'GAMP 5 Cat. 4',
      'GxP Validated',
      'ISO 27001',
    ];

    return Wrap(
      spacing: s1,
      runSpacing: s1,
      children: chips.map((label) => _ComplianceChip(label: label)).toList(),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.only(top: s3),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      child: const Row(
        children: [
          _StatItem(value: '500', suffix: '+', label: 'Enterprise clients'),
          SizedBox(width: s4),
          _StatItem(value: '2M', suffix: '+', label: 'Trained Employees'),
          SizedBox(width: s4),
          _StatItem(value: '99.9', suffix: '%', label: 'Audit Pass Rate'),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // FORM PANEL — Right side with sign-in form
  // Principles: Simplicity, Efficiency, Affordance, Feedback, Error Prevention
  // ═══════════════════════════════════════════════════════════════════════════════
  Widget _buildFormPanel() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _buildFormContent(),
          ),
        ),
        _buildFormFooter(),
      ],
    );
  }

  // FIX 12: Form padding locked at 56px horizontal, 48px top
  Widget _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(s7, s6, s7, s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // FIX 8: Segmented control ALWAYS present at top
          _buildSegmentedControl(),
          const SizedBox(height: s5),
          // FIX 2: Form header (no redundant "Sign X with email")
          _buildFormHeader(),
          const SizedBox(height: s4),
          // FIX 3: MFA notice consistent across tabs
          _buildMfaNotice(),
          const SizedBox(height: s4),
          // ─── Sign In Form or Create Account ───
          if (_activeTab == 0) _buildSignInForm() else _buildSignUpForm(),
        ],
      ),
    );
  }

  // FIX 8: Segmented control always present
  Widget _buildSegmentedControl() {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: gray50,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
      ),
      child: Row(
        children: [
          _buildSegmentButton('Sign In', 0),
          const SizedBox(width: 2),
          _buildSegmentButton('Create Account', 1),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, int index) {
    final isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isActive ? surfacePrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: -0.1,
              color: isActive ? textPrimary : textTertiary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    final isSignIn = _activeTab == 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSignIn ? 'SECURE ACCESS' : 'NEW ACCOUNT',
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: brandPrimary,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          isSignIn ? 'Welcome back' : 'Join your team',
          style: const TextStyle(
            fontFamily: 'Instrument Serif',
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
            height: 1.1,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isSignIn
              ? 'Sign in to your compliance dashboard.'
              : 'Create a validated account to begin compliance training.',
          style: const TextStyle(
            fontSize: 13,
            color: textTertiary,
            height: 1.55,
          ),
        ),
      ],
    );
  }

  // FIX 3: MFA card — identical markup, same teal color, same icon across both tabs
  Widget _buildMfaNotice() {
    final isSignIn = _activeTab == 0;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: brandTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: brandTeal.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: brandTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(PharmaRadius.lg),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: brandTeal,
              size: 18,
            ),
          ),
          const SizedBox(width: s2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSignIn ? 'Protected by MFA' : 'MFA setup required',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                    color: brandTeal,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  isSignIn
                      ? 'Two-factor authentication required · 21 CFR §11.200(a)'
                      : 'Configured during onboarding · mandatory for all GxP access · 21 CFR §11.200(a)',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: textTertiary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ─── Serverpod Auth Widget ───
        SignInWidget(
          client: client,
          onAuthenticated: _onAuthenticated,
          onError: (error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sign-in failed: $error'),
                  backgroundColor: danger,
                ),
              );
            }
          },
        ),
        const SizedBox(height: s3),

        // ─── Divider ───
        _buildDivider(),
        const SizedBox(height: s3),

        // ─── SSO Button ───
        _buildSsoButton(),

        // ─── Dev-only Demo Mode ───
        if (!kReleaseMode) ...[
          const SizedBox(height: s4),
          _buildDevModeSection(),
        ],
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ─── Full Name Field ───
        _buildFieldLabel('FULL NAME'),
        const SizedBox(height: 6),
        _buildTextInput(
          hintText: 'Dr. Jane Smith',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: s2),

        // ─── Email Field ───
        _buildFieldLabel('WORK EMAIL'),
        const SizedBox(height: 6),
        _buildEmailInput(),
        if (_emailError != null) _buildErrorMessage(_emailError!),
        const SizedBox(height: s2),

        // ─── Password Field with Strength ───
        _buildFieldLabel('CREATE PASSWORD'),
        const SizedBox(height: 6),
        _buildPasswordInput(isNewPassword: true),
        const SizedBox(height: s1),
        _buildPasswordStrengthBar(),
        const SizedBox(height: 5),
        _buildPasswordStrengthHint(),
        const SizedBox(height: s4),

        // ─── Primary CTA ───
        _buildPrimaryButton(
          label: 'Create Validated Account',
          icon: Icons.person_add,
        ),
        const SizedBox(height: s3),

        // ─── Divider ───
        _buildDivider(),
        const SizedBox(height: s3),

        // ─── SSO Button ───
        _buildSsoButton(),
      ],
    );
  }

  Widget _buildFieldLabel(String label, {String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.04 * 11,
            color: textSecondary,
          ),
        ),
        if (action != null)
          GestureDetector(
            onTap: () {
              // TODO: Implement forgot password
            },
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: brandPrimary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextInput({
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: gray50,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.12),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(icon, size: 16, color: gray400),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.1,
                color: textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: gray400,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: s2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    final hasError = _emailError != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 48,
      decoration: BoxDecoration(
        color: hasError ? danger.withValues(alpha: 0.04) : gray50,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(
          color: hasError ? danger : Colors.black.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: hasError
            ? [
                BoxShadow(
                  color: danger.withValues(alpha: 0.08),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.email_outlined,
              size: 16,
              color: hasError ? danger : gray400,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.1,
                color: textPrimary,
              ),
              decoration: const InputDecoration(
                hintText: 'name@company.com',
                hintStyle: TextStyle(
                  color: gray400,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: s2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInput({bool isNewPassword = false}) {
    final hasError = _passwordError != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 48,
      decoration: BoxDecoration(
        color: hasError ? danger.withValues(alpha: 0.04) : gray50,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(
          color: hasError ? danger : Colors.black.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: hasError
            ? [
                BoxShadow(
                  color: danger.withValues(alpha: 0.08),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.lock_outline,
              size: 16,
              color: hasError ? danger : gray400,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: _obscurePassword,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.1,
                color: textPrimary,
              ),
              decoration: InputDecoration(
                hintText: isNewPassword
                    ? '12+ chars · mixed case · symbols'
                    : 'Your password',
                hintStyle: const TextStyle(
                  color: gray400,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: s2),
              ),
            ),
          ),
          // Toggle visibility button
          GestureDetector(
            onTap: () => setState(() => _obscurePassword = !_obscurePassword),
            child: Padding(
              padding: const EdgeInsets.all(s1),
              child: Container(
                padding: const EdgeInsets.all(s1),
                decoration: BoxDecoration(
                  color: _obscurePassword ? Colors.transparent : gray100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 16,
                  color: _obscurePassword ? gray400 : textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthBar() {
    final colors = [
      gray200, // 0
      danger, // 1
      warning, // 2
      success, // 3
      brandPrimary, // 4
    ];
    final activeColor = colors[_passwordStrength.clamp(0, 4)];

    return Row(
      children: List.generate(4, (i) {
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            height: 3,
            margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
            decoration: BoxDecoration(
              color: i < _passwordStrength ? activeColor : gray200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPasswordStrengthHint() {
    final hints = [
      'Required: 12+ chars, uppercase, lowercase, numbers, symbols (21 CFR §11.300)',
      'Too weak — add uppercase, numbers, and symbols',
      'Getting there — add symbols and vary your case',
      'Strong password',
      'Very strong — meets 21 CFR §11.300 ✓',
    ];
    final colors = [textQuaternary, danger, warning, success, brandPrimary];
    final index = _passwordStrength.clamp(0, 4);

    return Text(
      hints[index],
      style: TextStyle(
        fontSize: 11,
        color: colors[index],
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 11,
          color: danger,
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({String? label, IconData? icon}) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: brandPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: brandPrimary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.lg),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon ?? Icons.login, size: 16),
                  const SizedBox(width: s1),
                  Text(
                    label ?? 'Sign In Securely',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.12))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: s2),
          child: const Text(
            'or',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: textQuaternary,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.12))),
      ],
    );
  }

  Widget _buildSsoButton() {
    return SizedBox(
      height: 46,
      child: OidcSignInWidget(
        onAuthenticated: _onAuthenticated,
        onError: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('SSO sign-in failed: $error'),
                backgroundColor: danger,
              ),
            );
          }
        },
      ),
    );
  }

  // FIX 13: Dev tools hidden, only show in debug mode with gold styling
  Widget _buildDevModeSection() {
    return Container(
      padding: const EdgeInsets.all(s2),
      decoration: BoxDecoration(
        color: brandGold.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: brandGold.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report_outlined, size: 14, color: brandGold),
              const SizedBox(width: 6),
              const Text(
                'Development Mode',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: brandGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: s2),
          Wrap(
            spacing: s1,
            runSpacing: s1,
            children: [
              _DevButton(
                label: 'Employee',
                onTap: () => loginWithRole(ref, context, AppRole.employee),
              ),
              _DevButton(
                label: 'Admin',
                onTap: () => loginWithRole(ref, context, AppRole.admin),
              ),
              _DevButton(
                label: 'QA',
                onTap: () => loginWithRole(ref, context, AppRole.qa),
              ),
              _DevButton(
                label: 'Trainer',
                onTap: () => loginWithRole(ref, context, AppRole.trainer),
              ),
              _DevButton(
                label: 'Auditor',
                onTap: () => loginWithRole(ref, context, AppRole.auditor),
              ),
            ],
          ),
          const SizedBox(height: s2),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final msg = await client.seed.runSeed();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(msg)),
                      );
                    }
                  },
                  child: const Text(
                    'Seed Data',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final msg = await client.seed.runMvpSeed();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(msg)),
                      );
                    }
                  },
                  child: const Text('MVP Seed', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: s7, vertical: s2),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Audit trail badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: brandGold.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: brandGold.withValues(alpha: 0.22)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: brandGold,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'AUDIT TRAIL ACTIVE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.06 * 11,
                    color: brandGold,
                  ),
                ),
              ],
            ),
          ),
          // Footer links
          const Row(
            children: [
              _FooterLink(label: 'Privacy'),
              _FooterLink(label: 'Terms'),
              _FooterLink(label: 'Help'),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════════

// FIX 5: Consistent compliance chip style
class _ComplianceChip extends StatelessWidget {
  const _ComplianceChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.038),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.078)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
              color: Colors.white.withValues(alpha: 0.36),
            ),
          ),
        ],
      ),
    );
  }
}

// FIX 11: Stats with white numerals, blue suffix
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.suffix,
    required this.label,
  });
  final String value;
  final String suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontFamily: 'Instrument Serif',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.white, // FIX 11: White numerals
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: suffix,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5AB4FF), // FIX 11: Blue suffix
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.6,
            color: Colors.white.withValues(alpha: 0.26),
          ),
        ),
      ],
    );
  }
}

class _DevButton extends StatelessWidget {
  const _DevButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _LoginScreenState.gray200),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _LoginScreenState.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _LoginScreenState.textQuaternary,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTERS
// ═══════════════════════════════════════════════════════════════════════════════════

class _MeshGradientPainter extends CustomPainter {
  _MeshGradientPainter({required this.animation});
  final double animation;

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = 0.8 + (animation * 0.2);

    // Blue gradient at top-left
    final bluePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.6, -0.4),
        radius: 0.6,
        colors: [
          const Color(0xFF006FED).withValues(alpha: 0.13 * opacity),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bluePaint);

    // Teal gradient at bottom-left
    final tealPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, 0.5),
        radius: 0.55,
        colors: [
          const Color(0xFF00897B).withValues(alpha: 0.10 * opacity),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), tealPaint);
  }

  @override
  bool shouldRepaint(_MeshGradientPainter oldDelegate) =>
      animation != oldDelegate.animation;
}

// FIX 5: Consistent dot grid pattern (same opacity, same spacing everywhere)
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.055)
      ..style = PaintingStyle.fill;

    const spacing = 38.0;
    const dotRadius = 0.8;

    // Create radial mask effect for dot grid
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        // Calculate distance from mask center (35% from left, 45% from top)
        final centerX = size.width * 0.35;
        final centerY = size.height * 0.45;
        final dx = x - centerX;
        final dy = y - centerY;
        final distance =
            (dx * dx / (size.width * 0.75 * size.width * 0.75) +
                    dy * dy / (size.height * 0.85 * size.height * 0.85))
                .clamp(0.0, 1.0);

        if (distance < 0.72) {
          final opacity = (1 - distance / 0.72) * 0.055;
          paint.color = Colors.white.withValues(alpha: opacity);
          canvas.drawCircle(Offset(x, y), dotRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) => false;
}
