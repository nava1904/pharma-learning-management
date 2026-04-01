// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — PROJECT SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/project
// Status: Project module not yet connected to Serverpod backend
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design_system/pharma_design_system.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text('Applied Training Projects', style: PharmaTypography.headingLarge),
          const SizedBox(height: 8),
          Text(
            'Apply your compliance knowledge to real-world pharmaceutical scenarios',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // Coming Soon Card
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: PharmaColors.cardBg,
              borderRadius: PharmaRadius.cardRadius,
              border: Border.all(color: PharmaColors.borderLight),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 64,
                  color: PharmaColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Applied Projects — Coming Soon',
                  style: PharmaTypography.headingMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'GMP implementation plans, safety protocol reviews, and quality control case studies '
                  'will be available once the project module is connected to the Serverpod backend. '
                  'Projects will be linked to specific SOP versions and require e-signature upon submission.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: PharmaColors.infoBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Module under development · Awaiting Serverpod project endpoints',
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.infoText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

