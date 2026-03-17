// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — PROJECT SCREEN — Matches React ref2 Project.tsx
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/project
// Design: 4 stat cards + 2-col project cards with progress, status badges
// Backend: Placeholder data (project module not in Serverpod yet)
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Projects', style: PharmaTypography.headingLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Apply your knowledge to real-world scenarios',
                    style: PharmaTypography.body,
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Create new project
                },
                icon: const Icon(Icons.add_rounded, size: 20),
                label: const Text('New Project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(PharmaRadius.lg),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // Stats
          _buildStats(),
          const SizedBox(height: PharmaSpacing.sectionGap),

          // Projects grid
          _buildProjectsGrid(),
        ],
      ),
    );
  }

  // ─── STATS ───────────────────────────────────────────────────────────────────
  Widget _buildStats() {
    final stats = [
      _StatData('Total Projects', '${_projects.length}', PharmaColors.textQuaternary),
      _StatData('In Progress', '${_projects.where((p) => p.status == 'in-progress').length}', PharmaColors.info),
      _StatData('Completed', '${_projects.where((p) => p.status == 'completed').length}', PharmaColors.emerald600),
      _StatData('Not Started', '${_projects.where((p) => p.status == 'not-started').length}', PharmaColors.textQuaternary),
    ];

    return Row(
      children: stats.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: entry.key < stats.length - 1 ? PharmaSpacing.gridGap : 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
              decoration: BoxDecoration(
                color: PharmaColors.cardBg,
                borderRadius: BorderRadius.circular(PharmaRadius.lg),
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.value.label, style: PharmaTypography.body),
                      Icon(Icons.folder_outlined, size: 20, color: entry.value.iconColor),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(entry.value.value, style: PharmaTypography.statNumber),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── PROJECTS GRID ───────────────────────────────────────────────────────────
  Widget _buildProjectsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
        return Wrap(
          spacing: PharmaSpacing.gridGap,
          runSpacing: PharmaSpacing.gridGap,
          children: _projects.map((project) {
            final cardWidth = crossAxisCount == 2
                ? (constraints.maxWidth - PharmaSpacing.gridGap) / 2
                : constraints.maxWidth;
            return SizedBox(
              width: cardWidth,
              child: _ProjectCard(project: project),
            );
          }).toList(),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PROJECT CARD — Matches React: bg-white rounded-lg border p-6 hover:shadow-md
// ═══════════════════════════════════════════════════════════════════════════════

class _ProjectCard extends StatelessWidget {
  final _ProjectData project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: BorderRadius.circular(PharmaRadius.lg),
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: PharmaTypography.headingMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: PharmaTypography.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildStatusBadge(),
            ],
          ),

          // Progress bar
          if (project.progress > 0) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progress', style: PharmaTypography.body),
                Text(
                  '${project.progress}%',
                  style: PharmaTypography.bodyMedium.copyWith(
                    color: PharmaColors.emerald600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(PharmaRadius.full),
              child: LinearProgressIndicator(
                value: project.progress / 100,
                backgroundColor: PharmaColors.gray200,
                valueColor: AlwaysStoppedAnimation(PharmaColors.emerald600),
                minHeight: 8,
              ),
            ),
          ],

          // Meta info
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: PharmaColors.borderLight),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 14, color: PharmaColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(
                      project.status == 'completed'
                          ? 'Completed ${project.completedDate ?? ''}'
                          : 'Due ${project.dueDate}',
                      style: PharmaTypography.body,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people_outline_rounded, size: 14, color: PharmaColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(
                      '${project.members} member${project.members != 1 ? 's' : ''}',
                      style: PharmaTypography.body,
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

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String label;

    switch (project.status) {
      case 'completed':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.successText;
        label = 'Completed';
        break;
      case 'in-progress':
        bgColor = PharmaColors.infoBg;
        textColor = PharmaColors.infoText;
        label = 'In Progress';
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.gray700;
        label = 'Not Started';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.full),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SAMPLE DATA — Will be replaced with Serverpod backend when project module added
// ═══════════════════════════════════════════════════════════════════════════════

class _StatData {
  final String label;
  final String value;
  final Color iconColor;
  _StatData(this.label, this.value, this.iconColor);
}

class _ProjectData {
  final int id;
  final String title;
  final String description;
  final String status;
  final String dueDate;
  final String? completedDate;
  final int progress;
  final int members;

  _ProjectData({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    this.completedDate,
    required this.progress,
    required this.members,
  });
}

final _projects = [
  _ProjectData(
    id: 1,
    title: 'GMP Implementation Plan',
    description: 'Develop a comprehensive GMP implementation strategy for a new facility',
    status: 'in-progress',
    dueDate: 'March 25, 2026',
    progress: 60,
    members: 4,
  ),
  _ProjectData(
    id: 2,
    title: 'Safety Protocol Review',
    description: 'Review and update current safety procedures based on new regulations',
    status: 'in-progress',
    dueDate: 'March 30, 2026',
    progress: 35,
    members: 3,
  ),
  _ProjectData(
    id: 3,
    title: 'Quality Control Case Study',
    description: 'Analyze a real-world QC scenario and propose improvements',
    status: 'completed',
    dueDate: 'March 1, 2026',
    completedDate: 'March 1, 2026',
    progress: 100,
    members: 2,
  ),
  _ProjectData(
    id: 4,
    title: 'Validation Documentation',
    description: 'Create validation documentation for equipment qualification',
    status: 'not-started',
    dueDate: 'April 10, 2026',
    progress: 0,
    members: 1,
  ),
];
