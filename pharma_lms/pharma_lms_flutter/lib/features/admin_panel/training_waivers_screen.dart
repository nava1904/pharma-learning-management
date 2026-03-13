import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../core/client.dart';
import '../../features/esignature/esignature_screen.dart' show showEsignatureModal;
import '../../core/theme/app_colors.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';

/// ADM-07: Training waivers - request, QA approval, waived status.
class TrainingWaiversScreen extends ConsumerStatefulWidget {
  const TrainingWaiversScreen({super.key});

  @override
  ConsumerState<TrainingWaiversScreen> createState() =>
      _TrainingWaiversScreenState();
}

class _TrainingWaiversScreenState extends ConsumerState<TrainingWaiversScreen> {
  List<TrainingWaiver> _waivers = [];
  bool _loading = true;
  String? _error;
  String _filterStatus = 'all';
  final _rejectReasonController = TextEditingController();
  List<PlutoColumn> _waiverColumns = [];
  List<PlutoRow> _waiverRows = [];
  PlutoGridStateManager? _waiverStateManager;

  @override
  void dispose() {
    _rejectReasonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final waivers = await client.admin.listTrainingWaivers(
        status: _filterStatus == 'all' ? null : _filterStatus,
        limit: 200,
      );
      _buildWaiverGrid(waivers);
      setState(() {
        _waivers = waivers;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _requestWaiver() async {
    PharmaUser? selectedUser;
    Course? selectedCourse;
    String? reason;
    String? evidencePath;
    final reasonController = TextEditingController();
    List<PharmaUser> users = [];
    List<Course> courses = [];

    try {
      users = await client.organization.listUsers();
      courses = await client.course.listCourses();
    } catch (_) {}

    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser?.id == null) return;

    if (!mounted) return;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: const Text('Request Training Waiver'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<PharmaUser>(
                    initialValue: selectedUser,
                    decoration: const InputDecoration(
                      labelText: 'Employee',
                      border: OutlineInputBorder(),
                    ),
                    items: users
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(
                                  '${u.firstName} ${u.lastName} (${u.email})'),
                            ))
                        .toList(),
                    onChanged: (u) => setState(() => selectedUser = u),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Course>(
                    initialValue: selectedCourse,
                    decoration: const InputDecoration(
                      labelText: 'Course',
                      border: OutlineInputBorder(),
                    ),
                    items: courses
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.title),
                            ))
                        .toList(),
                    onChanged: (c) => setState(() => selectedCourse = c),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Justification',
                      border: OutlineInputBorder(),
                      hintText: 'Reason for waiver request',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null && result.files.single.path != null) {
                        setState(() => evidencePath = result.files.single.path);
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: Text(evidencePath != null
                        ? 'Evidence: ${evidencePath!.split('/').last}'
                        : 'Attach Evidence PDF (required)'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedUser?.id == null ||
                      selectedCourse?.id == null ||
                      reasonController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Please select employee, course, and provide justification')),
                    );
                    return;
                  }
                  if (evidencePath == null || evidencePath!.isEmpty) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Evidence PDF attachment is required')),
                    );
                    return;
                  }
                  Navigator.pop(ctx, {
                    'user': selectedUser,
                    'course': selectedCourse,
                    'reason': reasonController.text.trim(),
                    'evidencePath': evidencePath,
                  });
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );

    if (result != null &&
        result['user'] != null &&
        result['course'] != null &&
        result['reason'] != null &&
        result['evidencePath'] != null) {
      final selectedUser = result['user'] as PharmaUser;
      final selectedCourse = result['course'] as Course;
      reason = result['reason'] as String;
      final evPath = result['evidencePath'] as String;
      try {
        await client.admin.requestTrainingWaiver(
          userId: selectedUser.id!,
          courseId: selectedCourse.id!,
          requestedById: currentUser!.id!,
          requestReason: reason,
          evidenceStoragePath: evPath,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Waiver request submitted')),
          );
          _load();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $e')),
          );
        }
      }
    }
  }

  Future<void> _approveWaiver(TrainingWaiver w) async {
    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser?.id == null || w.id == null) return;
    if (w.requestedById == currentUser!.id) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Requester cannot approve (separation of duties)'),
          ),
        );
      }
      return;
    }
    if (!mounted) return;
    final esignatureId = await showEsignatureModal(
      context,
      entityType: 'training_waiver',
      entityId: w.id.toString(),
      signatureMeaning: 'I approve this training waiver as compliant',
      userId: currentUser.id,
    );
    if (esignatureId == null) return;
    try {
      await client.admin.approveTrainingWaiver(
        waiverId: w.id!,
        approvedById: currentUser.id!,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Waiver approved')),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  void _buildWaiverGrid(List<TrainingWaiver> waivers) {
    _waiverColumns = [
      PlutoColumn(
        title: 'User',
        field: 'user',
        type: PlutoColumnType.text(),
        width: 180,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Course',
        field: 'course',
        type: PlutoColumnType.text(),
        width: 180,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        width: 100,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Requested',
        field: 'requested',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        width: 160,
        readOnly: true,
        renderer: (ctx) {
          final id = ctx.row.cells['_id']?.value as int?;
          if (id == null) return const SizedBox.shrink();
          final w = _waivers.cast<TrainingWaiver?>().firstWhere(
                (e) => e?.id == id,
                orElse: () => null,
              );
          if (w == null || w.status != 'pending') return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => _approveWaiver(w),
                  child: const Text('Approve'),
                ),
                TextButton(
                  onPressed: () => _rejectWaiver(w),
                  child: const Text('Reject'),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        title: '_id',
        field: '_id',
        type: PlutoColumnType.text(),
        width: 0,
        hide: true,
      ),
    ];
    _waiverRows = waivers.map((w) {
      final userName = w.user != null
          ? '${w.user!.firstName} ${w.user!.lastName}'
          : 'User #${w.userId}';
      final courseTitle = w.course?.title ?? 'Course #${w.courseId}';
      final requested =
          w.requestedAt.toIso8601String().split('T').first ?? '-';
      return PlutoRow(
        cells: {
          'user': PlutoCell(value: userName),
          'course': PlutoCell(value: courseTitle),
          'status': PlutoCell(value: w.status ?? 'pending'),
          'requested': PlutoCell(value: requested),
          'actions': PlutoCell(value: ''),
          '_id': PlutoCell(value: w.id),
        },
      );
    }).toList();
  }

  Future<void> _rejectWaiver(TrainingWaiver w) async {
    _rejectReasonController.clear();
    if (!mounted) return;
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reject Waiver'),
        content: TextField(
          controller: _rejectReasonController,
          decoration: const InputDecoration(
            labelText: 'Rejection reason',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(ctx, _rejectReasonController.text.trim()),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
    if (reason == null || reason.isEmpty) return;

    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser?.id == null || w.id == null) return;
    try {
      await client.admin.rejectTrainingWaiver(
        waiverId: w.id!,
        approvedById: currentUser!.id!,
        rejectionReason: reason,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Waiver rejected')),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Training Waivers',
      icon: Icons.verified_user_rounded,
      child: RefreshIndicator(
        onRefresh: _load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                    value: _filterStatus,
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All')),
                      DropdownMenuItem(
                          value: 'pending', child: Text('Pending')),
                      DropdownMenuItem(
                          value: 'approved', child: Text('Approved')),
                      DropdownMenuItem(
                          value: 'rejected', child: Text('Rejected')),
                    ],
                    onChanged: (v) {
                      setState(() => _filterStatus = v ?? 'all');
                      _load();
                    },
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _requestWaiver,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Request Waiver'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Center(
                  child: Column(
                    children: [
                      Text('Error: $_error', textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _load,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (_waivers.isEmpty)
                const EmptyState(
                  message: 'No training waivers match your filters',
                  icon: Icons.verified_user_outlined,
                )
              else
                SizedBox(
                  height: 400,
                  child: PlutoGrid(
                    columns: _waiverColumns,
                    rows: _waiverRows,
                    onLoaded: (e) => _waiverStateManager = e.stateManager,
                    configuration: PlutoGridConfiguration(
                      columnFilter: const PlutoGridColumnFilterConfig(
                        filters: [
                          PlutoFilterTypeContains(),
                          PlutoFilterTypeEquals(),
                        ],
                      ),
                      style: PlutoGridStyleConfig(
                        gridBorderColor: AppColors.slate200,
                        cellTextStyle: Theme.of(context).textTheme.bodySmall ?? const TextStyle(),
                      ),
                    ),
                    noRowsWidget: const Center(
                      child: Text('No waivers'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
