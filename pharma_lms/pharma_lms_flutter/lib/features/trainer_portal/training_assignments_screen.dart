// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING ASSIGNMENTS (TRN-14)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/assignments
// Assign courses to employees/groups with due dates and priority.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:intl/intl.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

// ─── PROVIDERS ───────────────────────────────────────────────────────────────

final _assignmentsProvider =
    FutureProvider.autoDispose<List<TrainingAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.training.getAllAssignments(
    organizationId: user.organizationId,
  );
});

/// Standalone assignments (assignment campaigns) for the organization.
final _standaloneAssignmentsProvider =
    FutureProvider.autoDispose<List<StandaloneAssignment>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.standaloneAssignment
      .listStandaloneAssignmentsForOrganization(user.organizationId);
});

/// Courses you created that are published (or have an approved/effective version).
final _trainerPublishedCoursesProvider =
    FutureProvider.autoDispose<List<Course>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.course.listTrainerPublishedCoursesForAssignment();
});

/// Learners with at least one enrollment on any version of those courses.
final _trainerPublishedCourseLearnersProvider =
    FutureProvider.autoDispose<List<PharmaUser>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];
  return client.training.listLearnersEnrolledInTrainerPublishedCourses();
});

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class TrainingAssignmentsScreen extends ConsumerStatefulWidget {
  const TrainingAssignmentsScreen({super.key});

  @override
  ConsumerState<TrainingAssignmentsScreen> createState() =>
      _TrainingAssignmentsScreenState();
}

class _TrainingAssignmentsScreenState
    extends ConsumerState<TrainingAssignmentsScreen>
    with SingleTickerProviderStateMixin {
  String _filterStatus = 'All';
  String _searchQuery = '';
  TrainingAssignment? _selectedAssignment;
  StandaloneAssignment? _selectedCampaign;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<TrainingAssignment> _applyFilters(List<TrainingAssignment> all) {
    return all.where((a) {
      if (_filterStatus != 'All' &&
          a.status.toLowerCase() != _filterStatus.toLowerCase()) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final courseName =
            a.courseVersion?.course?.title.toLowerCase() ?? '';
        final userName =
            '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'
                .toLowerCase();
        if (!courseName.contains(q) && !userName.contains(q)) return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Tabs ──────────────────────────────────────────────────────
        Container(
          color: PharmaColors.cardBg,
          child: TabBar(
            controller: _tabController,
            labelColor: PharmaColors.emerald600,
            unselectedLabelColor: PharmaColors.textTertiary,
            indicatorColor: PharmaColors.emerald600,
            tabs: const [
              Tab(text: 'Training Assignments'),
              Tab(text: 'Assignment Campaigns'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTrainingAssignmentsTab(),
              _buildCampaignsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingAssignmentsTab() {
    final assignmentsAsync = ref.watch(_assignmentsProvider);

    return assignmentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to load assignments',
                style: PharmaTypography.headingSmall),
            const SizedBox(height: 4),
            Text('$e', style: PharmaTypography.caption),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(_assignmentsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (assignments) => _buildContent(assignments),
    );
  }

  Widget _buildCampaignsTab() {
    final campaignsAsync = ref.watch(_standaloneAssignmentsProvider);

    return campaignsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text('Failed to load campaigns', style: PharmaTypography.headingSmall),
            const SizedBox(height: 4),
            Text('$e', style: PharmaTypography.caption),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(_standaloneAssignmentsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (campaigns) => _buildCampaignsContent(campaigns),
    );
  }

  // ─── Campaigns Tab Content ─────────────────────────────────────────────

  Widget _buildCampaignsContent(List<StandaloneAssignment> campaigns) {
    final filtered = campaigns.where((c) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!c.title.toLowerCase().contains(q)) return false;
      }
      return true;
    }).toList();

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(_standaloneAssignmentsProvider),
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildCampaignsHeader(),
          const SizedBox(height: 16),
          _buildCampaignsStatsRow(campaigns),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...filtered.map((c) => _buildCampaignCard(c)),
                    if (filtered.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(48),
                        decoration: BoxDecoration(
                          color: PharmaColors.cardBg,
                          borderRadius: PharmaRadius.cardRadius,
                          border: Border.all(color: PharmaColors.borderLight),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.campaign_outlined,
                                size: 48, color: PharmaColors.gray300),
                            const SizedBox(height: 8),
                            Text('No assignment campaigns yet',
                                style: PharmaTypography.bodyMedium),
                            const SizedBox(height: 8),
                            Text(
                              'Create one using the "New Assignment" button above.',
                              style: PharmaTypography.caption
                                  .copyWith(color: PharmaColors.textTertiary),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (_selectedCampaign != null) ...[
                const SizedBox(width: 24),
                SizedBox(
                  width: 400,
                  child: _buildCampaignDetailPanel(_selectedCampaign!),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsHeader() {
    return Row(
      children: [
        Icon(Icons.campaign, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Assignment Campaigns',
                  style: PharmaTypography.headingLarge
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Standalone assignments with open-ended or MCQ content',
                  style: PharmaTypography.body
                      .copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: () => context.push('/trainer/assignment-campaigns/new'),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Assignment'),
          style: FilledButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: PharmaColors.cardBg,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignsStatsRow(List<StandaloneAssignment> campaigns) {
    final draft = campaigns.where((c) => c.status == 'draft').length;
    final published = campaigns.where((c) => c.status == 'published').length;
    return Row(
      children: [
        _stat('Published', '$published', Icons.check_circle, PharmaColors.emerald600),
        _stat('Drafts', '$draft', Icons.edit_note, PharmaColors.warningText),
        _stat('Total', '${campaigns.length}', Icons.campaign, PharmaColors.gray600),
      ]
          .map((w) => Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 12), child: w)))
          .toList(),
    );
  }

  Widget _buildCampaignCard(StandaloneAssignment campaign) {
    final isSelected = _selectedCampaign?.id == campaign.id;
    final isDraft = campaign.status == 'draft';
    final statusColor = isDraft ? PharmaColors.warningText : PharmaColors.emerald600;
    final statusLabel = isDraft ? 'DRAFT' : 'PUBLISHED';
    final dueStr = DateFormat('MMM d, yyyy').format(campaign.dueAt);
    final creatorName = campaign.createdBy != null
        ? '${campaign.createdBy!.firstName} ${campaign.createdBy!.lastName}'
        : '';

    return GestureDetector(
      onTap: () => setState(() => _selectedCampaign = campaign),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(
              color: isSelected ? PharmaColors.emerald600 : PharmaColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.campaign_outlined,
                  size: 18, color: PharmaColors.textTertiary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(campaign.title,
                    style: PharmaTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: PharmaRadius.pillRadius),
                child: Text(statusLabel,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                        letterSpacing: 0.5)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: PharmaColors.info.withValues(alpha: 0.1),
                    borderRadius: PharmaRadius.pillRadius),
                child: Text(campaign.contentKind.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: PharmaColors.info,
                        letterSpacing: 0.5)),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Text(
                'Target: ${campaign.targetType} · Due: $dueStr',
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              if (creatorName.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text('by $creatorName',
                    style: PharmaTypography.caption
                        .copyWith(color: PharmaColors.textTertiary)),
              ],
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignDetailPanel(StandaloneAssignment campaign) {
    final dueStr = DateFormat('MMM d, yyyy').format(campaign.dueAt);
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Campaign Details',
                    style: PharmaTypography.headingSmall
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedCampaign = null),
                icon: const Icon(Icons.close, size: 18),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(campaign.title,
              style: PharmaTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          if (campaign.instructions != null &&
              campaign.instructions!.isNotEmpty) ...[
            Text(campaign.instructions!,
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary)),
            const SizedBox(height: 8),
          ],
          Text('Type: ${campaign.contentKind}',
              style: PharmaTypography.body),
          Text('Target: ${campaign.targetType}',
              style: PharmaTypography.body),
          Text('Due: $dueStr', style: PharmaTypography.body),
          Text('Status: ${campaign.status}',
              style: PharmaTypography.body),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          // ── Check Submissions ────────────────────────────────────
          if (campaign.status == 'published' && campaign.id != null)
            FilledButton.icon(
              onPressed: () => _showSubmissionsDialog(campaign),
              icon: const Icon(Icons.grading, size: 16),
              label: const Text('Check Submissions'),
              style: FilledButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 42),
              ),
            ),
          if (campaign.status == 'published' && campaign.id != null)
            const SizedBox(height: 8),

          // ── Extend Deadline ──────────────────────────────────────
          if (campaign.status == 'published' && campaign.id != null)
            OutlinedButton.icon(
              onPressed: () => _showExtendCampaignDeadlineDialog(campaign),
              icon: const Icon(Icons.schedule, size: 16),
              label: const Text('Extend Deadline'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.emerald600,
                side: BorderSide(
                    color: PharmaColors.emerald600.withValues(alpha: 0.5)),
                minimumSize: const Size(double.infinity, 42),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showExtendCampaignDeadlineDialog(
      StandaloneAssignment campaign) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: campaign.dueAt.add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;

    try {
      await client.standaloneAssignment.updateStandaloneAssignment(
        campaign.id!,
        dueAt: picked,
      );
      ref.invalidate(_standaloneAssignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deadline extended')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showSubmissionsDialog(StandaloneAssignment campaign) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => _SubmissionsDialog(
        campaign: campaign,
        onGraded: () => ref.invalidate(_standaloneAssignmentsProvider),
      ),
    );
  }

  Widget _buildContent(List<TrainingAssignment> assignments) {
    final filtered = _applyFilters(assignments);
    final active =
        assignments.where((a) => a.status == 'active').length;
    final overdue = assignments.where((a) {
      return a.status == 'active' && a.dueDate.isBefore(DateTime.now());
    }).length;
    final completed =
        assignments.where((a) => a.status == 'completed').length;

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(_assignmentsProvider),
      child: ListView(
        padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildStatsRow(active, overdue, completed, assignments.length),
          const SizedBox(height: 16),
          _buildFilters(),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...filtered.map((a) => _buildAssignmentCard(a)),
                            if (filtered.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(48),
                        decoration: BoxDecoration(
                          color: PharmaColors.cardBg,
                          borderRadius: PharmaRadius.cardRadius,
                          border: Border.all(color: PharmaColors.borderLight),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.assignment_outlined,
                                size: 48, color: PharmaColors.gray300),
                            const SizedBox(height: 8),
                            Text('No assignments match filters',
                                style: PharmaTypography.bodyMedium),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (_selectedAssignment != null) ...[
                const SizedBox(width: 24),
                SizedBox(
                  width: 360,
                  child: _buildAssignmentDetailPanel(_selectedAssignment!),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentDetailPanel(TrainingAssignment a) {
    final courseName =
        a.courseVersion?.course?.title ?? 'Course #${a.courseVersionId}';
    final userName =
        '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'.trim();
    final assigneeName = userName.isNotEmpty ? userName : 'User #${a.userId}';
    return Container(
      padding: const EdgeInsets.all(PharmaSpacing.lg),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
        boxShadow: PharmaShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Assignment details',
                  style: PharmaTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _selectedAssignment = null),
                icon: const Icon(Icons.close, size: 18),
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(courseName,
              style: PharmaTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Assigned to: $assigneeName',
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
          const SizedBox(height: 8),
          Text(
            'Due: ${DateFormat('MMM d, yyyy').format(a.dueDate)}',
            style: PharmaTypography.body,
          ),
          Text('Status: ${a.status}', style: PharmaTypography.body),
          Text('Priority: ${a.priority}', style: PharmaTypography.body),
          Text('Source: ${a.source}', style: PharmaTypography.caption),
          if (a.reason != null && a.reason!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Reason: ${a.reason}',
                style: PharmaTypography.caption),
          ],
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          // ── Extend Deadline ──────────────────────────────────────
          if (a.status == 'active' || a.status == 'completed') ...[
            OutlinedButton.icon(
              onPressed: () => _onAssignmentAction('extend', a),
              icon: const Icon(Icons.schedule, size: 16),
              label: const Text('Extend Deadline'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.emerald600,
                side: BorderSide(
                    color: PharmaColors.emerald600.withValues(alpha: 0.5)),
                minimumSize: const Size(double.infinity, 42),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ── Change Priority ──────────────────────────────────────
          if (a.status == 'active') ...[
            OutlinedButton.icon(
              onPressed: () => _onAssignmentAction('priority', a),
              icon: const Icon(Icons.flag, size: 16),
              label: const Text('Change Priority'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.info,
                side: BorderSide(
                    color: PharmaColors.info.withValues(alpha: 0.5)),
                minimumSize: const Size(double.infinity, 42),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ── Cancel ───────────────────────────────────────────────
          if (a.status == 'active') ...[
            OutlinedButton.icon(
              onPressed: () => _onAssignmentAction('cancel', a),
              icon: const Icon(Icons.cancel_outlined, size: 16),
              label: const Text('Cancel Assignment'),
              style: OutlinedButton.styleFrom(
                foregroundColor: PharmaColors.danger,
                side: BorderSide(
                    color: PharmaColors.danger.withValues(alpha: 0.5)),
                minimumSize: const Size(double.infinity, 42),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.assignment, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Training Assignments',
                  style: PharmaTypography.headingLarge
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Assign and track training for employees and teams',
                  style: PharmaTypography.body
                      .copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: _showCsvBulkImportDialog,
          icon: const Icon(Icons.upload_file, size: 16),
          label: const Text('Import CSV'),
          style: OutlinedButton.styleFrom(
            foregroundColor: PharmaColors.emerald600,
            side: BorderSide(color: PharmaColors.emerald600.withValues(alpha: 0.5)),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(width: 10),
        FilledButton.icon(
          onPressed: () =>
              context.push('/trainer/assignment-campaigns/new'),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Assignment'),
          style: FilledButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: PharmaColors.cardBg,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }

  void _showCsvBulkImportDialog() {
    ref.invalidate(_trainerPublishedCoursesProvider);
    ref.invalidate(_trainerPublishedCourseLearnersProvider);
    showDialog(
      context: context,
      builder: (ctx) => _CsvBulkAssignmentDialog(
        onDone: () {
          ref.invalidate(_assignmentsProvider);
          ref.invalidate(_trainerPublishedCourseLearnersProvider);
        },
        currentUserFuture: ref.read(currentUserProvider.future),
      ),
    );
  }

  Widget _buildStatsRow(
      int active, int overdue, int completed, int total) {
    return Row(
      children: [
        _stat('Active', '$active', Icons.pending_actions, PharmaColors.info),
        _stat(
            'Overdue', '$overdue', Icons.warning_amber, PharmaColors.danger),
        _stat('Completed', '$completed', Icons.check_circle,
            PharmaColors.emerald600),
        _stat('Total', '$total', Icons.assignment, PharmaColors.gray600),
      ]
          .map((w) => Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 12), child: w)))
          .toList(),
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value,
              style: PharmaTypography.statNumber.copyWith(fontSize: 20)),
          Text(label,
              style: PharmaTypography.caption
                  .copyWith(color: PharmaColors.textTertiary)),
        ]),
      ]),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search by course or assignee…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true,
              fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ...['All', 'Active', 'Completed', 'Cancelled'].map((s) {
          final isActive = _filterStatus == s;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: FilterChip(
              label: Text(s),
              selected: isActive,
              onSelected: (_) => setState(() => _filterStatus = s),
              selectedColor: PharmaColors.emerald50,
              checkmarkColor: PharmaColors.emerald600,
              labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.textSecondary),
              side: BorderSide(
                  color: isActive
                      ? PharmaColors.emerald600
                      : PharmaColors.borderLight),
            ),
          );
        }),
      ]),
    );
  }

  String _resolveStatus(TrainingAssignment a) {
    if (a.status == 'cancelled' || a.status == 'superseded') {
      return 'cancelled';
    }
    if (a.status == 'completed') return 'completed';
    if (a.status == 'active' && a.dueDate.isBefore(DateTime.now())) {
      return 'overdue';
    }
    return 'active';
  }

  Widget _buildAssignmentCard(TrainingAssignment a) {
    final resolvedStatus = _resolveStatus(a);
    final courseName =
        a.courseVersion?.course?.title ?? 'Course #${a.courseVersionId}';
    final userName =
        '${a.user?.firstName ?? ''} ${a.user?.lastName ?? ''}'.trim();
    final assigneeName = userName.isNotEmpty ? userName : 'User #${a.userId}';
    final priority = a.priority;

    Color statusColor;
    String statusLabel;
    switch (resolvedStatus) {
      case 'active':
        statusColor = PharmaColors.info;
        statusLabel = 'ACTIVE';
        break;
      case 'overdue':
        statusColor = PharmaColors.danger;
        statusLabel = 'OVERDUE';
        break;
      case 'completed':
        statusColor = PharmaColors.emerald600;
        statusLabel = 'COMPLETED';
        break;
      case 'cancelled':
        statusColor = PharmaColors.gray500;
        statusLabel = 'CANCELLED';
        break;
      default:
        statusColor = PharmaColors.gray500;
        statusLabel = a.status.toUpperCase();
        break;
    }

    Color priorityColor;
    switch (priority) {
      case 'critical':
        priorityColor = PharmaColors.danger;
        break;
      case 'high':
        priorityColor = PharmaColors.warningText;
        break;
      default:
        priorityColor = PharmaColors.gray500;
        break;
    }

    final dueDateStr = DateFormat('MMM d, yyyy').format(a.dueDate);

    return GestureDetector(
      onTap: () => setState(() => _selectedAssignment = a),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          borderRadius: PharmaRadius.cardRadius,
          border: Border.all(
              color: resolvedStatus == 'overdue'
                  ? PharmaColors.danger.withValues(alpha: 0.3)
                  : _selectedAssignment?.id == a.id
                      ? PharmaColors.emerald600
                      : PharmaColors.borderLight),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.person, size: 18, color: PharmaColors.textTertiary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseName,
                      style: PharmaTypography.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text('Assigned to: $assigneeName',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.pillRadius),
              child: Text(statusLabel,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                      letterSpacing: 0.5)),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: PharmaRadius.pillRadius),
              child: Text(priority.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                      letterSpacing: 0.5)),
            ),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (a.reason != null && a.reason!.isNotEmpty)
                    Text('Reason: ${a.reason}',
                        style: PharmaTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  Text(
                      'Source: ${a.source} · Assigned ${DateFormat('MMM d').format(a.assignedAt)}',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Due',
                      style: PharmaTypography.caption
                          .copyWith(color: PharmaColors.textTertiary)),
                  Text(dueDateStr,
                      style: PharmaTypography.bodyMedium.copyWith(
                          color: resolvedStatus == 'overdue'
                              ? PharmaColors.danger
                              : PharmaColors.textPrimary,
                          fontWeight: FontWeight.w500)),
                ]),
            const SizedBox(width: 12),
            if (resolvedStatus == 'active' || resolvedStatus == 'overdue')
              PopupMenuButton<String>(
                itemBuilder: (_) => [
                  const PopupMenuItem(
                      value: 'extend', child: Text('Extend Deadline')),
                  const PopupMenuItem(
                      value: 'priority', child: Text('Change Priority')),
                  const PopupMenuItem(
                      value: 'cancel', child: Text('Cancel Assignment')),
                ],
                onSelected: (v) => _onAssignmentAction(v, a),
                icon: Icon(Icons.more_vert,
                    size: 18, color: PharmaColors.textTertiary),
              ),
          ]),
        ],
      ),
      ),
    );
  }

  // ─── ACTIONS ─────────────────────────────────────────────────────────────

  Future<void> _onAssignmentAction(
      String action, TrainingAssignment assignment) async {
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null || assignment.id == null) return;

    switch (action) {
      case 'extend':
        await _showExtendDeadlineDialog(assignment, user!.id!);
        break;
      case 'priority':
        await _showChangePriorityDialog(assignment, user!.id!);
        break;
      case 'cancel':
        await _showCancelDialog(assignment, user!.id!);
        break;
    }
  }

  Future<void> _showExtendDeadlineDialog(
      TrainingAssignment assignment, int updatedById) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: assignment.dueDate.add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;

    try {
      await client.training.updateAssignment(
        assignmentId: assignment.id!,
        dueDate: picked,
        updatedById: updatedById,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deadline extended')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showChangePriorityDialog(
      TrainingAssignment assignment, int updatedById) async {
    final priorities = ['critical', 'high', 'medium', 'low'];
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Change Priority'),
        children: priorities.map((p) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, p),
            child: Text(p[0].toUpperCase() + p.substring(1)),
          );
        }).toList(),
      ),
    );
    if (result == null || !mounted) return;

    try {
      await client.training.updateAssignment(
        assignmentId: assignment.id!,
        priority: result,
        updatedById: updatedById,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Priority changed to $result')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _showCancelDialog(
      TrainingAssignment assignment, int cancelledById) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PharmaRadius.xl)),
        title: const Text('Cancel Assignment'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This will cancel the assignment and any linked active enrollments.',
                style: PharmaTypography.body,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Cancellation Reason (required)',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(
                      borderRadius: PharmaRadius.inputRadius),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Keep')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Cancel Assignment'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final reason = reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cancellation reason is required')),
      );
      return;
    }

    try {
      await client.training.cancelAssignment(
        assignmentId: assignment.id!,
        cancelledById: cancelledById,
        reason: reason,
      );
      ref.invalidate(_assignmentsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment cancelled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SEARCH PICKER DIALOG (reusable, works reliably inside dialogs)
// ═══════════════════════════════════════════════════════════════════════════════

class _SearchPickerDialog<T> extends StatefulWidget {
  const _SearchPickerDialog({
    required this.title,
    required this.items,
    required this.labelBuilder,
    this.subtitleBuilder,
    this.iconBuilder,
  });

  final String title;
  final List<T> items;
  final String Function(T) labelBuilder;
  final String? Function(T)? subtitleBuilder;
  final IconData Function(T)? iconBuilder;

  @override
  State<_SearchPickerDialog<T>> createState() => _SearchPickerDialogState<T>();
}

class _SearchPickerDialogState<T> extends State<_SearchPickerDialog<T>> {
  String _query = '';

  List<T> get _filtered {
    if (_query.isEmpty) return widget.items;
    final q = _query.toLowerCase();
    return widget.items.where((item) {
      final label = widget.labelBuilder(item).toLowerCase();
      final sub = widget.subtitleBuilder?.call(item)?.toLowerCase() ?? '';
      return label.contains(q) || sub.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
      title: Text(widget.title),
      content: SizedBox(
        width: 480,
        height: 400,
        child: Column(children: [
          TextField(
            autofocus: true,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Type to search…',
              prefixIcon: const Icon(Icons.search, size: 18),
              filled: true, fillColor: PharmaColors.pageBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius, borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? Center(child: Text('No results for "$_query"', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final item = filtered[i];
                      final sub = widget.subtitleBuilder?.call(item);
                      return ListTile(
                        leading: widget.iconBuilder != null ? Icon(widget.iconBuilder!(item), size: 20, color: PharmaColors.emerald600) : null,
                        title: Text(widget.labelBuilder(item), overflow: TextOverflow.ellipsis),
                        subtitle: sub != null ? Text(sub, style: PharmaTypography.caption) : null,
                        dense: true,
                        onTap: () => Navigator.pop(ctx, item),
                        shape: RoundedRectangleBorder(borderRadius: PharmaRadius.cardRadius),
                      );
                    },
                  ),
          ),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))],
    );
  }
}

// ── Debounced server search: single course ───────────────────────────────────

class _CourseDbSearchDialog extends StatefulWidget {
  const _CourseDbSearchDialog({required this.load});

  final Future<List<Course>> Function(String query) load;

  @override
  State<_CourseDbSearchDialog> createState() => _CourseDbSearchDialogState();
}

class _CourseDbSearchDialogState extends State<_CourseDbSearchDialog> {
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;
  List<Course> _items = [];
  bool _loading = true;
  String? _emptyMessage;

  @override
  void initState() {
    super.initState();
    _runSearch('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _runSearch(String q) async {
    setState(() {
      _loading = true;
      _emptyMessage = null;
    });
    try {
      final list = await widget.load(q);
      if (!mounted) return;
      setState(() {
        _items = list;
        _loading = false;
        if (list.isEmpty) {
          _emptyMessage = q.trim().isEmpty
              ? 'No assignable courses. Publish a course or add an approved/effective version.'
              : 'No courses match your search.';
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _items = [];
          _emptyMessage = 'Could not load courses: $e';
        });
      }
    }
  }

  void _scheduleSearch(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _runSearch(v));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PharmaRadius.xl),
      ),
      title: const Text('Select Course'),
      content: SizedBox(
        width: 480,
        height: 420,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchCtrl,
              autofocus: true,
              onChanged: _scheduleSearch,
              decoration: InputDecoration(
                hintText: 'Search title, SOP, description…',
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (_loading)
              const Expanded(
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else if (_emptyMessage != null)
              Expanded(
                child: Center(
                  child: Text(
                    _emptyMessage!,
                    textAlign: TextAlign.center,
                    style: PharmaTypography.body.copyWith(
                      color: PharmaColors.textTertiary,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (ctx, i) {
                    final c = _items[i];
                    return ListTile(
                      leading: Icon(Icons.menu_book,
                          size: 20, color: PharmaColors.emerald600),
                      title: Text(c.title, overflow: TextOverflow.ellipsis),
                      subtitle: c.sopNumber != null
                          ? Text('SOP: ${c.sopNumber}',
                              style: PharmaTypography.caption)
                          : null,
                      dense: true,
                      onTap: () => Navigator.pop(ctx, c),
                      shape: RoundedRectangleBorder(
                        borderRadius: PharmaRadius.cardRadius,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SUBMISSIONS DIALOG  (grading queue + scores / open‑ended review)
// ═══════════════════════════════════════════════════════════════════════════════

class _SubmissionsDialog extends StatefulWidget {
  const _SubmissionsDialog({
    required this.campaign,
    required this.onGraded,
  });

  final StandaloneAssignment campaign;
  final VoidCallback onGraded;

  @override
  State<_SubmissionsDialog> createState() =>
      _SubmissionsDialogState();
}

class _SubmissionsDialogState extends State<_SubmissionsDialog> {
  List<StandaloneAssignmentRecipient>? _submissions;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSubmissions();
  }

  Future<void> _loadSubmissions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await client.standaloneAssignment
          .listSubmittedForGrading(assignmentId: widget.campaign.id!);
      if (mounted) setState(() => _submissions = list);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kind = widget.campaign.contentKind;
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.grading, color: PharmaColors.emerald600, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Submissions – ${widget.campaign.title}',
              style: PharmaTypography.headingSmall
                  .copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Chip(
            label: Text(kind,
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.cardBg, fontSize: 11)),
            backgroundColor: PharmaColors.info,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
      content: SizedBox(
        width: 620,
        height: 480,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 40, color: PharmaColors.danger),
                        const SizedBox(height: 8),
                        Text(_error!,
                            style: PharmaTypography.body
                                .copyWith(color: PharmaColors.danger)),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _loadSubmissions,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : _submissions == null || _submissions!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inbox,
                                size: 48,
                                color: PharmaColors.gray400),
                            const SizedBox(height: 12),
                            Text('No submissions yet',
                                style: PharmaTypography.bodyMedium.copyWith(
                                    color: PharmaColors.textTertiary)),
                            const SizedBox(height: 4),
                            Text(
                                'Learners who submit will appear here for grading.',
                                style: PharmaTypography.caption.copyWith(
                                    color: PharmaColors.textTertiary)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: _submissions!.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1),
                        itemBuilder: (ctx, i) =>
                            _buildSubmissionTile(_submissions![i], kind),
                      ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildSubmissionTile(
      StandaloneAssignmentRecipient r, String kind) {
    final name =
        '${r.user?.firstName ?? ''} ${r.user?.lastName ?? ''}'.trim();
    final displayName = name.isNotEmpty ? name : 'User #${r.userId}';
    final isGraded = r.grade != null;

    return ExpansionTile(
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: isGraded
            ? PharmaColors.emerald600.withValues(alpha: 0.15)
            : PharmaColors.info.withValues(alpha: 0.15),
        child: Icon(
          isGraded ? Icons.check_circle : Icons.pending,
          size: 18,
          color: isGraded ? PharmaColors.emerald600 : PharmaColors.info,
        ),
      ),
      title: Text(displayName,
          style: PharmaTypography.bodyMedium
              .copyWith(fontWeight: FontWeight.w600)),
      subtitle: Row(
        children: [
          Text(
            r.submittedAt != null
                ? 'Submitted ${DateFormat('MMM d, yyyy HH:mm').format(r.submittedAt!)}'
                : 'Pending',
            style: PharmaTypography.caption
                .copyWith(color: PharmaColors.textTertiary, fontSize: 11),
          ),
          if (isGraded) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: PharmaColors.emerald600.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Score: ${r.grade}',
                  style: PharmaTypography.caption.copyWith(
                      color: PharmaColors.emerald600,
                      fontWeight: FontWeight.w600,
                      fontSize: 11)),
            ),
          ],
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Response content ──────────────────────────────
              if (r.responseJson != null &&
                  r.responseJson!.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PharmaColors.pageBg,
                    borderRadius: PharmaRadius.cardRadius,
                    border:
                        Border.all(color: PharmaColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kind == 'open_ended'
                            ? 'Response'
                            : 'Submitted Answers',
                        style: PharmaTypography.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PharmaColors.textTertiary),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatResponse(r.responseJson!, kind),
                        style: PharmaTypography.body,
                        maxLines: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // ── Feedback (if already graded) ─────────────────
              if (isGraded && r.feedback != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PharmaColors.emerald600
                        .withValues(alpha: 0.06),
                    borderRadius: PharmaRadius.cardRadius,
                    border: Border.all(
                        color: PharmaColors.emerald600
                            .withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trainer Feedback',
                          style: PharmaTypography.caption.copyWith(
                              fontWeight: FontWeight.w600,
                              color: PharmaColors.emerald600)),
                      const SizedBox(height: 4),
                      Text(r.feedback!,
                          style: PharmaTypography.body),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
              ],

              // ── Grade button (only for ungraded) ─────────────
              if (!isGraded)
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () => _showGradeSheet(r),
                    icon: const Icon(Icons.rate_review, size: 16),
                    label: const Text('Grade'),
                    style: FilledButton.styleFrom(
                      backgroundColor: PharmaColors.emerald600,
                      foregroundColor: PharmaColors.cardBg,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatResponse(String json, String kind) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is Map) {
        if (kind == 'open_ended') {
          return decoded['answer']?.toString() ??
              decoded['text']?.toString() ??
              json;
        }
        // For quiz‑style assignments show score summary
        final buf = StringBuffer();
        decoded.forEach((k, v) {
          buf.writeln('$k: $v');
        });
        return buf.toString().trim();
      }
      return decoded.toString();
    } catch (_) {
      return json;
    }
  }

  Future<void> _showGradeSheet(StandaloneAssignmentRecipient r) async {
    final gradeCtrl = TextEditingController();
    final feedbackCtrl = TextEditingController();
    bool submitting = false;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.rate_review,
                    color: PharmaColors.emerald600, size: 20),
                const SizedBox(width: 8),
                const Expanded(child: Text('Grade Submission')),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${r.user?.firstName ?? ''} ${r.user?.lastName ?? ''}'
                        .trim(),
                    style: PharmaTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: gradeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Score (0–100)',
                      hintText: 'e.g. 85',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius),
                      prefixIcon: const Icon(Icons.score, size: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: feedbackCtrl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Feedback (optional)',
                      hintText:
                          'Provide constructive feedback for the learner…',
                      filled: true,
                      fillColor: PharmaColors.pageBg,
                      border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed:
                    submitting ? null : () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: submitting
                    ? null
                    : () async {
                        final grade =
                            int.tryParse(gradeCtrl.text.trim());
                        if (grade == null || grade < 0 || grade > 100) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please enter a valid score between 0 and 100'),
                            ),
                          );
                          return;
                        }
                        setDialogState(() => submitting = true);
                        try {
                          await client.standaloneAssignment
                              .gradeStandaloneSubmission(
                            recipientId: r.id!,
                            grade: grade,
                            feedback: feedbackCtrl.text.trim().isNotEmpty
                                ? feedbackCtrl.text.trim()
                                : null,
                          );
                          if (ctx.mounted) Navigator.pop(ctx, true);
                        } catch (e) {
                          setDialogState(() => submitting = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Grading failed: $e'),
                                backgroundColor: PharmaColors.danger,
                              ),
                            );
                          }
                        }
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                ),
                child: submitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: PharmaColors.cardBg,
                        ),
                      )
                    : const Text('Submit Grade'),
              ),
            ],
          );
        },
      ),
    );

    if (result == true) {
      widget.onGraded();
      _loadSubmissions(); // refresh the list
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CSV BULK ASSIGNMENT
// ═══════════════════════════════════════════════════════════════════════════════

class _CsvBulkAssignmentDialog extends ConsumerStatefulWidget {
  const _CsvBulkAssignmentDialog({
    required this.onDone,
    required this.currentUserFuture,
  });

  final VoidCallback onDone;
  final Future<PharmaUser?> currentUserFuture;

  @override
  ConsumerState<_CsvBulkAssignmentDialog> createState() =>
      _CsvBulkAssignmentDialogState();
}

class _CsvBulkAssignmentDialogState
    extends ConsumerState<_CsvBulkAssignmentDialog> {
  Course? _selectedCourse;
  CourseVersion? _selectedVersion;
  List<CourseVersion> _versions = [];
  bool _loadingVersions = false;
  String _priority = 'medium';
  DateTime? _dueDate;
  late final TextEditingController _csvDueDateController;
  String _reason = '';
  bool _submitting = false;

  Uint8List? _csvBytes;
  String? _csvName;

  @override
  void initState() {
    super.initState();
    _csvDueDateController = TextEditingController();
  }

  @override
  void dispose() {
    _csvDueDateController.dispose();
    super.dispose();
  }

  Future<void> _pickCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['csv'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final f = result.files.single;
    final bytes = f.bytes;
    if (bytes == null || bytes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read CSV (empty or unsupported on this platform)')),
        );
      }
      return;
    }
    setState(() {
      _csvBytes = bytes;
      _csvName = f.name;
    });
  }

  Future<void> _loadVersions(int courseId) async {
    setState(() => _loadingVersions = true);
    try {
      final versions = await client.course.getCourseVersions(courseId);
      if (mounted) {
        setState(() {
          _versions = versions;
          _selectedVersion = versions.isNotEmpty ? versions.first : null;
          _loadingVersions = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingVersions = false);
    }
  }

  int? _headerIndex(List<dynamic> header, Set<String> names) {
    for (var i = 0; i < header.length; i++) {
      final k = header[i].toString().trim().toLowerCase().replaceAll(' ', '_');
      if (names.contains(k)) return i;
    }
    return null;
  }

  Future<void> _runImport() async {
    if (_selectedVersion == null || _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select course, version, and due date')),
      );
      return;
    }
    if (_csvBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a CSV file')),
      );
      return;
    }

    List<PharmaUser> users;
    try {
      users = await ref.read(_trainerPublishedCourseLearnersProvider.future);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not load learners: $e')),
        );
      }
      return;
    }
    if (!mounted) return;
    final byEmail = <String, PharmaUser>{};
    final byId = <int, PharmaUser>{};
    final byEmployeeId = <String, PharmaUser>{};
    for (final u in users) {
      if (u.id == null) continue;
      byEmail[u.email.toLowerCase()] = u;
      byId[u.id!] = u;
      final eid = u.employeeId;
      if (eid != null && eid.isNotEmpty) {
        byEmployeeId[eid.toLowerCase()] = u;
      }
    }

    final text = utf8.decode(_csvBytes!);
    final rows = const CsvToListConverter().convert(text);
    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV has no rows')),
      );
      return;
    }

    final header = rows.first;
    var idxEmail = _headerIndex(header, {'email', 'email_address', 'e_mail'});
    var idxUserId = _headerIndex(header, {'user_id', 'userid', 'id'});
    var idxEmployeeId =
        _headerIndex(header, {'employee_id', 'employeeid', 'emp_id', 'hr_id'});
    if (idxEmail == null && idxUserId == null && idxEmployeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'CSV header must include one of: email, user_id, employee_id',
          ),
        ),
      );
      return;
    }

    final targetOrder = <int>[];
    final targetsById = <int, PharmaUser>{};
    final errors = <String>[];
    for (var r = 1; r < rows.length; r++) {
      final row = rows[r];
      if (row.isEmpty || row.every((c) => c.toString().trim().isEmpty)) {
        continue;
      }
      PharmaUser? u;
      if (idxEmail != null && idxEmail < row.length) {
        final e = row[idxEmail].toString().trim().toLowerCase();
        if (e.isNotEmpty) u = byEmail[e];
      }
      if (u == null && idxUserId != null && idxUserId < row.length) {
        final raw = row[idxUserId].toString().trim();
        final id = int.tryParse(raw);
        if (id != null) u = byId[id];
      }
      if (u == null && idxEmployeeId != null && idxEmployeeId < row.length) {
        final eid = row[idxEmployeeId].toString().trim().toLowerCase();
        if (eid.isNotEmpty) u = byEmployeeId[eid];
      }
      if (u == null) {
        errors.add('Row ${r + 1}: no matching active user');
        continue;
      }
      if (u.status != 'active') {
        errors.add('Row ${r + 1}: user ${u.email} is not active');
        continue;
      }
      final uid = u.id!;
      if (!targetsById.containsKey(uid)) {
        targetsById[uid] = u;
        targetOrder.add(uid);
      }
    }

    if (targetOrder.isEmpty) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Import failed'),
          content: SingleChildScrollView(
            child: Text(
              errors.isEmpty
                  ? 'No assignable rows.'
                  : errors.take(50).join('\n'),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          ],
        ),
      );
      return;
    }

    setState(() => _submitting = true);
    final currentUser = await widget.currentUserFuture;
    final assignedById = currentUser?.id;
    if (assignedById == null) {
      if (mounted) setState(() => _submitting = false);
      return;
    }
    final courseVersionId = _selectedVersion!.id!;
    final reason = _reason.isNotEmpty ? _reason : null;
    var ok = 0;
    for (final uid in targetOrder) {
      final u = targetsById[uid]!;
      try {
        await client.training.assignTraining(
          userId: u.id!,
          courseVersionId: courseVersionId,
          assignedById: assignedById,
          dueDate: _dueDate!,
          priority: _priority,
          reason: reason,
          source: 'csv_import',
          forceReassign: false,
        );
        ok++;
      } catch (e) {
        errors.add('${u.email}: $e');
      }
    }

    if (mounted) setState(() => _submitting = false);
    widget.onDone();
    if (!mounted) return;
    Navigator.pop(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('CSV import: $ok assigned'),
        content: SizedBox(
          width: 420,
          height: 280,
          child: errors.isEmpty
              ? const Text('All rows processed successfully.')
              : SingleChildScrollView(
                  child: Text(
                    'Row-level issues:\n\n${errors.take(80).join('\n')}',
                    style: PharmaTypography.caption,
                  ),
                ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(_trainerPublishedCoursesProvider);
    final courses = coursesAsync.valueOrNull ?? [];

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PharmaRadius.xl),
      ),
      title: const Text('Bulk assign from CSV'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CSV rows must match learners already enrolled in your published courses (email, user_id, or employee_id). Courses listed are only those you created and published.',
                style: PharmaTypography.caption
                    .copyWith(color: PharmaColors.textTertiary),
              ),
              if (coursesAsync.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 4),
                  child: LinearProgressIndicator(minHeight: 2),
                ),
              if (coursesAsync.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Could not load your published courses.',
                    style: PharmaTypography.caption
                        .copyWith(color: PharmaColors.danger),
                  ),
                ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Course>(
                key: ValueKey('csv_course_${courses.length}_${_selectedCourse?.id}'),
                initialValue: _selectedCourse != null &&
                        courses.any((c) => c.id == _selectedCourse!.id)
                    ? courses.firstWhere((c) => c.id == _selectedCourse!.id)
                    : null,
                items: courses
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.title, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (c) {
                  setState(() {
                    _selectedCourse = c;
                    _selectedVersion = null;
                    _versions = [];
                  });
                  if (c?.id != null) _loadVersions(c!.id!);
                },
                decoration: InputDecoration(
                  labelText: 'Course *',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 12),
              if (_loadingVersions)
                const Center(child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ))
              else if (_selectedCourse != null)
                DropdownButtonFormField<CourseVersion>(
                  key: ValueKey(
                      'csv_ver_${_selectedCourse?.id}_${_versions.length}_${_selectedVersion?.id}'),
                  initialValue: _selectedVersion != null &&
                          _versions.any((v) => v.id == _selectedVersion!.id)
                      ? _versions.firstWhere((v) => v.id == _selectedVersion!.id)
                      : null,
                  items: _versions
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text('v${v.version} (${v.status})'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedVersion = v),
                  decoration: InputDecoration(
                    labelText: 'Version *',
                    filled: true,
                    fillColor: PharmaColors.pageBg,
                    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                  ),
                  isExpanded: true,
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _priority,
                      items: ['critical', 'high', 'medium', 'low']
                          .map(
                            (p) => DropdownMenuItem(
                              value: p,
                              child:
                                  Text(p[0].toUpperCase() + p.substring(1)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _priority = v);
                      },
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        filled: true,
                        fillColor: PharmaColors.pageBg,
                        border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Due date *',
                        suffixIcon: const Icon(Icons.calendar_today, size: 16),
                        filled: true,
                        fillColor: PharmaColors.pageBg,
                        border: OutlineInputBorder(
                          borderRadius: PharmaRadius.inputRadius,
                        ),
                      ),
                      readOnly: true,
                      controller: _csvDueDateController,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _dueDate ??
                              DateTime.now().add(const Duration(days: 14)),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() {
                            _dueDate = picked;
                            _csvDueDateController.text =
                                DateFormat('MMM d, yyyy').format(picked);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (v) => _reason = v,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Reason (optional)',
                  filled: true,
                  fillColor: PharmaColors.pageBg,
                  border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickCsv,
                icon: const Icon(Icons.attach_file, size: 18),
                label: Text(_csvName == null ? 'Choose CSV file' : _csvName!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _runImport,
          style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          child: _submitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: PharmaColors.cardBg,
                  ),
                )
              : const Text('Run import'),
        ),
      ],
    );
  }
}
