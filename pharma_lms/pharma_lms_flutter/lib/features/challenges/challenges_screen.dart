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
// CHALLENGE DATA MODEL
// ═══════════════════════════════════════════════════════════════════════════════

class _ChallengeData {
  final int id;
  final String title;
  final String description;
  final int progress;
  final String reward;
  final String deadline;
  final int participants;

  const _ChallengeData({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.reward,
    required this.deadline,
    required this.participants,
  });
}

// Placeholder data — will be replaced with real API calls when gamification backend is ready
const _sampleChallenges = [
  _ChallengeData(
    id: 1,
    title: 'GMP Master Challenge',
    description: 'Complete all GMP modules with a score of 90% or higher',
    progress: 75,
    reward: '500 points',
    deadline: '7 days left',
    participants: 142,
  ),
  _ChallengeData(
    id: 2,
    title: 'Safety First',
    description: 'Complete Safety SOP course and pass the final exam',
    progress: 45,
    reward: '300 points',
    deadline: '14 days left',
    participants: 98,
  ),
  _ChallengeData(
    id: 3,
    title: 'Quality Champion',
    description: 'Achieve 100% in all Quality Control assessments',
    progress: 20,
    reward: '750 points',
    deadline: '21 days left',
    participants: 67,
  ),
  _ChallengeData(
    id: 4,
    title: 'Learning Streak',
    description: 'Complete at least one lesson every day for 30 days',
    progress: 60,
    reward: '1000 points',
    deadline: '18 days left',
    participants: 234,
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = _sampleChallenges;
    final completedCount = challenges.where((c) => c.progress >= 100).length;
    final totalPoints = 4250; // Placeholder

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Challenges', style: PharmaTypography.headingLarge),
          const SizedBox(height: 8),
          Text(
            'Complete challenges to earn points and badges',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─── Stats Row ───
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: PharmaSpacing.gridGap,
                crossAxisSpacing: PharmaSpacing.gridGap,
                childAspectRatio: 2.8,
                children: [
                  _StatCard(
                    title: 'Active Challenges',
                    value: '${challenges.length}',
                    icon: Icons.track_changes_rounded,
                    iconColor: PharmaColors.emerald600,
                  ),
                  _StatCard(
                    title: 'Completed',
                    value: '$completedCount',
                    icon: Icons.emoji_events_rounded,
                    iconColor: const Color(0xFFF59E0B), // amber-500
                  ),
                  _StatCard(
                    title: 'Total Points',
                    value: '$totalPoints',
                    icon: Icons.emoji_events_rounded,
                    iconColor: PharmaColors.textTertiary,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // ─── Challenges Grid (2 columns) ───
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 700 ? 1 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: PharmaSpacing.gridGap,
                  crossAxisSpacing: PharmaSpacing.gridGap,
                  childAspectRatio: 1.6,
                ),
                itemCount: challenges.length,
                itemBuilder: (context, index) => _ChallengeCard(challenge: challenges[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CHALLENGE CARD
// From React: White card with title, description, progress bar, meta info
// ═══════════════════════════════════════════════════════════════════════════════

class _ChallengeCard extends StatefulWidget {
  const _ChallengeCard({required this.challenge});

  final _ChallengeData challenge;

  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.challenge;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: PharmaDurations.fast,
        padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(color: PharmaColors.borderLight),
          boxShadow: _isHovered ? PharmaShadows.cardHoverShadow : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with trophy icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.title, style: PharmaTypography.headingSmall),
                      const SizedBox(height: 8),
                      Text(
                        c.description,
                        style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald100,
                    borderRadius: PharmaRadius.buttonRadius,
                  ),
                  child: Icon(Icons.emoji_events_rounded, size: 24, color: PharmaColors.emerald600),
                ),
              ],
            ),

            const Spacer(),

            // Progress bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progress', style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
                Text(
                  '${c.progress}%',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.emerald600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: PharmaRadius.pillRadius,
              child: LinearProgressIndicator(
                value: c.progress / 100,
                backgroundColor: PharmaColors.gray200,
                valueColor: AlwaysStoppedAnimation<Color>(PharmaColors.emerald600),
                minHeight: 6,
              ),
            ),

            const SizedBox(height: 16),

            // Meta info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 14, color: PharmaColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(c.deadline, style: PharmaTypography.caption),
                    const SizedBox(width: 16),
                    Icon(Icons.people_outline_rounded, size: 14, color: PharmaColors.textTertiary),
                    const SizedBox(width: 4),
                    Text('${c.participants}', style: PharmaTypography.caption),
                  ],
                ),
                Text(
                  c.reward,
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.emerald600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════════════════════════════════════════

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary)),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: PharmaTypography.headingLarge.copyWith(fontSize: 28)),
        ],
      ),
    );
  }
}
