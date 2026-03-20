// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — TRAINING MATRIX MANAGER (TRN-13)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/training-matrix
// Grid: rows = job roles, cols = courses. QA e-signature required for changes.
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/employee_portal_tokens.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;
import '../../providers/user_provider.dart';

class TrainingMatrixScreen extends ConsumerStatefulWidget {
  const TrainingMatrixScreen({super.key});

  @override
  ConsumerState<TrainingMatrixScreen> createState() => _TrainingMatrixScreenState();
}

class _TrainingMatrixScreenState extends ConsumerState<TrainingMatrixScreen> {
  bool _editMode = false;
  bool _hasChanges = false;

  bool _loading = true;
  String? _error;

  List<dynamic> _roles = [];
  List<dynamic> _courses = [];

  // server matrix per roleId
  final Map<int, Set<int>> _serverMatrix = {};

  // pending toggles: roleId -> courseId -> present(bool)
  final Map<int, Map<int, bool>> _pending = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() { _loading = true; _error = null; });
    try {
      final courses = await client.course.listCourses();

      // Robust fetch: list departments, then roles per department
      List<dynamic> roles = [];
      try {
        final user = await ref.read(currentUserProvider.future);
        final siteId = user?.siteId ?? 0;
        final departments = await client.organization.listDepartments(siteId);
        for (final dept in departments) {
          if (dept.id == null) continue;
          final deptRoles = await client.organization.listJobRoles(dept.id!);
          roles.addAll(deptRoles);
        }
      } catch (_) {
        roles = [];
      }

      _serverMatrix.clear();
      for (final r in roles) {
        if (r.id == null) continue;
        try {
          final curriculum = await client.admin.getRoleBasedCurriculum(r.id!);
          // curriculum is a list of curriculum version IDs; resolve to course IDs
          Set<int> courseIds = {};
          for (final versionId in curriculum) {
            try {
              final version = await client.course.getCourseVersion(versionId);
              if (version != null) {
                courseIds.add(version.courseId);
              }
            } catch (_) {}
          }
          _serverMatrix[r.id!] = courseIds;
        } catch (_) {
          _serverMatrix[r.id!] = <int>{};
        }
      }

      if (mounted) setState(() { _courses = courses; _roles = roles; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  String _getCellStatus(int roleId, int courseId) {
    if (_pending[roleId] != null && _pending[roleId]!.containsKey(courseId)) {
      return _pending[roleId]![courseId]! ? 'mandatory' : 'none';
    }
    final present = _serverMatrix[roleId]?.contains(courseId) ?? false;
    return present ? 'mandatory' : 'none';
  }

  void _toggleCell(int roleId, int courseId) {
    setState(() {
      _hasChanges = true;
      _pending.putIfAbsent(roleId, () => {});
      final current = _getCellStatus(roleId, courseId);
      if (current == 'none') _pending[roleId]![courseId] = true;
      else _pending[roleId]![courseId] = false;
    });
  }

  Future<void> _saveWithESignature() async {
    final esig = await showEsignatureModal(
      context,
      entityType: 'training_matrix',
      entityId: 'bulk_update_${DateTime.now().millisecondsSinceEpoch}',
      signatureMeaning: 'Approve training matrix changes',
    );
    if (esig == null) return;

    setState(() { _loading = true; });
    try {
      for (final r in _roles) {
        if (r.id == null) continue;
        final roleId = r.id as int;
        final original = _serverMatrix[roleId] ?? <int>{};
        final pendingForRole = _pending[roleId] ?? {};
        final finalSet = {...original};
        for (final entry in pendingForRole.entries) {
          if (entry.value) finalSet.add(entry.key);
          else finalSet.remove(entry.key);
        }
        final jsonStr = jsonEncode(finalSet.toList());
        await client.admin.updateJobRoleTrainingMatrix(jobRoleId: roleId, trainingMatrixJson: jsonStr);
      }

      _pending.clear();
      setState(() { _editMode = false; _hasChanges = false; _loading = false; });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Training matrix saved'), backgroundColor: PharmaColors.emerald600));
      await _loadData();
    } catch (e) {
      if (mounted) setState(() { _loading = false; });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_error!, style: TextStyle(color: PharmaColors.danger)),
        const SizedBox(height: 8),
        FilledButton(onPressed: _loadData, child: const Text('Retry')),
      ],
    ));

    return ListView(
      padding: const EdgeInsets.all(PharmaSpacing.pagePadding),
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildLegend(),
        const SizedBox(height: 16),
        _buildMatrix(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.grid_on, color: PharmaColors.emerald600, size: 24),
        const SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Training Matrix', style: PharmaTypography.headingLarge.copyWith(fontSize: 20, fontWeight: FontWeight.w800)),
            Text('Map required training courses to job roles', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
          ],
        )),
        if (_editMode && _hasChanges) ...[
          OutlinedButton(onPressed: () { setState(() { _editMode = false; _hasChanges = false; _pending.clear(); }); }, child: const Text('Cancel')),
          const SizedBox(width: 8),
          FilledButton.icon(onPressed: _saveWithESignature, icon: const Icon(Icons.verified_user, size: 16), label: const Text('Save with E-Signature'), style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600, foregroundColor: PharmaColors.cardBg)),
        ] else
          FilledButton.tonal(onPressed: () => setState(() => _editMode = !_editMode), child: Text(_editMode ? 'Done Editing' : 'Edit Matrix')),
      ],
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius, border: Border.all(color: PharmaColors.borderLight)),
      child: Row(children: [
        _legendItem(PharmaColors.emerald600, 'Mandatory'),
        const SizedBox(width: 16),
        _legendItem(PharmaColors.info, 'Recommended'),
        const SizedBox(width: 16),
        _legendItem(PharmaColors.gray400, 'Optional'),
        const SizedBox(width: 16),
        _legendItem(Colors.transparent, 'Not Required'),
      ]),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 16, height: 16, decoration: BoxDecoration(color: color == Colors.transparent ? null : color.withOpacity(0.2), border: Border.all(color: color == Colors.transparent ? PharmaColors.borderLight : color, width: 1.5), borderRadius: BorderRadius.circular(3)), child: color != Colors.transparent ? Center(child: Icon(Icons.check, size: 10, color: color)) : null),
      const SizedBox(width: 6),
      Text(label, style: PharmaTypography.caption.copyWith(fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _buildMatrix() {
    if (_roles.isEmpty || _courses.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Center(
            child: Text('No roles or courses available', style: PharmaTypography.body),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: PharmaColors.cardBg, borderRadius: PharmaRadius.cardRadius, border: Border.all(color: PharmaColors.borderLight)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 56,
          dataRowMinHeight: 52,
          dataRowMaxHeight: 56,
          columnSpacing: 0,
          headingTextStyle: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, color: PharmaColors.textTertiary, fontSize: 11, letterSpacing: 0.3),
          columns: [
            DataColumn(label: SizedBox(width: 180, child: Text('JOB ROLE', style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 11)))),
            ..._courses.map((c) => DataColumn(label: SizedBox(width: 120, child: Text(c.title ?? 'Untitled', style: PharmaTypography.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 10), maxLines: 2, overflow: TextOverflow.ellipsis)))),
          ],
          rows: _roles.where((r) => r.id != null).map((role) => DataRow(cells: [
            DataCell(SizedBox(width: 180, child: Text(role.name ?? 'Unknown', style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)))),
            ..._courses.map((course) {
              final roleId = role.id as int;
              final courseId = course.id ?? 0;
              return DataCell(SizedBox(width: 120, child: Center(child: _buildMatrixCellById(roleId, courseId))));
            }),
          ])).toList(),
        ),
      ),
    );
  }

  Widget _buildMatrixCellById(int roleId, int courseId) {
    final status = _getCellStatus(roleId, courseId);
    Color color;
    switch (status) {
      case 'mandatory': color = PharmaColors.emerald600; break;
      case 'recommended': color = PharmaColors.info; break;
      case 'optional': color = PharmaColors.gray400; break;
      default: color = Colors.transparent; break;
    }

    if (_editMode) {
      return GestureDetector(
        onTap: () => _toggleCell(roleId, courseId),
        child: AnimatedContainer(duration: EmployeePortalTokens.durationFast, width: 36, height: 36, decoration: BoxDecoration(color: color == Colors.transparent ? null : color.withOpacity(0.15), border: Border.all(color: color == Colors.transparent ? PharmaColors.borderLight : color, width: 1.5), borderRadius: BorderRadius.circular(4)), child: color != Colors.transparent ? Center(child: Icon(Icons.check, size: 14, color: color)) : null),
      );
    }

    if (status == 'none') return const SizedBox(width: 36, height: 36);

    return Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)), child: Center(child: Icon(Icons.check, size: 14, color: color)));
  }
}

// _MatrixCell removed: training matrix now uses server-driven data structures.
