import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

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
                    value: selectedUser,
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
                    value: selectedCourse,
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
                  Navigator.pop(ctx, {
                    'user': selectedUser,
                    'course': selectedCourse,
                    'reason': reasonController.text.trim(),
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
        result['reason'] != null) {
      final selectedUser = result['user'] as PharmaUser;
      final selectedCourse = result['course'] as Course;
      reason = result['reason'] as String;
      try {
        await client.admin.requestTrainingWaiver(
          userId: selectedUser.id!,
          courseId: selectedCourse.id!,
          requestedById: currentUser!.id!,
          requestReason: reason!,
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
    try {
      await client.admin.approveTrainingWaiver(
        waiverId: w.id!,
        approvedById: currentUser!.id!,
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
                ..._waivers.map((w) => _WaiverTile(
                      waiver: w,
                      onApprove: w.status == 'pending' ? _approveWaiver : null,
                      onReject: w.status == 'pending' ? _rejectWaiver : null,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaiverTile extends StatelessWidget {
  const _WaiverTile({
    required this.waiver,
    this.onApprove,
    this.onReject,
  });

  final TrainingWaiver waiver;
  final void Function(TrainingWaiver)? onApprove;
  final void Function(TrainingWaiver)? onReject;

  @override
  Widget build(BuildContext context) {
    final userName =
        waiver.user != null
            ? '${waiver.user!.firstName} ${waiver.user!.lastName}'
            : 'User #${waiver.userId}';
    final courseTitle = waiver.course?.title ?? 'Course #${waiver.courseId}';
    final requestedBy =
        waiver.requestedBy != null
            ? '${waiver.requestedBy!.firstName} ${waiver.requestedBy!.lastName}'
            : '';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$userName → $courseTitle',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      waiver.requestReason,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Requested by $requestedBy on '
                      '${waiver.requestedAt?.toIso8601String().split('T').first ?? '-'}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.slate500,
                          ),
                    ),
                    if (waiver.approvedAt != null)
                      Text(
                        '${waiver.status} on '
                        '${waiver.approvedAt?.toIso8601String().split('T').first ?? '-'}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.slate500,
                            ),
                      ),
                    if (waiver.rejectionReason != null &&
                        waiver.rejectionReason!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Reason: ${waiver.rejectionReason}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.destructive,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
              StatusBadge(status: waiver.status ?? 'pending'),
              if (onApprove != null) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => onApprove!(waiver),
                  child: const Text('Approve'),
                ),
                TextButton(
                  onPressed: () => onReject!(waiver),
                  child: const Text('Reject'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
