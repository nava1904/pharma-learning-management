// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING MATRIX MANAGER (TRN-13)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/training-matrix
// Grid: rows = job roles, cols = courses. Uses TrainingMatrix DB model with
// dueDaysFromHire, retrainingIntervalDays, isMandatory. QA e-signature for saves.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;
import '../../providers/user_provider.dart';

class TrainingMatrixScreen extends ConsumerStatefulWidget {
  const TrainingMatrixScreen({super.key});

  @override
  ConsumerState<TrainingMatrixScreen> createState() => _TrainingMatrixScreenState();
}

class _TrainingMatrixScreenState extends ConsumerState<TrainingMatrixScreen>
    with SingleTickerProviderStateMixin {
  bool _editMode = false;
  bool _loading = true;
  String? _error;
  late TabController _tabController;

  List<JobRole> _roles = [];
  List<Course> _courses = [];
  List<TrainingMatrix> _matrixEntries = [];

  // Pending edits keyed by "roleId_courseId"
  final Map<String, _PendingCellEdit> _pending = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _cellKey(int roleId, int courseId) => '${roleId}_$courseId';

  Future<void> _loadData() async {
    setState(() { _loading = true; _error = null; });
    try {
      final courses = await client.course.listCourses();
      final user = await ref.read(currentUserProvider.future);
      final siteId = user?.siteId ?? 0;

      List<JobRole> roles = [];
      try {
        final departments = await client.organization.listDepartments(siteId);
        for (final dept in departments) {
          if (dept.id == null) continue;
          final deptRoles = await client.organization.listJobRoles(dept.id!);
          roles.addAll(deptRoles);
        }
      } catch (_) {}

      List<TrainingMatrix> entries = [];
      try {
        entries = await client.admin.listTrainingMatrixEntries(siteId: siteId);
      } catch (_) {}

      if (mounted) {
        setState(() {
          _courses = courses;
          _roles = roles;
          _matrixEntries = entries;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  TrainingMatrix? _getEntry(int roleId, int courseId) {
    for (final e in _matrixEntries) {
      if (e.jobRoleId == roleId && e.courseId == courseId) return e;
    }
    return null;
  }

  _PendingCellEdit? _getPending(int roleId, int courseId) => _pending[_cellKey(roleId, courseId)];

  String _getCellStatus(int roleId, int courseId) {
    final pending = _getPending(roleId, courseId);
    if (pending != null) return pending.deleted ? 'none' : (pending.isMandatory ? 'mandatory' : 'optional');
    final entry = _getEntry(roleId, courseId);
    if (entry == null) return 'none';
    return entry.isMandatory ? 'mandatory' : 'optional';
  }

  void _showCellEditDialog(int roleId, int courseId) {
    final existing = _getEntry(roleId, courseId);
    final pending = _getPending(roleId, courseId);
    bool isMandatory = pending?.isMandatory ?? existing?.isMandatory ?? true;
    int dueDays = pending?.dueDaysFromHire ?? existing?.dueDaysFromHire ?? 60;
    int? retrainingDays = pending?.retrainingIntervalDays ?? existing?.retrainingIntervalDays;

    final dueDaysController = TextEditingController(text: dueDays.toString());
    final retrainingController = TextEditingController(text: retrainingDays?.toString() ?? '');

    final roleName = _roles.firstWhere((r) => r.id == roleId, orElse: () => JobRole(name: 'Unknown', departmentId: 0, code: '')).name;
    final courseName = _courses.firstWhere((c) => c.id == courseId, orElse: () => Course(title: 'Unknown', organizationId: 0)).title;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PharmaRadius.xl)),
          title: Text('Edit Matrix Cell', style: PharmaTypography.headingSmall),
          content: SizedBox(
            width: MediaQuery.of(ctx).size.width < 560
                ? MediaQuery.of(ctx).size.width - 56
                : 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Role: $roleName', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text('Course: $courseName', style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Mandatory'),
                  subtitle: const Text('Required for this role'),
                  value: isMandatory,
                  onChanged: (v) => setDialogState(() => isMandatory = v),
                  activeTrackColor: PharmaColors.emerald600,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dueDaysController,
                  decoration: InputDecoration(
                    labelText: 'Due days from hire',
                    helperText: 'Days after hire date to complete',
                    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: retrainingController,
                  decoration: InputDecoration(
                    labelText: 'Retraining interval (days)',
                    helperText: 'Leave empty for no recurring retraining',
                    border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            if (existing != null || (pending != null && !pending.deleted))
              TextButton(
                onPressed: () {
                  setState(() {
                    _pending[_cellKey(roleId, courseId)] = _PendingCellEdit(
                      isMandatory: false,
                      dueDaysFromHire: 0,
                      deleted: true,
                    );
                  });
                  Navigator.pop(ctx);
                },
                child: Text('Remove', style: TextStyle(color: PharmaColors.danger)),
              ),
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                setState(() {
                  _pending[_cellKey(roleId, courseId)] = _PendingCellEdit(
                    isMandatory: isMandatory,
                    dueDaysFromHire: int.tryParse(dueDaysController.text) ?? 60,
                    retrainingIntervalDays: int.tryParse(retrainingController.text),
                    deleted: false,
                  );
                });
                Navigator.pop(ctx);
              },
              style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveWithESignature() async {
    if (_pending.isEmpty) return;
    final esig = await showEsignatureModal(
      context,
      entityType: 'training_matrix',
      entityId: 'bulk_update_${DateTime.now().millisecondsSinceEpoch}',
      signatureMeaning: 'Approve training matrix changes',
    );
    if (esig == null) return;

    setState(() => _loading = true);
    try {
      for (final entry in _pending.entries) {
        final parts = entry.key.split('_');
        final roleId = int.parse(parts[0]);
        final courseId = int.parse(parts[1]);
        final edit = entry.value;

        if (edit.deleted) {
          await client.admin.deleteTrainingMatrixEntry(jobRoleId: roleId, courseId: courseId);
        } else {
          await client.admin.upsertTrainingMatrixEntry(
            jobRoleId: roleId,
            courseId: courseId,
            isMandatory: edit.isMandatory,
            dueDaysFromHire: edit.dueDaysFromHire,
            retrainingIntervalDays: edit.retrainingIntervalDays,
          );
        }
      }
      _pending.clear();
      setState(() { _editMode = false; });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Training matrix saved'), backgroundColor: PharmaColors.emerald600),
        );
      }
      await _loadData();
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error!, style: TextStyle(color: PharmaColors.danger)),
          const SizedBox(height: 8),
          FilledButton(onPressed: _loadData, child: const Text('Retry')),
        ],
      ));
    }

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            borderRadius: PharmaRadius.cardRadius,
            border: Border.all(color: PharmaColors.borderLight),
          ),
          child: Column(children: [
            TabBar(
              controller: _tabController,
              labelColor: PharmaColors.emerald600,
              unselectedLabelColor: PharmaColors.textSecondary,
              indicatorColor: PharmaColors.emerald600,
              tabs: const [
                Tab(text: 'Matrix Grid'),
                Tab(text: 'Gap Analysis'),
              ],
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height - 250).clamp(420.0, 920.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMatrixTab(),
                  _buildGapAnalysisTab(),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.grid_on, color: PharmaColors.emerald600, size: 24),
        SizedBox(
          width: 640,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Training Matrix', style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
              Text('Map required training courses to job roles (21 CFR Part 211.25)', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
            ],
          ),
        ),
        if (_editMode && _pending.isNotEmpty) ...[
          OutlinedButton(onPressed: () { setState(() { _editMode = false; _pending.clear(); }); }, child: const Text('Cancel')),
          FilledButton.icon(
            onPressed: _saveWithESignature,
            icon: const Icon(Icons.verified_user, size: 16),
            label: Text('Save (${_pending.length} changes)'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg),
          ),
        ] else
          FilledButton.tonal(
            onPressed: () => setState(() => _editMode = !_editMode),
            child: Text(_editMode ? 'Done Editing' : 'Edit Matrix'),
          ),
      ],
    );
  }

  Widget _buildMatrixTab() {
    if (_roles.isEmpty || _courses.isEmpty) {
      return Center(child: Text('No roles or courses available', style: PharmaTypography.body));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegend(),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 56,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 60,
              columnSpacing: 0,
              headingTextStyle: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, color: PharmaColors.textTertiary, fontSize: 14),
              columns: [
                DataColumn(label: SizedBox(width: 180, child: Text('JOB ROLE', style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 14)))),
                ..._courses.map((c) => DataColumn(label: SizedBox(width: 120, child: Text(c.title, style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis)))),
              ],
              rows: _roles.where((r) => r.id != null).map((role) => DataRow(cells: [
                DataCell(SizedBox(width: 180, child: Text(role.name, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)))),
                ..._courses.map((course) {
                  final roleId = role.id!;
                  final courseId = course.id ?? 0;
                  return DataCell(SizedBox(width: 120, child: Center(child: _buildCell(roleId, courseId))));
                }),
              ])).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: PharmaColors.pageBg, borderRadius: PharmaRadius.cardRadius),
      child: Row(children: [
        _legendItem(PharmaColors.emerald600, 'Mandatory'),
        const SizedBox(width: 16),
        _legendItem(PharmaColors.info, 'Optional'),
        const SizedBox(width: 16),
        _legendItem(Colors.transparent, 'Not Required'),
        const Spacer(),
        if (_editMode) Text('Tap cells to edit', style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary)),
      ]),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 16, height: 16,
        decoration: BoxDecoration(
          color: color == Colors.transparent ? null : color.withValues(alpha: 0.2),
          border: Border.all(color: color == Colors.transparent ? PharmaColors.borderLight : color, width: 1.5),
          borderRadius: BorderRadius.circular(3),
        ),
        child: color != Colors.transparent ? Center(child: Icon(Icons.check, size: 10, color: color)) : null,
      ),
      const SizedBox(width: 6),
      Text(label, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _buildCell(int roleId, int courseId) {
    final status = _getCellStatus(roleId, courseId);
    final entry = _getEntry(roleId, courseId);
    final pending = _getPending(roleId, courseId);

    Color color;
    switch (status) {
      case 'mandatory': color = PharmaColors.emerald600; break;
      case 'optional': color = PharmaColors.info; break;
      default: color = Colors.transparent;
    }

    final hasPendingChange = pending != null;
    final dueDays = pending?.dueDaysFromHire ?? entry?.dueDaysFromHire;
    final retraining = pending?.retrainingIntervalDays ?? entry?.retrainingIntervalDays;

    if (_editMode) {
      return Tooltip(
        message: status == 'none'
            ? 'Not required — tap to add'
            : 'Due: ${dueDays}d${retraining != null ? ' · Retrain: ${retraining}d' : ''}',
        child: GestureDetector(
          onTap: () => _showCellEditDialog(roleId, courseId),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: color == Colors.transparent ? null : color.withValues(alpha: 0.15),
              border: Border.all(
                color: hasPendingChange ? PharmaColors.warning : (color == Colors.transparent ? PharmaColors.borderLight : color),
                width: hasPendingChange ? 2 : 1.5,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: status != 'none'
                ? Center(child: Icon(Icons.check, size: 14, color: color))
                : const Center(child: Icon(Icons.add, size: 12, color: PharmaColors.gray400)),
          ),
        ),
      );
    }

    if (status == 'none') return const SizedBox(width: 40, height: 40);

    return Tooltip(
      message: 'Due: ${dueDays ?? 60}d${retraining != null ? ' · Retrain: ${retraining}d' : ''}',
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Icon(Icons.check, size: 14, color: color)),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GAP ANALYSIS TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildGapAnalysisTab() {
    if (_roles.isEmpty) {
      return Center(child: Text('No roles available for analysis', style: PharmaTypography.body));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PharmaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Gap Analysis', style: PharmaTypography.headingSmall.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            'Shows required courses per role vs. actual enrollment status across the organization.',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
          ),
          const SizedBox(height: 16),
          ..._roles.where((r) => r.id != null).map((role) => _buildGapAnalysisCard(role)),
        ],
      ),
    );
  }

  Widget _buildGapAnalysisCard(JobRole role) {
    final roleEntries = _matrixEntries.where((e) => e.jobRoleId == role.id).toList();
    final mandatoryCount = roleEntries.where((e) => e.isMandatory).length;
    final totalRequired = roleEntries.length;

    if (totalRequired == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        borderRadius: PharmaRadius.cardRadius,
        border: Border.all(color: PharmaColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work_outline, size: 18, color: PharmaColors.emerald600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(role.name, style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: PharmaColors.emerald50,
                  borderRadius: PharmaRadius.pillRadius,
                ),
                child: Text(
                  '$mandatoryCount mandatory / $totalRequired total courses',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.emerald700, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: roleEntries.map((entry) {
              final courseName = entry.course?.title ?? 'Course #${entry.courseId}';
              final dueLabel = '${entry.dueDaysFromHire}d';
              final retrainLabel = entry.retrainingIntervalDays != null ? '↻${entry.retrainingIntervalDays}d' : '';
              final color = entry.isMandatory ? PharmaColors.emerald600 : PharmaColors.info;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(entry.isMandatory ? Icons.check_circle : Icons.radio_button_checked, size: 14, color: color),
                    const SizedBox(width: 6),
                    Text(courseName, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 6),
                    Text('$dueLabel $retrainLabel', style: PharmaTypography.caption.copyWith(color: PharmaColors.textTertiary, fontSize: 10)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PendingCellEdit {
  final bool isMandatory;
  final int dueDaysFromHire;
  final int? retrainingIntervalDays;
  final bool deleted;

  _PendingCellEdit({
    required this.isMandatory,
    required this.dueDaysFromHire,
    this.retrainingIntervalDays,
    this.deleted = false,
  });
}
