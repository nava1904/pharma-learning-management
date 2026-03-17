// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — COURSE BUILDER V2 (TRN-01)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /trainer/courses/:courseId/builder
// Layout: LEFT (module tree) + CENTRE (lesson editor) + RIGHT (context panel)
//
// Principles:
//  - Drag-and-drop module/lesson ordering
//  - DRAFT → UNDER REVIEW → QA APPROVED stepper always visible
//  - Preview as Employee button
//  - Auto-save every 60 seconds
//  - Version history in right sidebar
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;

import '../../core/client.dart';
import '../../design_system/pharma_design_system.dart';
import '../../design_system/pharma_components.dart';

class CourseBuilderV2Screen extends StatefulWidget {
  const CourseBuilderV2Screen({super.key, required this.courseId});

  final int courseId;

  @override
  State<CourseBuilderV2Screen> createState() => _CourseBuilderV2ScreenState();
}

class _CourseBuilderV2ScreenState extends State<CourseBuilderV2Screen> {
  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _selectedVersion;
  List<Module> _modules = [];
  Map<int, List<Lesson>> _lessonsByModule = {};
  int? _selectedModuleId;
  int? _selectedLessonId;
  bool _loading = true;
  String? _error;
  bool _saving = false;
  DateTime? _lastSaved;
  int _autoSaveCount = 0;
  Timer? _autoSaveTimer;

  // Inline controllers
  final _lessonTitleController = TextEditingController();
  final _lessonDurationController = TextEditingController();
  String _lessonType = 'PDF';

  @override
  void initState() {
    super.initState();
    _load();
    _startAutoSave();
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _lessonTitleController.dispose();
    _lessonDurationController.dispose();
    super.dispose();
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted && !_saving && _selectedVersion != null) {
        _saveDraft();
        setState(() => _autoSaveCount++);
      }
    });
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final course = await client.course.getCourse(widget.courseId);
      if (course == null) throw Exception('Course not found');

      final versions = await client.course.getCourseVersions(widget.courseId);
      final draft = versions.where((v) => v.status == 'draft').firstOrNull;
      final editable = draft ?? (versions.isNotEmpty ? versions.first : null);

      List<Module> modules = [];
      Map<int, List<Lesson>> lessonsByModule = {};

      if (editable != null) {
        modules = await client.course.getModulesForCourseVersion(editable.id!);
        for (final m in modules) {
          lessonsByModule[m.id!] = await client.course.getLessonsForModule(m.id!);
        }
      }

      if (mounted) {
        setState(() {
          _course = course;
          _versions = versions;
          _selectedVersion = editable;
          _modules = modules;
          _lessonsByModule = lessonsByModule;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            const SizedBox(height: 12),
            Text(_error!, style: PharmaTypography.body),
            const SizedBox(height: 12),
            FilledButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }

    return Column(
      children: [
        // ── HEADER BAR ──
        _buildHeaderBar(),
        // ── WORKFLOW STEPPER ──
        _buildWorkflowStepper(),
        // ── 3-COLUMN LAYOUT ──
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LEFT: Module & Lesson Tree (280px)
              _buildModuleTree(),
              // CENTRE: Lesson Editor
              Expanded(child: _buildLessonEditor()),
              // RIGHT: Context Panel (240px)
              _buildContextPanel(),
            ],
          ),
        ),
      ],
    );
  }

  // ── HEADER BAR ──
  Widget _buildHeaderBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 10),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/trainer/courses'),
            icon: const Icon(Icons.arrow_back, size: 20),
            color: PharmaColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Text(
                  _course?.title ?? 'Course Builder',
                  style: PharmaTypography.headingMedium.copyWith(fontSize: 16),
                ),
                const SizedBox(width: 8),
                _WorkflowChip(status: _selectedVersion?.status ?? 'draft'),
              ],
            ),
          ),
          // Search
          SizedBox(
            width: 200,
            height: 32,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search lessons...',
                hintStyle: PharmaTypography.caption,
                prefixIcon: const Icon(Icons.search, size: 16),
                filled: true,
                fillColor: PharmaColors.pageBg,
                border: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: PharmaRadius.inputRadius,
                  borderSide: BorderSide(color: PharmaColors.borderLight),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              style: PharmaTypography.caption,
            ),
          ),
          const SizedBox(width: 12),
          // Preview as Employee
          OutlinedButton.icon(
            onPressed: () => context.go('/employee/course/${widget.courseId}'),
            icon: const Icon(Icons.visibility, size: 16),
            label: const Text('Preview as Employee'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.emerald700,
              side: BorderSide(color: PharmaColors.emerald200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
            ),
          ),
          const SizedBox(width: 8),
          // Version History
          OutlinedButton.icon(
            onPressed: () => context.go('/trainer/courses/${widget.courseId}/versions'),
            icon: const Icon(Icons.history, size: 16),
            label: const Text('Versions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: PharmaColors.textSecondary,
              side: BorderSide(color: PharmaColors.borderLight),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: PharmaRadius.buttonRadius),
            ),
          ),
        ],
      ),
    );
  }

  // ── WORKFLOW STEPPER ──
  Widget _buildWorkflowStepper() {
    final status = _selectedVersion?.status ?? 'draft';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PharmaSpacing.lg, vertical: 8),
      decoration: BoxDecoration(
        color: PharmaColors.pageBg,
        border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StepperDot(label: 'DRAFT', isActive: status == 'draft', isCompleted: status != 'draft'),
          _StepperLine(isCompleted: status == 'under_review' || status == 'pending_qa' || status == 'approved' || status == 'published'),
          _StepperDot(label: 'UNDER REVIEW', isActive: status == 'under_review' || status == 'pending_qa', isCompleted: status == 'approved' || status == 'published'),
          _StepperLine(isCompleted: status == 'approved' || status == 'published'),
          _StepperDot(label: 'QA APPROVED', isActive: status == 'approved' || status == 'published', isCompleted: false),
        ],
      ),
    );
  }

  // ── LEFT PANEL: MODULE TREE ──
  Widget _buildModuleTree() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(right: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: Column(
        children: [
          // Module tree header
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.lg),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: Row(
              children: [
                Text('Course Structure',
                    style: PharmaTypography.headingSmall.copyWith(fontSize: 13)),
                const Spacer(),
                IconButton(
                  onPressed: _addModule,
                  icon: const Icon(Icons.add, size: 18),
                  tooltip: 'Add Module',
                  color: PharmaColors.emerald600,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),
          // Module list
          Expanded(
            child: _modules.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_outlined, size: 40, color: PharmaColors.gray300),
                        const SizedBox(height: 8),
                        Text('No modules yet', style: PharmaTypography.body),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: _addModule,
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Module'),
                        ),
                      ],
                    ),
                  )
                : ReorderableListView(
                    onReorder: _reorderModules,
                    children: [
                      for (int i = 0; i < _modules.length; i++)
                        _ModuleTreeItem(
                          key: ValueKey(_modules[i].id),
                          module: _modules[i],
                          index: i,
                          lessons: _lessonsByModule[_modules[i].id!] ?? [],
                          isSelected: _selectedModuleId == _modules[i].id,
                          selectedLessonId: _selectedLessonId,
                          onModuleTap: () => setState(() {
                            _selectedModuleId = _modules[i].id;
                            _selectedLessonId = null;
                          }),
                          onLessonTap: (lessonId) => _selectLesson(lessonId),
                          onAddLesson: () => _addLesson(_modules[i].id!),
                          onDeleteModule: () => _deleteModule(_modules[i].id!),
                        ),
                    ],
                  ),
          ),
          // Add Module CTA
          Container(
            padding: const EdgeInsets.all(PharmaSpacing.md),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: PharmaColors.borderLight)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addModule,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Module'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PharmaColors.emerald600,
                  side: BorderSide(color: PharmaColors.emerald200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── CENTRE PANEL: LESSON EDITOR ──
  Widget _buildLessonEditor() {
    if (_selectedLessonId == null) {
      return Container(
        color: PharmaColors.pageBg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_outlined, size: 56, color: PharmaColors.gray300),
              const SizedBox(height: 16),
              Text(
                'Select a lesson to edit',
                style: PharmaTypography.headingSmall.copyWith(color: PharmaColors.gray500),
              ),
              const SizedBox(height: 8),
              Text(
                'Click on a lesson in the left panel to view and edit its properties.',
                style: PharmaTypography.body,
              ),
            ],
          ),
        ),
      );
    }

    // Find the selected lesson
    Lesson? selectedLesson;
    for (final lessons in _lessonsByModule.values) {
      for (final l in lessons) {
        if (l.id == _selectedLessonId) {
          selectedLesson = l;
          break;
        }
      }
    }

    if (selectedLesson == null) {
      return const Center(child: Text('Lesson not found'));
    }

    return Container(
      color: PharmaColors.pageBg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PharmaSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson header
            Text('Lesson Properties', style: PharmaTypography.headingMedium.copyWith(fontSize: 15)),
            const SizedBox(height: PharmaSpacing.sectionGap),

            // Form fields
            _FormField(
              label: 'Title',
              child: TextField(
                controller: _lessonTitleController..text = selectedLesson.title,
                decoration: _inputDecoration('Enter lesson title'),
                style: PharmaTypography.body,
              ),
            ),

            _FormField(
              label: 'Lesson Type',
              child: DropdownButtonFormField<String>(
                initialValue: _lessonType,
                items: const [
                  DropdownMenuItem(value: 'PDF', child: Row(children: [Icon(Icons.picture_as_pdf, size: 16, color: PharmaColors.danger), SizedBox(width: 8), Text('PDF')])),
                  DropdownMenuItem(value: 'Video', child: Row(children: [Icon(Icons.play_circle, size: 16, color: PharmaColors.info), SizedBox(width: 8), Text('Video')])),
                  DropdownMenuItem(value: 'SCORM', child: Row(children: [Icon(Icons.inventory_2, size: 16, color: PharmaColors.orange), SizedBox(width: 8), Text('SCORM')])),
                  DropdownMenuItem(value: 'xAPI', child: Row(children: [Icon(Icons.code, size: 16, color: PharmaColors.purple), SizedBox(width: 8), Text('xAPI')])),
                  DropdownMenuItem(value: 'HTML', child: Row(children: [Icon(Icons.web, size: 16, color: PharmaColors.success), SizedBox(width: 8), Text('Embedded HTML')])),
                  DropdownMenuItem(value: 'Checklist', child: Row(children: [Icon(Icons.checklist, size: 16, color: PharmaColors.emerald600), SizedBox(width: 8), Text('Practical Checklist')])),
                ],
                onChanged: (v) => setState(() => _lessonType = v ?? 'PDF'),
                decoration: _inputDecoration(''),
              ),
            ),

            _FormField(
              label: 'Estimated Duration',
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _lessonDurationController
                        ..text = '${selectedLesson.durationMinutes ?? 15}',
                      decoration: _inputDecoration(''),
                      keyboardType: TextInputType.number,
                      style: PharmaTypography.body,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('minutes', style: PharmaTypography.body),
                ],
              ),
            ),

            _FormField(
              label: 'Minimum Engagement Time (Enforced)',
              child: DropdownButtonFormField<int>(
                initialValue: 5,
                items: [5, 10, 15, 20, 30, 45, 60]
                    .map((m) => DropdownMenuItem(
                          value: m,
                          child: Text('$m minutes'),
                        ))
                    .toList(),
                onChanged: (_) {},
                decoration: _inputDecoration(''),
              ),
            ),

            _FormField(
              label: 'Prerequisites',
              child: DropdownButtonFormField<String>(
                initialValue: 'none',
                items: const [
                  DropdownMenuItem(value: 'none', child: Text('None Required')),
                  DropdownMenuItem(
                      value: 'previous', child: Text('Complete previous lesson')),
                ],
                onChanged: (_) {},
                decoration: _inputDecoration(''),
              ),
            ),

            const SizedBox(height: PharmaSpacing.sectionGap),

            // Action buttons
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete Lesson'),
                        content: const Text('Are you sure? This cannot be undone.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text('Delete', style: TextStyle(color: PharmaColors.danger)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      try {
                        await client.courseBuilder.deleteLesson(lessonId: _selectedLessonId!);
                        setState(() {
                          for (final entry in _lessonsByModule.entries) {
                            entry.value.removeWhere((l) => l.id == _selectedLessonId);
                          }
                          _selectedLessonId = null;
                        });
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error deleting lesson: $e')),
                          );
                        }
                      }
                    }
                  },
                  icon: Icon(Icons.delete_outline, size: 16, color: PharmaColors.danger),
                  label: Text('Delete Lesson',
                      style: TextStyle(color: PharmaColors.danger)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: PharmaColors.dangerBg),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => context.go(
                    '/trainer/courses/${widget.courseId}/lessons/${selectedLesson?.id}/material',
                  ),
                  icon: const Icon(Icons.upload_file, size: 16),
                  label: const Text('Upload Material'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.info,
                    side: BorderSide(color: PharmaColors.infoBg),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _saving ? null : () => _saveLessonChanges(selectedLesson!),
                  icon: const Icon(Icons.save, size: 16),
                  label: Text(_saving ? 'Saving...' : 'Save Changes'),
                  style: FilledButton.styleFrom(
                    backgroundColor: PharmaColors.emerald600,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── RIGHT PANEL: CONTEXT ──
  Widget _buildContextPanel() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border(left: BorderSide(color: PharmaColors.borderLight)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PharmaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trainer avatar card
            Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: PharmaColors.emerald100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'T',
                        style: PharmaTypography.headingLarge.copyWith(
                          color: PharmaColors.emerald700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Trainer', style: PharmaTypography.bodyMedium),
                  Text('Subject Matter Expert', style: PharmaTypography.caption),
                ],
              ),
            ),

            const SizedBox(height: PharmaSpacing.sectionGap),
            Divider(color: PharmaColors.borderLight),
            const SizedBox(height: PharmaSpacing.lg),

            // Version info
            Text('VERSION', style: _sectionLabelStyle),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PharmaColors.pageBg,
                borderRadius: PharmaRadius.cardRadius,
                border: Border.all(color: PharmaColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'v${_selectedVersion?.version ?? '1.0'}',
                    style: PharmaTypography.bodyMedium.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  _WorkflowChip(status: _selectedVersion?.status ?? 'draft'),
                ],
              ),
            ),

            const SizedBox(height: PharmaSpacing.lg),

            // Version History
            Text('HISTORY', style: _sectionLabelStyle),
            const SizedBox(height: 8),
            ...(_versions.take(5).map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(
                        'v${v.version}',
                        style: PharmaTypography.caption.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _WorkflowChip(status: v.status),
                    ],
                  ),
                ))),

            const SizedBox(height: PharmaSpacing.sectionGap),
            Divider(color: PharmaColors.borderLight),
            const SizedBox(height: PharmaSpacing.lg),

            // Save Draft CTA
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _saveDraft,
                icon: const Icon(Icons.save, size: 16),
                label: Text(_saving ? 'Saving...' : 'Save Draft'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Submit for QA
            if (_selectedVersion?.status == 'draft')
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showPreSubmissionChecklist(),
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Submit for QA'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PharmaColors.warning,
                    side: BorderSide(color: PharmaColors.warning),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

            const SizedBox(height: PharmaSpacing.lg),

            // Auto-save indicator
            PharmaAutosaveIndicator(
              isSaving: _saving,
              lastSaved: _lastSaved,
            ),
          ],
        ),
      ),
    );
  }

  // ── HELPERS ──

  TextStyle get _sectionLabelStyle => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: PharmaColors.textQuaternary,
        letterSpacing: 0.7,
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: PharmaTypography.body.copyWith(color: PharmaColors.textQuaternary),
        filled: true,
        fillColor: PharmaColors.cardBg,
        border: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PharmaRadius.inputRadius,
          borderSide: BorderSide(color: PharmaColors.emerald500),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

  Future<void> _showPreSubmissionChecklist() async {
    if (_selectedVersion == null) return;
    final selectedVersionId = _selectedVersion!.id!;

    QaValidationResult validation;
    try {
      validation = await client.courseBuilder
          .validateForQaSubmission(courseVersionId: selectedVersionId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Validation failed: $e')),
        );
      }
      return;
    }

    if (!mounted) return;
    final v = validation;
    final allPassed = v.allPassed;
    final results = v.validationResults;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          Icon(
            allPassed ? Icons.check_circle : Icons.warning,
            color: allPassed ? PharmaColors.emerald600 : PharmaColors.warning,
          ),
          const SizedBox(width: 8),
          const Text('Pre-Submission Checklist'),
        ]),
        content: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              '${v.passedCount}/${v.totalRules} checks passed',
              style: PharmaTypography.body,
            ),
            const SizedBox(height: 16),
            PharmaValidationChecklist(results: results),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          if (allPassed)
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: PharmaColors.emerald600,
              ),
              child: const Text('Submit for QA Review'),
            ),
        ],
      ),
    );

    if (proceed == true) {
      try {
        await client.courseBuilder
            .submitForQaReview(courseVersionId: selectedVersionId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Submitted for QA review')),
          );
          context.go('/trainer/courses/${widget.courseId}/qa-review');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submission failed: $e')),
          );
        }
      }
    }
  }

  Future<void> _saveLessonChanges(Lesson lesson) async {
    setState(() => _saving = true);
    try {
      await client.courseBuilder.updateLesson(
        lessonId: lesson.id!,
        title: _lessonTitleController.text,
        durationMinutes: int.tryParse(_lessonDurationController.text) ?? 15,
      );
      setState(() => _lastSaved = DateTime.now());
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _saveDraft() async {
    if (_selectedVersion == null) return;
    setState(() => _saving = true);
    try {
      for (int i = 0; i < _modules.length; i++) {
        final m = _modules[i];
        await client.courseBuilder.updateModule(
          moduleId: m.id!,
          orderIndex: i,
        );
      }
      setState(() => _lastSaved = DateTime.now());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _selectLesson(int lessonId) {
    setState(() {
      _selectedLessonId = lessonId;
    });
    // Load lesson details into controllers
    for (final lessons in _lessonsByModule.values) {
      for (final l in lessons) {
        if (l.id == lessonId) {
          _lessonTitleController.text = l.title;
          _lessonDurationController.text = '${l.durationMinutes ?? 15}';
          break;
        }
      }
    }
  }

  Future<void> _addModule() async {
    if (_selectedVersion == null) return;
    try {
      final module = await client.courseBuilder.createModule(
        courseVersionId: _selectedVersion!.id!,
        title: 'Module ${_modules.length + 1}',
        orderIndex: _modules.length,
      );
      await client.auditTrail.logAction(
        action: 'ModuleAdded',
        entityType: 'module',
        entityId: module.id!.toString(),
        newValueJson: '{"course_version_id":${_selectedVersion!.id},"title":"${module.title}"}',
      );
      setState(() {
        _modules.add(module);
        _lessonsByModule[module.id!] = [];
        _selectedModuleId = module.id;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating module: $e')),
        );
      }
    }
  }

  Future<void> _addLesson(int moduleId) async {
    final titleController = TextEditingController(text: 'New Lesson');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Lesson'),
        content: SizedBox(
          width: 360,
          child: TextField(
            controller: titleController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Lesson Title',
              hintText: 'Enter lesson title...',
              filled: true,
              fillColor: PharmaColors.pageBg,
              border: OutlineInputBorder(borderRadius: PharmaRadius.inputRadius),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, titleController.text),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (result == null || result.trim().isEmpty) return;

    try {
      final material = await client.material.createMaterial(
        title: '${result.trim()} Material',
        materialType: 'document',
        organizationId: _course!.organizationId,
      );
      final lesson = await client.courseBuilder.createLesson(
        moduleId: moduleId,
        title: result.trim(),
        materialId: material.id!,
        orderIndex: (_lessonsByModule[moduleId]?.length ?? 0),
      );
      await client.auditTrail.logAction(
        action: 'LessonAdded',
        entityType: 'lesson',
        entityId: lesson.id!.toString(),
        newValueJson: '{"module_id":$moduleId}',
      );
      setState(() {
        _lessonsByModule[moduleId] = [...(_lessonsByModule[moduleId] ?? []), lesson];
        _selectedLessonId = lesson.id;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating lesson: $e')),
        );
      }
    }
  }

  Future<void> _deleteModule(int moduleId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Module?'),
        content: const Text('This will delete the module and all its lessons. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await client.courseBuilder.deleteModule(moduleId: moduleId);
      setState(() {
        _modules.removeWhere((m) => m.id == moduleId);
        _lessonsByModule.remove(moduleId);
        if (_selectedModuleId == moduleId) _selectedModuleId = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _reorderModules(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    setState(() {
      final m = _modules.removeAt(oldIndex);
      _modules.insert(newIndex, m);
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MODULE TREE ITEM
// ═══════════════════════════════════════════════════════════════════════════════

class _ModuleTreeItem extends StatelessWidget {
  const _ModuleTreeItem({
    super.key,
    required this.module,
    required this.index,
    required this.lessons,
    required this.isSelected,
    required this.selectedLessonId,
    required this.onModuleTap,
    required this.onLessonTap,
    required this.onAddLesson,
    required this.onDeleteModule,
  });

  final Module module;
  final int index;
  final List<Lesson> lessons;
  final bool isSelected;
  final int? selectedLessonId;
  final VoidCallback onModuleTap;
  final Function(int) onLessonTap;
  final VoidCallback onAddLesson;
  final VoidCallback onDeleteModule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Module header
        InkWell(
          onTap: onModuleTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: isSelected ? PharmaColors.emerald50 : Colors.transparent,
            child: Row(
              children: [
                Icon(Icons.drag_indicator, size: 16, color: PharmaColors.gray300),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: lessons.isNotEmpty ? PharmaColors.infoBg : PharmaColors.gray100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: lessons.isNotEmpty ? PharmaColors.infoText : PharmaColors.gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    module.title,
                    style: PharmaTypography.bodyMedium.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  iconSize: 16,
                  icon: Icon(Icons.more_vert, size: 16, color: PharmaColors.gray400),
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(value: 'add', child: Text('Add Lesson')),
                    const PopupMenuItem(value: 'rename', child: Text('Rename')),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: PharmaColors.danger)),
                    ),
                  ],
                  onSelected: (v) {
                    switch (v) {
                      case 'add':
                        onAddLesson();
                        break;
                      case 'delete':
                        onDeleteModule();
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        // Lessons
        ...lessons.map((lesson) => InkWell(
              onTap: () => onLessonTap(lesson.id!),
              child: Container(
                padding: const EdgeInsets.only(left: 44, right: 12, top: 6, bottom: 6),
                color: selectedLessonId == lesson.id
                    ? PharmaColors.emerald50
                    : Colors.transparent,
                child: Row(
                  children: [
                    _lessonTypeIcon(lesson),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        lesson.title,
                        style: PharmaTypography.body.copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (lesson.durationMinutes != null)
                      Text(
                        '${lesson.durationMinutes}m',
                        style: PharmaTypography.caption.copyWith(fontSize: 10),
                      ),
                  ],
                ),
              ),
            )),
        // Add lesson inline
        InkWell(
          onTap: onAddLesson,
          child: Container(
            padding: const EdgeInsets.only(left: 44, right: 12, top: 4, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.add, size: 14, color: PharmaColors.emerald500),
                const SizedBox(width: 4),
                Text(
                  'Add Lesson',
                  style: PharmaTypography.caption.copyWith(
                    color: PharmaColors.emerald600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: PharmaColors.borderLight),
      ],
    );
  }

  Widget _lessonTypeIcon(Lesson lesson) {
    // Default to PDF icon
    return Icon(Icons.description, size: 14, color: PharmaColors.danger);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _WorkflowChip extends StatelessWidget {
  const _WorkflowChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;
    switch (status) {
      case 'draft':
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray700;
        label = 'DRAFT';
        break;
      case 'pending_qa':
      case 'under_review':
        bg = PharmaColors.warningBg;
        fg = PharmaColors.warningText;
        label = 'UNDER REVIEW';
        break;
      case 'approved':
      case 'published':
      case 'effective':
        bg = PharmaColors.successBg;
        fg = PharmaColors.successText;
        label = 'QA APPROVED';
        break;
      case 'rejected':
        bg = PharmaColors.dangerBg;
        fg = PharmaColors.dangerText;
        label = 'REJECTED';
        break;
      default:
        bg = PharmaColors.gray100;
        fg = PharmaColors.gray600;
        label = status.toUpperCase();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: PharmaRadius.pillRadius,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.5),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PharmaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PharmaTypography.labelLarge.copyWith(fontSize: 13)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _StepperDot extends StatelessWidget {
  const _StepperDot({
    required this.label,
    required this.isActive,
    required this.isCompleted,
  });

  final String label;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive || isCompleted
                ? PharmaColors.emerald600
                : PharmaColors.gray200,
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 14, color: PharmaColors.cardBg)
              : isActive
                  ? const Icon(Icons.circle, size: 8, color: PharmaColors.cardBg)
                  : null,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive
                ? PharmaColors.emerald700
                : isCompleted
                    ? PharmaColors.emerald600
                    : PharmaColors.gray400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _StepperLine extends StatelessWidget {
  const _StepperLine({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isCompleted ? PharmaColors.emerald500 : PharmaColors.gray200,
    );
  }
}
