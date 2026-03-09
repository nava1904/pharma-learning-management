import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auditor_session_provider.dart';

/// Auditor inspection portal. Shows "AUDIT COPY" watermark when accessed via token.
class AuditorPortalScreen extends ConsumerStatefulWidget {
  const AuditorPortalScreen({super.key, this.auditorToken});

  final String? auditorToken;

  @override
  ConsumerState<AuditorPortalScreen> createState() =>
      _AuditorPortalScreenState();
}

class _AuditorPortalScreenState extends ConsumerState<AuditorPortalScreen> {
  String? _token;
  AuditorSession? _session;
  bool _validating = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _token = widget.auditorToken;
    if (_token != null && _token!.isNotEmpty) {
      _validateToken();
    } else {
      setState(() => _validating = false);
    }
  }

  Future<void> _validateToken() async {
    try {
      final result =
          await client.inspection.validateAuditorToken(token: _token!);
      if (mounted) {
        if (result == null) {
          setState(() {
            _validating = false;
            _error = 'Invalid or expired token';
          });
        } else {
          final id = result['inspectionRecordId'] as int?;
          if (id == null) {
            setState(() {
              _validating = false;
              _error = 'Invalid token response';
            });
          } else {
            setState(() {
              _validating = false;
              _session = AuditorSession(
                inspectionRecordId: id,
                scopeDescription: result['scopeDescription'] as String?,
                expiresAt: result['expiresAt'] as String?,
                siteName: result['siteName'] as String?,
              );
            });
            _logPageView('/auditor', 'Auditor Portal');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _validating = false;
          _error = 'Failed to validate: $e';
        });
      }
    }
  }

  Future<void> _logPageView(String pageUrl, String pageTitle) async {
    if (_session == null) return;
    try {
      await client.inspection.logAuditorPageView(
        inspectionRecordId: _session!.inspectionRecordId,
        pageUrl: pageUrl,
        pageTitle: pageTitle,
      );
    } catch (_) {}
  }

  void _navigateWithToken(String path, String pageTitle) {
    final tokenParam = _token != null ? '?token=$_token' : '';
    context.push('$path$tokenParam');
    _logPageView(path, pageTitle);
  }

  @override
  Widget build(BuildContext context) {
    if (_validating) {
      return Scaffold(
        appBar: AppBar(title: const Text('Auditor Inspection Portal')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Auditor Inspection Portal')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: AppColors.destructive),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final showWatermark = _session != null;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: showWatermark
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.go('/'),
                  )
                : null,
            title: Text(
              showWatermark
                  ? 'Auditor Portal - ${_session!.siteName ?? "Inspection"}'
                  : 'Auditor Inspection Portal',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showWatermark && _session!.scopeDescription != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.info.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.info),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Scope: ${_session!.scopeDescription}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                _SectionHeader(
                  icon: Icons.people_alt_outlined,
                  title: 'Training Records',
                  color: AppColors.indigo600,
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount =
                        constraints.maxWidth > 700 ? 2 : 1;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.2,
                      children: [
                        _AuditorCard(
                          icon: Icons.person_search,
                          iconColor: AppColors.indigo600,
                          title: 'Employee Search',
                          subtitle: 'Search employees with full training chain',
                          onTap: () => _navigateWithToken(
                            '/auditor/employee-search',
                            'Employee Search',
                          ),
                        ),
                        _AuditorCard(
                          icon: Icons.assignment_turned_in,
                          iconColor: AppColors.indigo600,
                          title: 'SOP Coverage',
                          subtitle: 'Qualified vs non-qualified per SOP version',
                          onTap: () => _navigateWithToken(
                            '/auditor/sop-coverage',
                            'SOP Coverage',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                _SectionHeader(
                  icon: Icons.verified_user,
                  title: 'Compliance & Audit',
                  color: AppColors.success,
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount =
                        constraints.maxWidth > 700 ? 2 : 1;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.2,
                      children: [
                        _AuditorCard(
                          icon: Icons.assessment,
                          iconColor: AppColors.success,
                          title: 'Compliance Report',
                          subtitle: 'Department compliance and audit readiness',
                          onTap: () => _navigateWithToken(
                            '/compliance-report',
                            'Compliance Report',
                          ),
                        ),
                        _AuditorCard(
                          icon: Icons.history,
                          iconColor: AppColors.info,
                          title: 'Audit Trail',
                          subtitle: 'Immutable audit logs for inspection',
                          onTap: () => _navigateWithToken(
                            '/audit-trail',
                            'Audit Trail',
                          ),
                        ),
                        _AuditorCard(
                          icon: Icons.draw,
                          iconColor: AppColors.slate700,
                          title: 'E-Signature Verification',
                          subtitle: 'Verify electronic signature records',
                          onTap: () => _navigateWithToken(
                            '/esignature-verification',
                            'E-Signature Verification',
                          ),
                        ),
                        _AuditorCard(
                          icon: Icons.download,
                          iconColor: AppColors.slate700,
                          title: 'Export for Inspection',
                          subtitle: 'Generate inspection-ready PDF reports',
                          onTap: () => _navigateWithToken(
                            '/compliance-report',
                            'Compliance Report',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                _SectionHeader(
                  icon: Icons.settings,
                  title: 'Configuration',
                  color: AppColors.warning,
                ),
                const SizedBox(height: 12),
                _AuditorCard(
                  icon: Icons.change_history,
                  iconColor: AppColors.warning,
                  title: 'Config Change History',
                  subtitle: 'Configuration change audit trail',
                  onTap: () => _navigateWithToken(
                    '/auditor/config-change-history',
                    'Config Change History',
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showWatermark)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'AUDIT COPY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 6,
                    ),
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slate800,
              ),
        ),
      ],
    );
  }
}

class _AuditorCard extends StatelessWidget {
  const _AuditorCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.slate200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 24, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.slate400),
            ],
          ),
        ),
      ),
    );
  }
}
