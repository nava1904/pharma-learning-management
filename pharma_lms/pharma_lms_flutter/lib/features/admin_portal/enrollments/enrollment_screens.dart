import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// LIST
// ═══════════════════════════════════════════════════════════════════════════════

class AdminEnrollmentListScreen extends ConsumerWidget {
  const AdminEnrollmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminOrgAssignmentsProvider);

    return AdminPageFrame(
      title: 'All Enrollments',
      subtitle: 'Training assignments and due dates across the organization.',
      children: [
        AdminSectionCard(
          title: 'Assignments',
          child: async.when(
            loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
            error: (e, _) => Text('Failed to load: $e'),
            data: (rows) {
              if (rows.isEmpty) {
                return Text(
                  'No assignments found.',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                );
              }
              final active = rows.where((a) => a.status != 'cancelled').toList();
              return AdminDataTable(
                columns: const [
                  'Learner',
                  'Course',
                  'Due date',
                  'Priority',
                  'Assignment status',
                ],
                rows: active.take(500).map((a) {
                  final name = a.user != null ? '${a.user!.firstName} ${a.user!.lastName}' : 'User ${a.userId}';
                  final course = a.courseVersion?.course?.title ?? 'Course ${a.courseVersionId}';
                  final due = a.dueDate.toLocal().toString().split('.').first;
                  return [name, course, due, a.priority, a.status];
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE
// ═══════════════════════════════════════════════════════════════════════════════

class AdminEnrollmentCreateScreen extends ConsumerStatefulWidget {
  const AdminEnrollmentCreateScreen({super.key});

  @override
  ConsumerState<AdminEnrollmentCreateScreen> createState() => _AdminEnrollmentCreateScreenState();
}

class _AdminEnrollmentCreateScreenState extends ConsumerState<AdminEnrollmentCreateScreen> {
  int? _userId;
  int? _courseVersionId;
  DateTime _due = DateTime.now().add(const Duration(days: 14));
  String _priority = 'medium';
  final _reason = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final u = _userId;
    final cv = _courseVersionId;
    if (u == null || cv == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select learner and course version')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');
      await client.training.assignTraining(
        userId: u,
        courseVersionId: cv,
        assignedById: me!.id!,
        dueDate: _due,
        priority: _priority,
        reason: _reason.text.trim().isEmpty ? null : _reason.text.trim(),
        source: 'manual',
        forceReassign: false,
      );
      if (!mounted) return;
      ref.invalidate(adminOrgAssignmentsProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Training assigned')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Assign failed: $e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(adminUsersProvider);
    final coursesAsync = ref.watch(adminCoursesProvider);

    return AdminPageFrame(
      title: 'New Enrollment',
      subtitle: 'Assign training to a learner for a specific course version.',
      children: [
        AdminSectionCard(
          title: 'Assignment',
          child: usersAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('$e'),
            data: (users) => coursesAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('$e'),
              data: (courses) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Learner', border: OutlineInputBorder()),
                    items: users
                        .where((u) => u.id != null)
                        .map((u) => DropdownMenuItem(value: u.id, child: Text('${u.firstName} ${u.lastName} (${u.email})')))
                        .toList(),
                    onChanged: (v) => setState(() => _userId = v),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Course (latest version id — pick course first in catalogue if unsure)',
                      border: OutlineInputBorder(),
                    ),
                    items: courses
                        .where((c) => c.id != null)
                        .map(
                          (c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.title),
                          ),
                        )
                        .toList(),
                    onChanged: (courseId) async {
                      if (courseId == null) return;
                      final versions = await client.course.getCourseVersions(courseId);
                      if (!mounted) return;
                      if (versions.isEmpty) {
                        setState(() => _courseVersionId = null);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No versions for this course')),
                        );
                        return;
                      }
                      setState(() => _courseVersionId = versions.last.id);
                    },
                  ),
                  SizedBox(height: PharmaSpacing.sm),
                  Text(
                    'Course version ID in use: ${_courseVersionId ?? "—"}',
                    style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                            initialDate: _due,
                          );
                          if (d != null) setState(() => _due = d);
                        },
                        child: Text('Due: ${_due.toLocal().toString().split(" ").first}'),
                      ),
                      SizedBox(width: PharmaSpacing.md),
                      DropdownButton<String>(
                        value: _priority,
                        items: const [
                          DropdownMenuItem(value: 'low', child: Text('low')),
                          DropdownMenuItem(value: 'medium', child: Text('medium')),
                          DropdownMenuItem(value: 'high', child: Text('high')),
                        ],
                        onChanged: (v) => setState(() => _priority = v ?? 'medium'),
                      ),
                    ],
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  TextField(
                    controller: _reason,
                    decoration: const InputDecoration(
                      labelText: 'Reason (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: PharmaSpacing.md),
                  FilledButton.icon(
                    onPressed: _saving ? null : _submit,
                    icon: _saving
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.assignment_ind),
                    label: const Text('Assign training'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BULK CSV
// ═══════════════════════════════════════════════════════════════════════════════

class AdminEnrollmentBulkScreen extends ConsumerStatefulWidget {
  const AdminEnrollmentBulkScreen({super.key});

  @override
  ConsumerState<AdminEnrollmentBulkScreen> createState() => _AdminEnrollmentBulkScreenState();
}

class _AdminEnrollmentBulkScreenState extends ConsumerState<AdminEnrollmentBulkScreen> {
  bool _busy = false;
  String _log = '';

  Future<void> _pickAndRun() async {
    final pick = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv'], withData: true);
    if (pick == null || pick.files.isEmpty) return;
    final bytes = pick.files.first.bytes;
    if (bytes == null) return;

    setState(() {
      _busy = true;
      _log = '';
    });
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');

      final text = utf8.decode(bytes);
      final lines = text.split(RegExp(r'\r?\n')).where((l) => l.trim().isNotEmpty).toList();
      if (lines.length < 2) throw Exception('CSV needs a header and at least one row');

      final header = lines.first.split(',').map((s) => s.trim().toLowerCase()).toList();
      final iUser = header.indexOf('userid');
      final iCv = header.indexOf('courseversionid');
      if (iUser < 0 || iCv < 0) {
        throw Exception('Header must include userId,courseVersionId (optional: dueDate ISO)');
      }
      final iDue = header.indexOf('duedate');

      var ok = 0;
      final err = StringBuffer();
      for (var li = 1; li < lines.length; li++) {
        final parts = lines[li].split(',');
        if (parts.length <= iCv) continue;
        final uid = int.tryParse(parts[iUser].trim());
        final cvid = int.tryParse(parts[iCv].trim());
        if (uid == null || cvid == null) {
          err.writeln('Row $li: bad ids');
          continue;
        }
        DateTime due = DateTime.now().add(const Duration(days: 30));
        if (iDue >= 0 && iDue < parts.length) {
          final parsed = DateTime.tryParse(parts[iDue].trim());
          if (parsed != null) due = parsed;
        }
        try {
          await client.training.assignTraining(
            userId: uid,
            courseVersionId: cvid,
            assignedById: me!.id!,
            dueDate: due,
            priority: 'medium',
            source: 'bulk_csv',
            forceReassign: false,
          );
          ok++;
        } catch (e) {
          err.writeln('Row $li: $e');
        }
      }
      ref.invalidate(adminOrgAssignmentsProvider);
      setState(() => _log = 'Imported $ok rows.\n$err');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bulk complete: $ok ok')));
    } catch (e) {
      setState(() => _log = 'Error: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageFrame(
      title: 'Bulk Enrollment Upload',
      subtitle: 'CSV columns: userId,courseVersionId[,dueDate ISO8601]',
      children: [
        AdminSectionCard(
          title: 'Upload',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton.icon(
                onPressed: _busy ? null : _pickAndRun,
                icon: const Icon(Icons.upload_file),
                label: Text(_busy ? 'Working…' : 'Choose CSV and import'),
              ),
              if (_log.isNotEmpty) ...[
                SizedBox(height: PharmaSpacing.md),
                SelectableText(_log, style: PharmaTypography.caption),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// RULES — department assignment via API
// ═══════════════════════════════════════════════════════════════════════════════

class AdminEnrollmentRulesScreen extends ConsumerStatefulWidget {
  const AdminEnrollmentRulesScreen({super.key});

  @override
  ConsumerState<AdminEnrollmentRulesScreen> createState() => _AdminEnrollmentRulesScreenState();
}

class _AdminEnrollmentRulesScreenState extends ConsumerState<AdminEnrollmentRulesScreen> {
  int? _deptId;
  int? _cvId;
  DateTime _due = DateTime.now().add(const Duration(days: 30));
  bool _running = false;

  Future<void> _run() async {
    final d = _deptId;
    final cv = _cvId;
    if (d == null || cv == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select department and course version id')),
      );
      return;
    }
    setState(() => _running = true);
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me?.id == null) throw Exception('Not authenticated');
      await client.admin.assignTrainingToDepartment(
        departmentId: d,
        courseVersionId: cv,
        assignedById: me!.id!,
        dueDate: _due,
        reason: 'auto_enroll_rule',
        source: 'admin_rule',
      );
      ref.invalidate(adminOrgAssignmentsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Department assignment created')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final depts = ref.watch(adminDepartmentsProvider);

    return AdminPageFrame(
      title: 'Auto-Enrol Rules',
      subtitle: 'Assign a course version to all users in a department (one-shot batch).',
      children: [
        AdminSectionCard(
          title: 'Department cohort assignment',
          child: depts.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('$e'),
            data: (list) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Department', border: OutlineInputBorder()),
                  items: list
                      .where((d) => d.id != null)
                      .map((d) => DropdownMenuItem(value: d.id, child: Text(d.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _deptId = v),
                ),
                SizedBox(height: PharmaSpacing.md),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Course version ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => setState(() => _cvId = int.tryParse(v.trim())),
                ),
                SizedBox(height: PharmaSpacing.md),
                OutlinedButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                      initialDate: _due,
                    );
                    if (d != null) setState(() => _due = d);
                  },
                  child: Text('Due: ${_due.toLocal().toString().split(" ").first}'),
                ),
                SizedBox(height: PharmaSpacing.md),
                FilledButton(
                  onPressed: _running ? null : _run,
                  child: Text(_running ? 'Running…' : 'Assign to department'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TRANSCRIPT
// ═══════════════════════════════════════════════════════════════════════════════

class AdminTranscriptViewerScreen extends ConsumerStatefulWidget {
  const AdminTranscriptViewerScreen({super.key});

  @override
  ConsumerState<AdminTranscriptViewerScreen> createState() => _AdminTranscriptViewerScreenState();
}

class _AdminTranscriptViewerScreenState extends ConsumerState<AdminTranscriptViewerScreen> {
  int? _userId;
  bool _loading = false;
  List<TrainingRecord> _records = [];
  List<Certificate> _certs = [];
  List<Enrollment> _enrollments = [];

  Future<void> _load() async {
    final u = _userId;
    if (u == null) return;
    setState(() => _loading = true);
    try {
      final r = await client.training.getTrainingRecordsForUser(u);
      final c = await client.training.getCertificatesForUser(u);
      final e = await client.training.getEnrollmentsForUser(u);
      setState(() {
        _records = r;
        _certs = c;
        _enrollments = e;
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _exportCsv() async {
    final u = _userId;
    if (u == null) return;
    final b = StringBuffer();
    b.writeln('type,id,courseVersionId,completedAt,status');
    for (final e in _enrollments) {
      b.writeln(
        'enrollment,${e.id},${e.courseVersionId},${e.completedAt?.toIso8601String() ?? ""},${e.status}',
      );
    }
    for (final r in _records) {
      b.writeln('record,${r.id},${r.courseVersionId},${r.completedAt.toIso8601String() ?? ""},completed');
    }
    for (final c in _certs) {
      b.writeln('certificate,${c.id},${c.courseVersionId},${c.issuedAt.toIso8601String() ?? ""},${c.status}');
    }
    final bytes = Uint8List.fromList(utf8.encode(b.toString()));
    await saveBytesToFile(bytes, 'transcript_user_$u.csv');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transcript CSV saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(adminUsersProvider);

    return AdminPageFrame(
      title: 'Transcript Viewer',
      subtitle: 'Training records, enrollments, and certificates for a learner.',
      children: [
        AdminSectionCard(
          title: 'Learner',
          child: usersAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('$e'),
            data: (users) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'User', border: OutlineInputBorder()),
                  items: users
                      .where((u) => u.id != null)
                      .map((u) => DropdownMenuItem(value: u.id, child: Text('${u.firstName} ${u.lastName}')))
                      .toList(),
                  onChanged: (v) => setState(() => _userId = v),
                ),
                SizedBox(height: PharmaSpacing.md),
                Row(
                  children: [
                    FilledButton(onPressed: _userId == null || _loading ? null : _load, child: const Text('Load')),
                    SizedBox(width: PharmaSpacing.sm),
                    OutlinedButton(
                      onPressed: _userId == null || _enrollments.isEmpty && _records.isEmpty && _certs.isEmpty
                          ? null
                          : _exportCsv,
                      child: const Text('Export CSV'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_loading) const LinearProgressIndicator(),
        AdminSectionCard(
          title: 'Enrollments (${_enrollments.length})',
          child: AdminDataTable(
            columns: const ['ID', 'Course ver.', 'Status', 'Completed'],
            rows: _enrollments
                .map(
                  (e) => [
                    '${e.id ?? "—"}',
                    '${e.courseVersionId}',
                    e.status,
                    e.completedAt?.toLocal().toString().split('.').first ?? '—',
                  ],
                )
                .toList(),
          ),
        ),
        AdminSectionCard(
          title: 'Training records (${_records.length})',
          child: AdminDataTable(
            columns: const ['ID', 'Course ver.', 'Completed'],
            rows: _records
                .map(
                  (r) => [
                    '${r.id ?? "—"}',
                    '${r.courseVersionId}',
                    r.completedAt.toLocal().toString().split('.').first ?? '—',
                  ],
                )
                .toList(),
          ),
        ),
        AdminSectionCard(
          title: 'Certificates (${_certs.length})',
          child: AdminDataTable(
            columns: const ['ID', 'Course ver.', 'Issued', 'Status'],
            rows: _certs
                .map(
                  (c) => [
                    '${c.id ?? "—"}',
                    '${c.courseVersionId}',
                    c.issuedAt.toLocal().toString().split('.').first ?? '—',
                    c.status,
                  ],
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
