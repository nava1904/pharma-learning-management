import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as protocol;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../design_system/colors.dart';
import '../../widgets/empty_state.dart';
import 'new_version_dialog.dart';

/// Course Builder - Odoo eLearning style unified workspace.
/// Enforces TRN-WF-01 (Create Course) and TRN-WF-05 (New Version with change summary).
class CourseBuilderScreen extends StatefulWidget {
  const CourseBuilderScreen({
    super.key,
    this.courseId,
  });

  final int? courseId;

  @override
  State<CourseBuilderScreen> createState() => _CourseBuilderScreenState();
}

class _CourseBuilderScreenState extends State<CourseBuilderScreen>
    with SingleTickerProviderStateMixin {
  // Data state
  Course? _course;
  List<CourseVersion> _versions = [];
  CourseVersion? _selectedVersion;
  List<Module> _modules = [];
  Map<int, List<Lesson>> _lessonsByModule = {};
  Assessment? _assessment;
  List<QuestionBank> _questionBanks = [];
  Map<int, String> _materialTypeByMaterialId = {};

  // UI state
  bool _loading = true;
  String? _error;
  bool _saving = false;
  late TabController _tabController;

  // Inline add controllers
  final Map<int, TextEditingController> _inlineLessonControllers = {};
  final TextEditingController _inlineModuleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inlineModuleController.dispose();
    for (final c in _inlineLessonControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    if (widget.courseId == null) {
      setState(() {
        _error = 'No course selected. Please select a course first.';
        _loading = false;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final course = await client.course.getCourse(widget.courseId!);
      if (course == null) {
        setState(() {
          _error = 'Course not found';
          _loading = false;
        });
        return;
      }

      final versions = await client.course.getCourseVersions(course.id!);
      final draft = versions.where((v) => v.status == 'draft').firstOrNull;
      final editable = draft ??
          versions.where((v) => v.status != 'approved' && v.status != 'effective').firstOrNull ??
          (versions.isNotEmpty ? versions.first : null);

      if (mounted) {
        setState(() {
          _course = course;
          _versions = versions;
          _selectedVersion = editable;
          _loading = false;
        });

        if (_selectedVersion != null) {
          await Future.wait([
            _loadModules(),
            _loadAssessment(),
            _loadMaterialsMap(),
            _loadQuestionBanks(),
          ]);
        }
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

  Future<void> _loadModules() async {
    if (_selectedVersion?.id == null) return;
    try {
      final modules = await client.course.getModulesForCourseVersion(_selectedVersion!.id!);
      if (mounted) {
        setState(() {
          _modules = modules;
          _lessonsByModule = {};
        });
        // Load lessons for all modules
        for (final m in modules) {
          if (m.id != null) {
            _loadLessonsForModule(m.id!);
          }
        }
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _loadLessonsForModule(int moduleId) async {
    try {
      final lessons = await client.course.getLessonsForModule(moduleId);
      if (mounted) {
        setState(() => _lessonsByModule[moduleId] = lessons);
      }
    } catch (_) {
      if (mounted) setState(() => _lessonsByModule[moduleId] = []);
    }
  }

  Future<void> _loadAssessment() async {
    if (_selectedVersion?.id == null) return;
    try {
      final assessment = await client.assessment.getAssessmentForCourse(_selectedVersion!.id!);
      if (mounted) setState(() => _assessment = assessment);
    } catch (_) {
      if (mounted) setState(() => _assessment = null);
    }
  }

  Future<void> _loadMaterialsMap() async {
    final orgId = _course?.organizationId;
    if (orgId == null) return;
    try {
      final materials = await client.material.listMaterials(organizationId: orgId);
      final map = <int, String>{};
      for (final m in materials) {
        if (m.id != null) map[m.id!] = m.materialType.toLowerCase();
      }
      if (mounted) setState(() => _materialTypeByMaterialId = map);
    } catch (_) {}
  }

  Future<void> _loadQuestionBanks() async {
    final orgId = _course?.organizationId;
    if (orgId == null) return;
    try {
      final banks = await client.assessment.listQuestionBanks(organizationId: orgId);
      if (mounted) setState(() => _questionBanks = banks);
    } catch (_) {}
  }

  bool get _isVersionEditable =>
      _selectedVersion != null &&
      _selectedVersion!.status != 'approved' &&
      _selectedVersion!.status != 'effective';

  int get _totalLessons =>
      _lessonsByModule.values.fold<int>(0, (sum, list) => sum + list.length);

  bool get _canSubmitForQa {
    if (_selectedVersion?.status != 'draft') return false;
    if (_modules.isEmpty) return false;
    if (_totalLessons == 0) return false;
    return true;
  }

  /// TRN-WF-04 Validation Checklist (Client-side fallback)
  /// Now primarily handled by backend validateForQaSubmission endpoint.
  /// Kept for offline validation preview if needed.
  // ignore: unused_element
  Future<List<_ValidationRule>> _getTrnWf04ChecklistClientSide() async {
    final rules = <_ValidationRule>[];

    // Rule 1: All Modules must have >= 1 Lesson
    bool allModulesHaveLessons = true;
    final modulesWithoutLessons = <String>[];
    for (final m in _modules) {
      if (m.id != null) {
        final count = _lessonsByModule[m.id]?.length ?? 0;
        if (count < 1) {
          allModulesHaveLessons = false;
          modulesWithoutLessons.add(m.title);
        }
      }
    }
    rules.add(_ValidationRule(
      title: 'All modules have at least 1 lesson',
      description: _modules.isEmpty
          ? 'No modules created yet'
          : allModulesHaveLessons
              ? '${_modules.length} module(s) with ${_totalLessons} lesson(s) total'
              : 'Missing lessons in: ${modulesWithoutLessons.join(", ")}',
      passed: _modules.isNotEmpty && allModulesHaveLessons,
      icon: Icons.view_module_outlined,
    ));

    // Rule 2: All Lessons must have an associated Material linked
    bool allLessonsHaveMaterial = true;
    final lessonsWithoutMaterial = <String>[];
    for (final lessons in _lessonsByModule.values) {
      for (final lesson in lessons) {
        // materialId is required in Lesson model, but check if it's valid (> 0)
        if (lesson.materialId <= 0) {
          allLessonsHaveMaterial = false;
          lessonsWithoutMaterial.add(lesson.title);
        }
      }
    }
    rules.add(_ValidationRule(
      title: 'All lessons have linked material',
      description: _totalLessons == 0
          ? 'No lessons created yet'
          : allLessonsHaveMaterial
              ? 'All ${_totalLessons} lesson(s) have content attached'
              : 'Missing material in: ${lessonsWithoutMaterial.take(3).join(", ")}${lessonsWithoutMaterial.length > 3 ? " (+${lessonsWithoutMaterial.length - 3} more)" : ""}',
      passed: _totalLessons > 0 && allLessonsHaveMaterial,
      icon: Icons.attach_file,
    ));

    // Rule 3: An Assessment must be linked to this CourseVersion
    rules.add(_ValidationRule(
      title: 'Assessment configured',
      description: _assessment != null
          ? 'Assessment linked (Pass: ${_assessment!.passingScore}%, Time: ${_assessment!.timeLimitMinutes ?? "No"} min limit)'
          : 'No assessment linked to this course version',
      passed: _assessment != null,
      icon: Icons.quiz_outlined,
    ));

    // Rule 4: The Assessment must pass the 2x Question Pool rule
    bool questionPoolValid = false;
    String questionPoolDescription = 'Assessment not configured';
    int questionBankCount = 0;
    int questionsToDisplay = 0;

    if (_assessment != null) {
      try {
        // Get questions from the assessment's question bank
        final questions = await client.assessment.getQuestions(_assessment!.questionBankId);
        questionBankCount = questions.length;
        
        // For now, use total questions if questionsToDisplay not yet in model
        // After serverpod generate, this would be: _assessment!.questionsToDisplay ?? questionBankCount
        questionsToDisplay = questionBankCount; // Default: display all questions
        
        // TRN-WF-03 Rule: questionsToDisplay <= questionBankCount / 2
        // This ensures adequate randomization for assessment integrity
        final minimumRequired = questionsToDisplay * 2;
        questionPoolValid = questionBankCount >= minimumRequired;
        
        if (questionPoolValid) {
          questionPoolDescription = '$questionBankCount questions in bank (≥$minimumRequired required for $questionsToDisplay displayed)';
        } else {
          questionPoolDescription = 'Need ${minimumRequired - questionBankCount} more questions. Bank has $questionBankCount, need $minimumRequired for $questionsToDisplay displayed.';
        }
      } catch (e) {
        questionPoolDescription = 'Unable to verify question bank: $e';
        questionPoolValid = false;
      }
    }

    rules.add(_ValidationRule(
      title: '2x Question Pool Rule (TRN-WF-03)',
      description: questionPoolDescription,
      passed: _assessment != null && questionPoolValid,
      icon: Icons.balance,
      subtitle: 'Questions to display must be ≤ Question Bank / 2',
    ));

    return rules;
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // ACTIONS
  // ─────────────────────────────────────────────────────────────────────────────

  void _previewAsLearner() {
    final courseId = _course?.id;
    final versionId = _selectedVersion?.id;
    if (courseId == null || versionId == null) return;
    context.push(
      '/course/$courseId',
      extra: {
        'courseVersionId': versionId,
        'userId': 0,
        'preview': true,
      },
    );
  }

  Future<void> _saveChanges() async {
    // Placeholder for future explicit save functionality
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All changes saved'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  /// TRN-WF-04: Submit for QA with strict validation gate
  /// Uses backend validation for server-side validation enforcement.
  Future<void> _submitForQa() async {
    if (_selectedVersion?.id == null) return;

    // Show loading indicator while running backend validation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Running TRN-WF-04 validation...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Call backend validation endpoint
      final validation = await client.courseBuilder.validateForQaSubmission(
        courseVersionId: _selectedVersion!.id!,
      );
      
      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog
      
      // Convert backend validation results to UI format
      final validationResults = validation['validationResults'] as List<dynamic>;
      final rules = validationResults.map((r) => _ValidationRule(
        title: r['rule'] as String,
        description: r['detail'] as String,
        passed: r['passed'] as bool,
        icon: _getIconForRule(r['rule'] as String),
        subtitle: r['description'] as String?,
      )).toList();
      
      final allPass = validation['allPassed'] as bool;
      final passedCount = validation['passedCount'] as int;
      
      // Show Odoo-style modal bottom sheet with validation results
      final proceed = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => _TrnWf04ValidationSheet(
          rules: rules,
          allPass: allPass,
          passedCount: passedCount,
          courseName: _course?.title ?? 'Course',
          versionNumber: _selectedVersion!.version.toString(),
        ),
      );

      if (proceed != true || !mounted) return;

      // All validations passed - submit to backend using new submitForQaReview endpoint
      await client.courseBuilder.submitForQaReview(
        courseVersionId: _selectedVersion!.id!,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Course submitted for QA review')),
              ],
            ),
            backgroundColor: AppColors.success,
          ),
        );
        // Navigate back to trainer dashboard
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog if still open
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e'), backgroundColor: AppColors.destructive),
        );
      }
    }
  }
  
  /// Helper to map rule names to icons
  IconData _getIconForRule(String ruleName) {
    switch (ruleName) {
      case 'Course Status':
        return Icons.info_outline;
      case 'Modules Exist':
        return Icons.view_module_outlined;
      case 'All Modules Have Lessons':
        return Icons.view_module_outlined;
      case 'All Lessons Have Material':
        return Icons.attach_file;
      case 'Assessment Configured':
        return Icons.quiz_outlined;
      case '2x Question Pool Rule (TRN-WF-03)':
        return Icons.balance;
      default:
        return Icons.check_circle_outline;
    }
  }

  /// TRN-WF-05: Create new version with required change summary for superseding.
  /// This copies all modules, lessons, and assessment from the existing version.
  Future<void> _showNewVersionDialog() async {
    if (_course?.id == null || _selectedVersion == null) return;

    // Show the TRN-WF-05 compliant dialog
    final result = await NewVersionDialog.show(
      context,
      existingVersion: _selectedVersion!,
      courseTitle: _course?.title ?? 'Course',
      createdById: _course?.createdById,
    );

    if (result == null || !mounted) return;

    // Parse the new version from result and reload
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Version ${result['newVersion']} created'),
                  Text(
                    '${result['modulesCopied']} modules copied',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Reload to show the new version
    await _load();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // MODULE & LESSON CRUD (TRN-WF-01)
  // ─────────────────────────────────────────────────────────────────────────────

  Future<void> _addModuleInline() async {
    if (_selectedVersion == null || !_isVersionEditable) return;
    final title = _inlineModuleController.text.trim();
    if (title.isEmpty) return;

    try {
      await client.courseBuilder.createModule(
        courseVersionId: _selectedVersion!.id!,
        title: title,
        orderIndex: _modules.length,
      );
      _inlineModuleController.clear();
      if (mounted) _loadModules();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: AppColors.destructive),
        );
      }
    }
  }

  Future<void> _addLessonInline(Module module) async {
    if (!_isVersionEditable) return;
    final controller = _inlineLessonControllers[module.id];
    final title = controller?.text.trim() ?? '';
    if (title.isEmpty) return;

    // Show material picker
    final orgId = _course?.organizationId;
    if (orgId == null) return;

    List<protocol.Material> materials = [];
    try {
      materials = await client.material.listMaterials(organizationId: orgId);
    } catch (_) {}

    if (materials.isEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No materials found. Upload materials first.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    protocol.Material? selected;
    if (mounted) {
      selected = await showDialog<protocol.Material>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: Text('Select Material for "$title"'),
          children: materials.map((m) {
            IconData icon;
            Color iconColor;
            switch (m.materialType.toLowerCase()) {
              case 'pdf':
                icon = Icons.picture_as_pdf;
                iconColor = AppColors.destructive;
                break;
              case 'video':
                icon = Icons.videocam;
                iconColor = AppColors.indigo600;
                break;
              case 'scorm':
                icon = Icons.quiz;
                iconColor = AppColors.teal600;
                break;
              default:
                icon = Icons.insert_drive_file;
                iconColor = AppColors.slate500;
            }
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, m),
              child: Row(
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(m.title)),
                  Text(
                    m.materialType.toUpperCase(),
                    style: TextStyle(color: AppColors.slate500, fontSize: 11),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    if (selected?.id == null || !mounted) return;

    try {
      final lessons = _lessonsByModule[module.id] ?? [];
      await client.courseBuilder.createLesson(
        moduleId: module.id!,
        title: title,
        materialId: selected!.id!,
        orderIndex: lessons.length,
      );
      controller?.clear();
      if (mounted) _loadLessonsForModule(module.id!);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: AppColors.destructive),
        );
      }
    }
  }

  Future<void> _reorderModules(int oldIndex, int newIndex) async {
    if (!_isVersionEditable) return;
    if (oldIndex < newIndex) newIndex -= 1;

    final module = _modules[oldIndex];
    setState(() {
      _modules.removeAt(oldIndex);
      _modules.insert(newIndex, module);
    });

    try {
      await client.courseBuilder.updateModule(
        moduleId: module.id!,
        orderIndex: newIndex,
      );
    } catch (e) {
      if (mounted) {
        _loadModules(); // Revert on error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: AppColors.destructive),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // ASSESSMENT CRUD
  // ─────────────────────────────────────────────────────────────────────────────

  Future<void> _createOrUpdateAssessment() async {
    if (_selectedVersion?.id == null || !_isVersionEditable) return;

    if (_questionBanks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No question banks found. Create one first.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    QuestionBank? selectedBank = _assessment != null
        ? _questionBanks.where((q) => q.id == _assessment!.questionBankId).firstOrNull
        : _questionBanks.first;
    int passingScore = _assessment?.passingScore ?? 80;
    bool randomize = _assessment?.randomize ?? true;
    int? timeLimit = _assessment?.timeLimitMinutes;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDialogState) => AlertDialog(
          title: Text(_assessment == null ? 'Configure Assessment' : 'Update Assessment'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Question Bank', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButtonFormField<QuestionBank>(
                  initialValue: selectedBank,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: AppColors.slate50,
                  ),
                  items: _questionBanks
                      .map((q) => DropdownMenuItem(value: q, child: Text(q.name)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedBank = v),
                ),
                const SizedBox(height: 16),
                const Text('Passing Score (%)', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Slider(
                  value: passingScore.toDouble(),
                  min: 50,
                  max: 100,
                  divisions: 10,
                  label: '$passingScore%',
                  onChanged: (v) => setDialogState(() => passingScore = v.round()),
                ),
                Center(
                  child: Text(
                    '$passingScore%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: passingScore >= 80 ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Randomize Questions'),
                  subtitle: const Text('Shuffle question order for each attempt'),
                  value: randomize,
                  onChanged: (v) => setDialogState(() => randomize = v),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                const Text('Time Limit (minutes, optional)', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Leave empty for no limit',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: AppColors.slate50,
                  ),
                  controller: TextEditingController(text: timeLimit?.toString() ?? ''),
                  onChanged: (v) => timeLimit = int.tryParse(v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                if (selectedBank?.id == null) return;
                Navigator.pop(ctx, {
                  'questionBankId': selectedBank!.id!,
                  'passingScore': passingScore,
                  'randomize': randomize,
                  'timeLimit': timeLimit,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );

    if (result == null || !mounted) return;

    try {
      if (_assessment == null) {
        await client.assessmentBuilder.createAssessment(
          courseVersionId: _selectedVersion!.id!,
          questionBankId: result['questionBankId'] as int,
          passingScore: result['passingScore'] as int,
          randomize: result['randomize'] as bool,
          timeLimitMinutes: result['timeLimit'] as int?,
        );
      } else {
        await client.assessmentBuilder.updateAssessment(
          assessmentId: _assessment!.id!,
          passingScore: result['passingScore'] as int,
          randomize: result['randomize'] as bool,
          timeLimitMinutes: result['timeLimit'] as int?,
        );
      }
      if (mounted) {
        _loadAssessment();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assessment saved'), backgroundColor: AppColors.success),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: AppColors.destructive),
        );
      }
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Builder')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Builder')),
        body: EmptyState(
          message: _error!,
          icon: Icons.error_outline,
          action: FilledButton(onPressed: _load, child: const Text('Retry')),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _buildStickyHeader(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCurriculumTab(),
                _buildAssessmentTab(),
                _buildSettingsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top row: Back, Title, Status, Version dropdown, Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                    tooltip: 'Back',
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _course?.title ?? 'Course',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate900,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (_course?.sopNumber != null && _course!.sopNumber!.isNotEmpty)
                          Text(
                            'SOP: ${_course!.sopNumber}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate500,
                                ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildStatusBadge(),
                  const SizedBox(width: 16),
                  _buildVersionDropdown(),
                  const SizedBox(width: 24),
                  // Action buttons
                  OutlinedButton.icon(
                    onPressed: _previewAsLearner,
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('Preview'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: _saving ? null : _saveChanges,
                    icon: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save, size: 18),
                    label: const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: _canSubmitForQa ? _submitForQa : null,
                    icon: const Icon(Icons.send, size: 18),
                    label: const Text('Submit to QA'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _canSubmitForQa ? AppColors.teal600 : null,
                    ),
                  ),
                ],
              ),
            ),
            // Tab bar
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.slate100)),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.indigo600,
                unselectedLabelColor: AppColors.slate500,
                indicatorColor: AppColors.indigo600,
                indicatorWeight: 3,
                tabs: const [
                  Tab(icon: Icon(Icons.menu_book), text: 'Curriculum'),
                  Tab(icon: Icon(Icons.quiz), text: 'Assessment'),
                  Tab(icon: Icon(Icons.settings), text: 'Settings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = _selectedVersion?.status ?? 'draft';
    Color bgColor;
    Color fgColor;
    IconData icon;

    switch (status) {
      case 'effective':
      case 'approved':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        fgColor = AppColors.success;
        icon = Icons.check_circle;
        break;
      case 'pending_approval':
        bgColor = AppColors.warning.withValues(alpha: 0.15);
        fgColor = AppColors.warning;
        icon = Icons.hourglass_empty;
        break;
      case 'rejected':
        bgColor = AppColors.destructive.withValues(alpha: 0.15);
        fgColor = AppColors.destructive;
        icon = Icons.cancel;
        break;
      default:
        bgColor = AppColors.slate200;
        fgColor = AppColors.slate600;
        icon = Icons.edit;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fgColor),
          const SizedBox(width: 6),
          Text(
            status.replaceAll('_', ' ').toUpperCase(),
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.slate300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CourseVersion>(
          value: _selectedVersion,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: [
            ..._versions.map((v) => DropdownMenuItem(
                  value: v,
                  child: Row(
                    children: [
                      Text('v${v.version}'),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: v.status == 'effective'
                              ? AppColors.success.withValues(alpha: 0.2)
                              : AppColors.slate100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          v.status,
                          style: TextStyle(fontSize: 10, color: AppColors.slate600),
                        ),
                      ),
                    ],
                  ),
                )),
            DropdownMenuItem(
              value: null,
              child: Row(
                children: [
                  Icon(Icons.add, size: 18, color: AppColors.indigo600),
                  const SizedBox(width: 8),
                  Text('New Version...', style: TextStyle(color: AppColors.indigo600)),
                ],
              ),
            ),
          ],
          onChanged: (v) {
            if (v == null) {
              _showNewVersionDialog();
            } else {
              setState(() => _selectedVersion = v);
              _loadModules();
              _loadAssessment();
            }
          },
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TAB 1: CURRICULUM (TRN-WF-01)
  // ─────────────────────────────────────────────────────────────────────────────

  Widget _buildCurriculumTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats row
          Row(
            children: [
              _StatChip(
                icon: Icons.folder,
                label: '${_modules.length} Modules',
                color: AppColors.indigo600,
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon: Icons.play_lesson,
                label: '$_totalLessons Lessons',
                color: AppColors.teal600,
              ),
              const Spacer(),
              if (!_isVersionEditable)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lock, size: 16, color: AppColors.warning),
                      const SizedBox(width: 6),
                      Text(
                        'Version is locked (not editable)',
                        style: TextStyle(color: AppColors.warning, fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Reorderable modules
          if (_modules.isEmpty)
            _EmptyCurriculumState(
              onAddModule: _isVersionEditable
                  ? () {
                      _inlineModuleController.text = 'Module 1';
                      _addModuleInline();
                    }
                  : null,
            )
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: _modules.length,
              onReorder: _reorderModules,
              itemBuilder: (context, index) {
                final module = _modules[index];
                return _ModuleCard(
                  key: ValueKey(module.id),
                  index: index,
                  module: module,
                  lessons: _lessonsByModule[module.id] ?? [],
                  materialTypeByMaterialId: _materialTypeByMaterialId,
                  isEditable: _isVersionEditable,
                  inlineController: _inlineLessonControllers.putIfAbsent(
                    module.id!,
                    () => TextEditingController(),
                  ),
                  onAddLesson: () => _addLessonInline(module),
                );
              },
            ),

          // Add module inline
          if (_isVersionEditable) ...[
            const SizedBox(height: 16),
            _InlineAddField(
              controller: _inlineModuleController,
              hintText: 'Add new section...',
              icon: Icons.create_new_folder,
              onSubmit: _addModuleInline,
            ),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TAB 2: ASSESSMENT
  // ─────────────────────────────────────────────────────────────────────────────

  Widget _buildAssessmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assessment Configuration',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure the course assessment to validate learner competency.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.slate600,
                ),
          ),
          const SizedBox(height: 24),

          if (_assessment == null)
            _EmptyAssessmentState(
              onConfigure: _isVersionEditable ? _createOrUpdateAssessment : null,
            )
          else
            _AssessmentConfigCard(
              assessment: _assessment!,
              questionBanks: _questionBanks,
              onEdit: _isVersionEditable ? _createOrUpdateAssessment : null,
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // TAB 3: SETTINGS
  // ─────────────────────────────────────────────────────────────────────────────

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Settings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
          ),
          const SizedBox(height: 24),

          // Course info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.indigo600),
                      const SizedBox(width: 12),
                      Text(
                        'Course Information',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _InfoRow(label: 'Title', value: _course?.title ?? '-'),
                  _InfoRow(label: 'SOP Number', value: _course?.sopNumber ?? 'Not linked'),
                  _InfoRow(label: 'Description', value: _course?.description ?? 'No description'),
                  _InfoRow(label: 'Organization ID', value: _course?.organizationId.toString() ?? '-'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Version info card
          if (_selectedVersion != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history, color: AppColors.teal600),
                        const SizedBox(width: 12),
                        Text(
                          'Version Information',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _InfoRow(label: 'Version', value: _selectedVersion!.version),
                    _InfoRow(label: 'Status', value: _selectedVersion!.status),
                    if (_selectedVersion!.changeSummary != null &&
                        _selectedVersion!.changeSummary!.isNotEmpty)
                      _InfoRow(label: 'Change Summary', value: _selectedVersion!.changeSummary!),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),

          // All versions table
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.list_alt, color: AppColors.slate600),
                      const SizedBox(width: 12),
                      Text(
                        'Version History',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  ..._versions.map((v) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: v.status == 'effective'
                                    ? AppColors.success
                                    : v.status == 'draft'
                                        ? AppColors.slate400
                                        : AppColors.warning,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'v${v.version}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.slate100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                v.status,
                                style: TextStyle(fontSize: 12, color: AppColors.slate600),
                              ),
                            ),
                            if (v.changeSummary != null && v.changeSummary!.isNotEmpty) ...[
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  v.changeSummary!,
                                  style: TextStyle(color: AppColors.slate500, fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUPPORTING WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    super.key,
    required this.index,
    required this.module,
    required this.lessons,
    required this.materialTypeByMaterialId,
    required this.isEditable,
    required this.inlineController,
    required this.onAddLesson,
  });

  final int index;
  final Module module;
  final List<Lesson> lessons;
  final Map<int, String> materialTypeByMaterialId;
  final bool isEditable;
  final TextEditingController inlineController;
  final VoidCallback onAddLesson;

  IconData _materialIcon(String? type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.videocam;
      case 'scorm':
        return Icons.quiz;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _materialColor(String? type) {
    switch (type) {
      case 'pdf':
        return AppColors.destructive;
      case 'video':
        return AppColors.indigo600;
      case 'scorm':
        return AppColors.teal600;
      default:
        return AppColors.slate500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Module header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.slate100,
            child: Row(
              children: [
                if (isEditable)
                  ReorderableDragStartListener(
                    index: index,
                    child: Icon(Icons.drag_indicator, color: AppColors.slate400),
                  ),
                if (isEditable) const SizedBox(width: 8),
                Icon(Icons.folder, color: AppColors.teal600),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        '${lessons.length} content items',
                        style: TextStyle(color: AppColors.slate500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.teal50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Section ${index + 1}',
                    style: TextStyle(color: AppColors.teal700, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Lessons list
          if (lessons.isNotEmpty)
            ...lessons.asMap().entries.map((entry) {
              final lesson = entry.value;
              final matType = materialTypeByMaterialId[lesson.materialId];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.slate100)),
                ),
                child: Row(
                  children: [
                    if (isEditable)
                      Icon(Icons.drag_indicator, color: AppColors.slate300, size: 20),
                    if (isEditable) const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _materialColor(matType).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(_materialIcon(matType), size: 18, color: _materialColor(matType)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.title,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            matType?.toUpperCase() ?? 'CONTENT',
                            style: TextStyle(color: AppColors.slate500, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    if (lesson.durationMinutes != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${lesson.durationMinutes} min',
                          style: TextStyle(color: AppColors.slate600, fontSize: 11),
                        ),
                      ),
                  ],
                ),
              );
            }),

          // Inline add content
          if (isEditable)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inlineController,
                      decoration: InputDecoration(
                        hintText: 'Add content...',
                        hintStyle: TextStyle(color: AppColors.slate400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.slate200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.slate200),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        filled: true,
                        fillColor: AppColors.slate50,
                        prefixIcon: Icon(Icons.add, color: AppColors.slate400, size: 20),
                      ),
                      onSubmitted: (_) => onAddLesson(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onAddLesson,
                    icon: Icon(Icons.arrow_forward, color: AppColors.teal600),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.teal50,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InlineAddField extends StatelessWidget {
  const _InlineAddField({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200, style: BorderStyle.solid),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.slate400),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppColors.slate400),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          FilledButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.indigo600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCurriculumState extends StatelessWidget {
  const _EmptyCurriculumState({this.onAddModule});

  final VoidCallback? onAddModule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        children: [
          Icon(Icons.folder_open, size: 64, color: AppColors.slate300),
          const SizedBox(height: 16),
          Text(
            'No content yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start building your course by adding sections and content.',
            style: TextStyle(color: AppColors.slate500),
            textAlign: TextAlign.center,
          ),
          if (onAddModule != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAddModule,
              icon: const Icon(Icons.add),
              label: const Text('Add First Section'),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyAssessmentState extends StatelessWidget {
  const _EmptyAssessmentState({this.onConfigure});

  final VoidCallback? onConfigure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        children: [
          Icon(Icons.quiz, size: 64, color: AppColors.slate300),
          const SizedBox(height: 16),
          Text(
            'No assessment configured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add an assessment to validate learner competency.',
            style: TextStyle(color: AppColors.slate500),
            textAlign: TextAlign.center,
          ),
          if (onConfigure != null) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onConfigure,
              icon: const Icon(Icons.add),
              label: const Text('Configure Assessment'),
            ),
          ],
        ],
      ),
    );
  }
}

class _AssessmentConfigCard extends StatelessWidget {
  const _AssessmentConfigCard({
    required this.assessment,
    required this.questionBanks,
    this.onEdit,
  });

  final Assessment assessment;
  final List<QuestionBank> questionBanks;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final bank = questionBanks.where((q) => q.id == assessment.questionBankId).firstOrNull;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.indigo50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.quiz, color: AppColors.indigo600, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Course Assessment',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      Text(
                        bank?.name ?? 'Question Bank #${assessment.questionBankId}',
                        style: TextStyle(color: AppColors.slate600),
                      ),
                    ],
                  ),
                ),
                if (onEdit != null)
                  OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                  ),
              ],
            ),
            const Divider(height: 32),
            Row(
              children: [
                Expanded(
                  child: _AssessmentStatCard(
                    icon: Icons.percent,
                    label: 'Passing Score',
                    value: '${assessment.passingScore}%',
                    color: assessment.passingScore >= 80 ? AppColors.success : AppColors.warning,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _AssessmentStatCard(
                    icon: Icons.shuffle,
                    label: 'Randomize',
                    value: assessment.randomize ? 'Yes' : 'No',
                    color: AppColors.indigo600,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _AssessmentStatCard(
                    icon: Icons.timer,
                    label: 'Time Limit',
                    value: assessment.timeLimitMinutes != null
                        ? '${assessment.timeLimitMinutes} min'
                        : 'None',
                    color: AppColors.teal600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AssessmentStatCard extends StatelessWidget {
  const _AssessmentStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: AppColors.slate600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.slate500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.slate800),
            ),
          ),
        ],
      ),
    );
  }
}

/// TRN-WF-04 Validation Rule model
class _ValidationRule {
  const _ValidationRule({
    required this.title,
    required this.description,
    required this.passed,
    required this.icon,
    this.subtitle,
  });

  final String title;
  final String description;
  final bool passed;
  final IconData icon;
  final String? subtitle;
}

/// TRN-WF-04 Validation Sheet - Odoo-style modal bottom sheet
class _TrnWf04ValidationSheet extends StatelessWidget {
  const _TrnWf04ValidationSheet({
    required this.rules,
    required this.allPass,
    required this.passedCount,
    required this.courseName,
    required this.versionNumber,
  });

  final List<_ValidationRule> rules;
  final bool allPass;
  final int passedCount;
  final String courseName;
  final String versionNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: allPass
                            ? DesignColors.success.withOpacity(0.1)
                            : DesignColors.danger.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        allPass ? Icons.check_circle : Icons.warning_amber_rounded,
                        color: allPass ? DesignColors.success : DesignColors.danger,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Submit to QA Review',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$courseName • Version $versionNumber',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ),
                  ],
                ),
              ),

              // Status banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: allPass
                      ? DesignColors.success.withOpacity(0.05)
                      : DesignColors.warning.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: allPass
                        ? DesignColors.success.withOpacity(0.2)
                        : DesignColors.warning.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      allPass ? Icons.task_alt : Icons.info_outline,
                      color: allPass ? DesignColors.success : DesignColors.warning,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        allPass
                            ? 'All validation checks passed! Ready for QA submission.'
                            : 'Some validation checks failed. Please fix the issues before submitting.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: allPass ? DesignColors.success : DesignColors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'TRN-WF-04 Checklist',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: allPass ? DesignColors.success : DesignColors.danger,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$passedCount / ${rules.length} Passed',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Validation rules list
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: rules.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final rule = rules[index];
                    return _ValidationRuleTile(rule: rule, index: index + 1);
                  },
                ),
              ),

              // Action buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context, false),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back to Edit'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: FilledButton.icon(
                          onPressed: allPass ? () => Navigator.pop(context, true) : null,
                          icon: Icon(allPass ? Icons.send : Icons.block),
                          label: Text(allPass ? 'Confirm Submission' : 'Fix Issues First'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: allPass ? DesignColors.success : null,
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Individual validation rule tile widget
class _ValidationRuleTile extends StatelessWidget {
  const _ValidationRuleTile({
    required this.rule,
    required this.index,
  });

  final _ValidationRule rule;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: rule.passed
            ? DesignColors.success.withOpacity(0.03)
            : DesignColors.danger.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: rule.passed
              ? DesignColors.success.withOpacity(0.2)
              : DesignColors.danger.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rule.passed
                  ? DesignColors.success.withOpacity(0.1)
                  : DesignColors.danger.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              rule.passed ? Icons.check : Icons.close,
              color: rule.passed ? DesignColors.success : DesignColors.danger,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Rule $index',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rule.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rule.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                if (rule.subtitle != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: rule.passed
                          ? DesignColors.success.withOpacity(0.1)
                          : DesignColors.danger.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      rule.subtitle!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: rule.passed ? DesignColors.success : DesignColors.danger,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Rule icon
          Icon(
            rule.icon,
            color: Colors.grey.shade400,
            size: 20,
          ),
        ],
      ),
    );
  }
}
