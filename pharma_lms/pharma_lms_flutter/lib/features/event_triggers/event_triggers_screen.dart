import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Manual event triggers for workflow testing (SOP update, employee created).
class EventTriggersScreen extends StatefulWidget {
  const EventTriggersScreen({super.key});

  @override
  State<EventTriggersScreen> createState() => _EventTriggersScreenState();
}

class _EventTriggersScreenState extends State<EventTriggersScreen> {
  final _sopDocIdController = TextEditingController();
  final _sopCourseVersionIdController = TextEditingController();
  final _sopReasonController = TextEditingController(text: 'SOP update - manual trigger');
  final _empUserIdController = TextEditingController();
  final _empDepartmentIdController = TextEditingController();
  final _empRoleIdController = TextEditingController();
  bool _sopLoading = false;
  bool _empLoading = false;

  @override
  void dispose() {
    _sopDocIdController.dispose();
    _sopCourseVersionIdController.dispose();
    _sopReasonController.dispose();
    _empUserIdController.dispose();
    _empDepartmentIdController.dispose();
    _empRoleIdController.dispose();
    super.dispose();
  }

  Future<void> _triggerSopUpdated() async {
    final docId = _sopDocIdController.text.trim();
    final cvId = _sopCourseVersionIdController.text.trim();
    if (docId.isEmpty || cvId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document ID and Course Version ID required')),
      );
      return;
    }
    setState(() => _sopLoading = true);
    try {
      await client.event.triggerSopUpdated(
        documentId: docId,
        courseVersionId: cvId,
        reason: _sopReasonController.text.trim().isEmpty
            ? 'SOP update - manual trigger'
            : _sopReasonController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SOP updated event triggered')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _sopLoading = false);
    }
  }

  Future<void> _triggerEmployeeCreated() async {
    final userId = _empUserIdController.text.trim();
    final deptId = _empDepartmentIdController.text.trim();
    final roleId = _empRoleIdController.text.trim();
    if (userId.isEmpty || deptId.isEmpty || roleId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID, Department ID, and Role ID required')),
      );
      return;
    }
    setState(() => _empLoading = true);
    try {
      await client.event.triggerEmployeeCreated(
        userId: userId,
        departmentId: deptId,
        roleId: roleId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee created event triggered')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _empLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Triggers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/admin'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Manual workflow testing (no Kafka required)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.slate600,
                ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.description, color: AppColors.indigo600),
                      const SizedBox(width: 12),
                      Text(
                        'Trigger SOP Updated',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Simulates retraining workflow when SOP is updated. Requires document and course version IDs.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _sopDocIdController,
                    decoration: const InputDecoration(
                      labelText: 'Document ID',
                      hintText: 'e.g. 1',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _sopCourseVersionIdController,
                    decoration: const InputDecoration(
                      labelText: 'Course Version ID',
                      hintText: 'e.g. 1',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _sopReasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _sopLoading ? null : _triggerSopUpdated,
                    child: _sopLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Trigger SOP Updated'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_add, color: AppColors.indigo600),
                      const SizedBox(width: 12),
                      Text(
                        'Trigger Employee Created',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Simulates role-based training assignment for new employee.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _empUserIdController,
                    decoration: const InputDecoration(
                      labelText: 'User ID',
                      hintText: 'e.g. 1',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _empDepartmentIdController,
                    decoration: const InputDecoration(
                      labelText: 'Department ID',
                      hintText: 'e.g. 1',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _empRoleIdController,
                    decoration: const InputDecoration(
                      labelText: 'Role ID',
                      hintText: 'e.g. 1',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _empLoading ? null : _triggerEmployeeCreated,
                    child: _empLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Trigger Employee Created'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
