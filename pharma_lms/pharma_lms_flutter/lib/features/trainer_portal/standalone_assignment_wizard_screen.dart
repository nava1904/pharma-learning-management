// Route: /trainer/assignment-campaigns/new
// Multi-step wizard for standalone (non–course-lesson) assignments.

import 'package:flutter/material.dart' hide Material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import '../shared/employee_multi_select_dialog.dart';

/// New standalone assignment campaign wizard.
class StandaloneAssignmentWizardScreen extends ConsumerStatefulWidget {
  const StandaloneAssignmentWizardScreen({super.key});

  @override
  ConsumerState<StandaloneAssignmentWizardScreen> createState() =>
      _StandaloneAssignmentWizardScreenState();
}

class _StandaloneAssignmentWizardScreenState
    extends ConsumerState<StandaloneAssignmentWizardScreen> {
  int _step = 0;
  final _titleCtrl = TextEditingController();
  final _instructionsCtrl = TextEditingController();

  String _contentKind = 'open_ended';
  String _targetType = 'individual';
  final List<PharmaUser> _selectedUsers = [];
  Department? _selectedDepartment;
  TrainingBatch? _selectedBatch;

  DateTime? _dueDate;
  int? _questionBankId;
  int? _courseVersionId;
  Course? _selectedCourse;
  CourseVersion? _selectedVersion;
  List<CourseVersion> _versions = [];
  List<QuestionBank> _questionBanks = [];
  List<Department> _departments = [];
  List<TrainingBatch> _batches = [];

  bool _loadingMeta = true;
  bool _loadingVersions = false;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadLists() async {
    final user = await ref.read(currentUserProvider.future);
    if (user == null || !mounted) {
      setState(() => _loadingMeta = false);
      return;
    }
    setState(() => _loadingMeta = true);
    try {
      final banks = await client.assessment.listQuestionBanks(
        organizationId: user.organizationId,
      );
      final depts = await client.organization.listDepartments(user.siteId);
      final batches = await client.trainingBatch.listBatches(
        organizationId: user.organizationId,
      );
      if (mounted) {
        setState(() {
          _questionBanks = banks;
          _departments = depts;
          _batches = batches;
          _loadingMeta = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingMeta = false);
    }
  }

  Future<void> _pickCourse() async {
    final picked = await showDialog<Course>(
      context: context,
      builder: (ctx) => _CoursePickDialog(
        load: (q) => client.course.listTrainerPublishedCoursesForAssignment(
          search: q.trim().isEmpty ? null : q.trim(),
        ),
      ),
    );
    if (picked == null || picked.id == null) return;
    setState(() {
      _selectedCourse = picked;
      _selectedVersion = null;
      _courseVersionId = null;
      _versions = [];
      _loadingVersions = true;
    });
    try {
      final versions = await client.course.getCourseVersions(picked.id!);
      if (mounted) {
        setState(() {
          _versions = versions;
          _selectedVersion = versions.isNotEmpty ? versions.first : null;
          _courseVersionId = _selectedVersion?.id;
          _loadingVersions = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingVersions = false);
    }
  }

  Future<void> _pickUsers() async {
    final picked = await showDialog<List<PharmaUser>>(
      context: context,
      builder: (ctx) => EmployeeMultiSelectDbSearchDialog(
        initialSelection: List<PharmaUser>.from(_selectedUsers),
        load: (query) =>
            client.training.listLearnersEnrolledInTrainerPublishedCourses(
              search: query.trim().isEmpty ? null : query.trim(),
              limit: 150,
            ),
      ),
    );
    if (picked == null) return;
    setState(() {
      _selectedUsers
        ..clear()
        ..addAll(picked);
    });
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool _validateStep() {
    switch (_step) {
      case 0:
        if (_titleCtrl.text.trim().isEmpty) {
          _snack('Enter a title');
          return false;
        }
        return true;
      case 1:
        if (_targetType == 'individual' && _selectedUsers.isEmpty) {
          _snack('Select at least one employee');
          return false;
        }
        if (_targetType == 'department' && _selectedDepartment == null) {
          _snack('Select a department');
          return false;
        }
        if (_targetType == 'batch' && _selectedBatch == null) {
          _snack('Select a batch');
          return false;
        }
        return true;
      case 2:
        if (_dueDate == null) {
          _snack('Pick a due date');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  Future<void> _publish() async {
    if (!_validateStep()) return;
    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null) {
      _snack('Not signed in');
      return;
    }

    setState(() => _submitting = true);
    try {
      final created = await client.standaloneAssignment.createStandaloneAssignment(
        organizationId: user!.organizationId,
        title: _titleCtrl.text.trim(),
        instructions:
            _instructionsCtrl.text.trim().isEmpty ? null : _instructionsCtrl.text.trim(),
        dueAt: _dueDate!,
        contentKind: _contentKind,
        questionBankId: _questionBankId,
        courseVersionId: _courseVersionId,
        targetType: _targetType,
        targetDepartmentId: _selectedDepartment?.id,
        targetBatchId: _selectedBatch?.id,
      );
      if (created?.id == null) {
        _snack('Could not create assignment (check permissions)');
        return;
      }

      List<int>? individualIds;
      if (_targetType == 'individual') {
        individualIds = _selectedUsers.map((u) => u.id!).whereType<int>().toList();
      }

      await client.standaloneAssignment.publishStandaloneAssignment(
        created!.id!,
        individualUserIds: individualIds,
      );

      if (!mounted) return;
      _snack('Assignment published');
      context.go('/trainer/assignments');
    } catch (e) {
      _snack('Error: $e');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingMeta) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New assignment campaign'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/trainer/assignments'),
        ),
      ),
      body: Stepper(
        currentStep: _step,
        onStepContinue: () {
          if (!_validateStep()) return;
          if (_step < 4) {
            setState(() => _step++);
          } else {
            _publish();
          }
        },
        onStepCancel: () {
          if (_step > 0) {
            setState(() => _step--);
          } else {
            context.go('/trainer/assignments');
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                FilledButton(
                  onPressed: _submitting ? null : details.onStepContinue,
                  child: Text(_step == 4 ? 'Publish' : 'Continue'),
                ),
                const SizedBox(width: 12),
                TextButton(onPressed: details.onStepCancel, child: const Text('Back')),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Details'),
            isActive: _step >= 0,
            state: _step > 0 ? StepState.complete : StepState.indexed,
            content: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _instructionsCtrl,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Instructions (optional)',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _contentKind,
                      decoration: const InputDecoration(
                        labelText: 'Content type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'open_ended', child: Text('Open-ended')),
                        DropdownMenuItem(value: 'mcq', child: Text('MCQ (question bank)')),
                        DropdownMenuItem(value: 'mixed', child: Text('Mixed')),
                      ],
                      onChanged: (v) => setState(() => _contentKind = v ?? 'open_ended'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Audience'),
            isActive: _step >= 1,
            state: _step > 1 ? StepState.complete : StepState.indexed,
            content: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'individual', label: Text('Individuals')),
                        ButtonSegment(value: 'department', label: Text('Department')),
                        ButtonSegment(value: 'batch', label: Text('Batch')),
                      ],
                      selected: {_targetType},
                      onSelectionChanged: (s) =>
                          setState(() => _targetType = s.first),
                    ),
                    const SizedBox(height: 16),
                    if (_targetType == 'individual') ...[
                      OutlinedButton.icon(
                        onPressed: _pickUsers,
                        icon: const Icon(Icons.people_outline),
                        label: Text(
                          _selectedUsers.isEmpty
                              ? 'Select employees'
                              : '${_selectedUsers.length} selected',
                        ),
                      ),
                    ],
                    if (_targetType == 'department')
                      DropdownButtonFormField<Department>(
                        initialValue: _selectedDepartment,
                        decoration: const InputDecoration(
                          labelText: 'Department',
                          border: OutlineInputBorder(),
                        ),
                        items: _departments
                            .map(
                              (d) => DropdownMenuItem(
                                value: d,
                                child: Text(d.name),
                              ),
                            )
                            .toList(),
                        onChanged: (d) => setState(() => _selectedDepartment = d),
                      ),
                    if (_targetType == 'batch')
                      DropdownButtonFormField<TrainingBatch>(
                        initialValue: _selectedBatch,
                        decoration: const InputDecoration(
                          labelText: 'Training batch',
                          border: OutlineInputBorder(),
                        ),
                        items: _batches
                            .map(
                              (b) => DropdownMenuItem(
                                value: b,
                                child: Text(b.name),
                              ),
                            )
                            .toList(),
                        onChanged: (b) => setState(() => _selectedBatch = b),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Due date & assets'),
            isActive: _step >= 2,
            state: _step > 2 ? StepState.complete : StepState.indexed,
            content: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                        );
                        if (d != null) setState(() => _dueDate = d);
                      },
                      icon: const Icon(Icons.event),
                      label: Text(
                        _dueDate == null
                            ? 'Pick due date'
                            : DateFormat.yMMMd().format(_dueDate!),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int?>(
                      initialValue: _questionBankId,
                      decoration: const InputDecoration(
                        labelText: 'Question bank (optional)',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('None'),
                        ),
                        ..._questionBanks.map(
                          (q) => DropdownMenuItem(
                            value: q.id,
                            child: Text(q.name),
                          ),
                        ),
                      ],
                      onChanged: (v) => setState(() => _questionBankId = v),
                    ),
                    const SizedBox(height: 12),
                    Text('Optional course context', style: PharmaTypography.caption),
                    const SizedBox(height: 8),
                    if (_selectedCourse != null)
                      Text(
                        _selectedCourse!.title,
                        style: PharmaTypography.bodyMedium,
                      ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: _loadingVersions ? null : _pickCourse,
                          child: Text(_selectedCourse == null ? 'Link course' : 'Change course'),
                        ),
                        if (_loadingVersions) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ],
                      ],
                    ),
                    if (_versions.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CourseVersion>(
                        initialValue: _selectedVersion,
                        decoration: const InputDecoration(
                          labelText: 'Course version',
                          border: OutlineInputBorder(),
                        ),
                        items: _versions
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text('v${v.version} — ${v.status}'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          _selectedVersion = v;
                          _courseVersionId = v?.id;
                        }),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Builder tools'),
            isActive: _step >= 3,
            state: _step > 3 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build or refine MCQ content in the Question Bank or Exam Generator, then return here to publish.',
                  style: PharmaTypography.body,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context.push('/trainer/question-bank'),
                      icon: const Icon(Icons.quiz_outlined),
                      label: const Text('Question Bank'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.push('/trainer/exam-generator'),
                      icon: const Icon(Icons.edit_note_outlined),
                      label: const Text('Exam generator'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Review & publish'),
            isActive: _step >= 4,
            state: StepState.indexed,
            content: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${_titleCtrl.text.trim()}',
                      style: PharmaTypography.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Audience: $_targetType', style: PharmaTypography.body),
                  if (_dueDate != null)
                    Text('Due: ${DateFormat.yMMMd().format(_dueDate!)}',
                        style: PharmaTypography.body),
                  if (_questionBankId != null)
                    Text('Question bank id: $_questionBankId',
                        style: PharmaTypography.caption),
                  const SizedBox(height: 16),
                  if (_submitting) const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoursePickDialog extends StatefulWidget {
  const _CoursePickDialog({required this.load});

  final Future<List<Course>> Function(String query) load;

  @override
  State<_CoursePickDialog> createState() => _CoursePickDialogState();
}

class _CoursePickDialogState extends State<_CoursePickDialog> {
  final _ctrl = TextEditingController();
  List<Course> _rows = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _search(String q) async {
    setState(() => _loading = true);
    try {
      final list = await widget.load(q);
      if (mounted) {
        setState(() {
        _rows = list;
        _loading = false;
      });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose course'),
      content: SizedBox(
        width: 400,
        height: 360,
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                hintText: 'Search…',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => _search(v),
            ),
            const SizedBox(height: 8),
            if (_loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _rows.length,
                  itemBuilder: (ctx, i) {
                    final c = _rows[i];
                    return ListTile(
                      title: Text(c.title),
                      onTap: () => Navigator.pop(context, c),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
