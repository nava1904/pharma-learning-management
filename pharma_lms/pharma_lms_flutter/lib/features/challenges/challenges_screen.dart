// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — CHALLENGES SCREEN (REACT REFERENCE MATCH)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Matches React ref2: Challenges.tsx
// Shows gamification challenges with progress, points, and participants
//
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design_system/pharma_design_system.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Compliance Challenges', style: PharmaTypography.headingLarge),
          const SizedBox(height: 8),
          Text(
            'Track your GMP training goals and compliance milestones',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─── Coming Soon Banner ───
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
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: PharmaColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Compliance Challenges — Coming Soon',
                  style: PharmaTypography.headingMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Gamified GMP challenges, SOP completion streaks, and team-based compliance goals '
                  'will be available once the gamification module is connected to the backend.',
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
                    'Module under development · Awaiting Serverpod gamification endpoints',
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
