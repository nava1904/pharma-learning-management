import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Global breadcrumb widget (plan 7A). Use in top bar or content area.
class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final valid = items.where((x) => x.isNotEmpty).toList();
    if (valid.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < valid.length; i++) ...[
          if (i > 0)
            Icon(Icons.chevron_right, size: 18, color: AppColors.slate400),
          Text(
            valid[i],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: i < valid.length - 1
                      ? AppColors.slate600
                      : AppColors.slate900,
                  fontWeight:
                      i == valid.length - 1 ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
        ],
      ],
    );
  }
}

/// Derives breadcrumb labels from the current GoRouter path (plan 7A).
List<String> breadcrumbFromPath(String path) {
  if (path.isEmpty || path == '/') return [];
  final segments = path.split('/').where((s) => s.isNotEmpty).toList();
  if (segments.isEmpty) return [];

  const labels = <String, String>{
    'employee': 'My Dashboard',
    'training-history': 'Training History',
    'mfa': 'MFA Enrollment',
    'admin': 'Administration',
    'training-waivers': 'Training Waivers',
    'health': 'Health',
    'bulk-import': 'Bulk Import',
    'sop-coverage': 'SOP Coverage',
    'learning': 'My Learning',
    'courses': 'Course Catalog',
    'training-timeline': 'Training Timeline',
    'documents': 'SOP Documents',
    'quality-events': 'Quality Events',
    'compliance-report': 'Compliance',
    'analytics': 'Analytics',
    'audit-trail': 'Audit Trail',
    'qa': 'QA Portal',
    'training-matrix': 'Training Matrix',
    'course-builder': 'Course Builder',
    'inspection-management': 'Inspection Management',
    'event-triggers': 'Event Triggers',
    'auditor': 'Auditor Portal',
    'esignature-verification': 'E-Signature Verification',
    'config-change-history': 'Config Change History',
  };

  final result = <String>[];
  var prefix = '';
  for (var i = 0; i < segments.length; i++) {
    final seg = segments[i];
    prefix = prefix.isEmpty ? '/$seg' : '$prefix/$seg';
    final label = labels[seg] ?? _humanize(seg);
    result.add(label);
  }
  return result;
}

String _humanize(String segment) {
  if (segment.isEmpty) return segment;
  final withoutHyphens = segment.replaceAll('-', ' ');
  return withoutHyphens[0].toUpperCase() + withoutHyphens.substring(1);
}
