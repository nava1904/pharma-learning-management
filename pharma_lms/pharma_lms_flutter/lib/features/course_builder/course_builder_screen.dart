import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as protocol;

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/course_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/section_header.dart';

/// Course builder - Odoo-inspired: card grid, editor with module tree.
class CourseBuilderScreen extends StatefulWidget {
  const CourseBuilderScreen({
    super.key,
    this.courseId,
  });

  final int? courseId;

  @override
  State<CourseBuilderScreen> createState() => _CourseBuilderScreenState();
}

class _CourseBuilderScreenState extends State<CourseBuilderScreen> {
  List<Course> _courses = [];
  Course? _selectedCourse;
  List<CourseVersion> _versions = [];
  CourseVersion? _selectedVersion;
  List<Module> _modules = [];
  Map<int, List<Lesson>> _lessonsByModule = {};
  Module? _selectedModule;
  Lesson? _selectedLesson;
  String _searchQuery = '';
  bool _loading = true;
  String? _error;
  bool _showGrid = true;
  Map<int, String> _materialTypeByMaterialId = {};

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
      final courses = await client.course.listCourses();
      if (mounted) {
        setState(() {
          _courses = courses;
          _loading = false;
        });
        if (widget.courseId != null) {
          final c = courses.where((x) => x.id == widget.courseId).firstOrNull;
          if (c != null) {
            setState(() => _selectedCourse = c);
            _showGrid = false;
            await _loadVersions();
          }
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

  Future<void> _loadVersions() async {
    if (_selectedCourse?.id == null) return;
    try {
      final versions = await client.course.getCourseVersions(_selectedCourse!.id!);
      final draft = versions.where((v) => v.status == 'draft').firstOrNull;
      final editable = draft ??
          versions.where((v) => v.status != 'approved' && v.status != 'effective').firstOrNull;
      setState(() {
        _versions = versions;
        _selectedVersion = editable ?? (versions.isNotEmpty ? versions.first : null);
      });
      if (_selectedVersion != null) await _loadModules();
      await _loadMaterialsMap();
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _loadMaterialsMap() async {
    final orgId = _selectedCourse?.organizationId;
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

  Future<void> _loadModules() async {
    if (_selectedVersion?.id == null) return;
    try {
      final modules = await client.course.getModulesForCourseVersion(_selectedVersion!.id!);
      setState(() {
        _modules = modules;
        _lessonsByModule = {};
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _loadLessonsForModule(int moduleId) async {
    if (_lessonsByModule.containsKey(moduleId)) return;
    try {
      final lessons = await client.course.getLessonsForModule(moduleId);
      if (mounted) {
        setState(() => _lessonsByModule[moduleId] = lessons);
      }
    } catch (e) {
      if (mounted) setState(() => _lessonsByModule[moduleId] = []);
    }
  }

  bool get _isVersionEditable =>
      _selectedVersion != null &&
      _selectedVersion!.status != 'approved' &&
      _selectedVersion!.status != 'effective';

  List<Course> get _filteredCourses {
    if (_searchQuery.trim().isEmpty) return _courses;
    final q = _searchQuery.toLowerCase();
    return _courses.where((c) => c.title.toLowerCase().contains(q)).toList();
  }

  Future<void> _addModule() async {
    if (_selectedVersion == null || !_isVersionEditable) return;
    final controller = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Module'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Module title',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await client.courseBuilder.createModule(
        courseVersionId: _selectedVersion!.id!,
        title: controller.text.trim().isEmpty ? 'New Module' : controller.text.trim(),
        orderIndex: _modules.length,
      );
      if (mounted) _loadModules();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _addLesson(Module module) async {
    if (!_isVersionEditable) return;
    final orgId = _selectedCourse?.organizationId;
    if (orgId == null) return;
    List<protocol.Material> materials = [];
    try {
      materials = await client.material.listMaterials(organizationId: orgId);
    } catch (_) {}
    if (materials.isEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload materials first in Trainer > Materials')),
      );
      return;
    }
    final titleController = TextEditingController();
    protocol.Material? selectedMaterial = materials.isNotEmpty ? materials.first : null;
    final lessons = _lessonsByModule[module.id] ?? [];
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: const Text('Add Lesson'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Lesson title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<protocol.Material>(
                    value: selectedMaterial,
                    decoration: const InputDecoration(
                      labelText: 'Material',
                      border: OutlineInputBorder(),
                    ),
                    items: materials
                        .map((m) => DropdownMenuItem<protocol.Material>(
                              value: m,
                              child: Text(m.title ?? 'Material ${m.id}'),
                            ))
                        .toList(),
                    onChanged: (m) => setState(() => selectedMaterial = m),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration is optional (min read time)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty || selectedMaterial?.id == null) return;
                  Navigator.pop(ctx, {
                    'title': titleController.text.trim(),
                    'materialId': selectedMaterial!.id!,
                    'orderIndex': lessons.length,
                  });
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
    if (result == null || !mounted) return;
    try {
      await client.courseBuilder.createLesson(
        moduleId: module.id!,
        title: result['title'] as String,
        materialId: result['materialId'] as int,
        orderIndex: result['orderIndex'] as int,
      );
      if (mounted) {
        _loadLessonsForModule(module.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lesson added')),
        );
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _submitForQa() async {
    if (_selectedVersion?.id == null) return;
    try {
      await client.courseBuilder.updateCourseVersionStatus(
        courseVersionId: _selectedVersion!.id!,
        status: 'pending_approval',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submitted for QA approval')),
        );
        _loadVersions();
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }

  Future<void> _createCourse() async {
    List<Organization> orgs = [];
    try {
      orgs = await client.organization.listOrganizations();
    } catch (_) {}
    if (!mounted) return;
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => _CreateCourseWizard(
        organizations: orgs,
        onCreated: (data) => Navigator.pop(ctx, data),
        onCancel: () => Navigator.pop(ctx),
      ),
    );

    if (result == null || !mounted) return;
    try {
      final course = await client.course.createCourse(
        title: result['title'] as String,
        organizationId: result['orgId'] as int,
        sopNumber: (result['sop'] as String).isEmpty ? null : result['sop'] as String,
        description: (result['desc'] as String).isEmpty ? null : result['desc'] as String,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course created')),
        );
        _load();
        if (course.id != null) {
          setState(() {
            _selectedCourse = course;
            _showGrid = false;
          });
          _loadVersions();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _createNewVersion() async {
    if (_selectedCourse?.id == null) return;
    final versionController = TextEditingController(text: '${_versions.length + 1}.0');
    final changeSummaryController = TextEditingController();
    final hasEffective = _versions.any((v) => v.status == 'effective');
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New Version'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: versionController,
                decoration: const InputDecoration(
                  labelText: 'Version (e.g. 2.0)',
                  border: OutlineInputBorder(),
                ),
              ),
              if (hasEffective) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: changeSummaryController,
                  decoration: const InputDecoration(
                    labelText: 'Change summary (required when superseding)',
                    hintText: 'Describe changes from previous version',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final version = versionController.text.trim();
              final changeSummary = changeSummaryController.text.trim();
              if (hasEffective && changeSummary.isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Change summary is required when superseding an effective version'),
                  ),
                );
                return;
              }
              Navigator.pop(ctx, {'version': version, 'changeSummary': changeSummary});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (result == null || !mounted) return;
    try {
      await client.courseBuilder.createCourseVersion(
        courseId: _selectedCourse!.id!,
        version: result['version']!,
        status: 'draft',
        changeSummary: result['changeSummary']!.isEmpty ? null : result['changeSummary'],
      );
      if (mounted) _loadVersions();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  void _selectCourse(Course c) {
    setState(() {
      _selectedCourse = c;
      _showGrid = false;
      _selectedModule = null;
      _selectedLesson = null;
    });
    _loadVersions();
  }

  void _backToGrid() {
    setState(() {
      _showGrid = true;
      _selectedCourse = null;
      _selectedVersion = null;
      _modules = [];
      _lessonsByModule = {};
      _selectedModule = null;
      _selectedLesson = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Course Builder'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Builder')),
        body: EmptyState(
          message: _error!,
          icon: Icons.error_outline,
          action: FilledButton(
            onPressed: _load,
            child: const Text('Retry'),
          ),
        ),
      );
    }

    if (_showGrid) {
      return _buildCourseGrid();
    }
    return _buildCourseEditor();
  }

  Widget _buildCourseGrid() {
    final filtered = _filteredCourses;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Builder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              icon: Icons.menu_book,
              title: 'My Courses',
              color: AppColors.indigo600,
              action: TextButton.icon(
                onPressed: _createCourse,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create Course'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 900
                    ? 4
                    : (constraints.maxWidth > 600 ? 3 : (constraints.maxWidth > 400 ? 2 : 1));
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: [
                    CourseCard(
                      isCreateCard: true,
                      title: 'Create Course',
                      onTap: _createCourse,
                    ),
                    ...filtered.map((c) => CourseCard(
                          title: c.title,
                          versionCount: _selectedCourse?.id == c.id ? _versions.length : null,
                          status: c.status,
                          onTap: () => _selectCourse(c),
                          ctaLabel: 'Edit',
                        )),
                  ],
                );
              },
            ),
            if (filtered.isEmpty && _searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'No courses match "$_searchQuery"',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseEditor() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedCourse?.title ?? 'Course Builder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backToGrid,
        ),
        actions: [
          if (_selectedVersion?.status == 'draft')
            TextButton.icon(
              onPressed: _submitForQa,
              icon: const Icon(Icons.send, size: 18),
              label: const Text('Submit for QA'),
            ),
          TextButton.icon(
            onPressed: _createNewVersion,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('New Version'),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  right: BorderSide(color: AppColors.slate200),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Breadcrumb(
                    items: [
                      _selectedCourse?.title ?? 'Course',
                      _selectedVersion != null ? 'v${_selectedVersion!.version}' : '',
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionHeader(
                    icon: Icons.folder_open,
                    title: 'Modules',
                    color: AppColors.teal600,
                    action: _isVersionEditable
                        ? IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _addModule,
                            tooltip: 'Add Module',
                          )
                        : null,
                  ),
                  ..._modules.map((m) => _ModuleTile(
                        module: m,
                        lessons: _lessonsByModule[m.id] ?? [],
                        materialTypeByMaterialId: _materialTypeByMaterialId,
                        isExpanded: _selectedModule?.id == m.id,
                        isSelected: _selectedModule?.id == m.id,
                        onTap: () {
                          setState(() {
                            _selectedModule = m;
                            _selectedLesson = null;
                          });
                          _loadLessonsForModule(m.id!);
                        },
                        onAddLesson: () => _addLesson(m),
                        canEdit: _isVersionEditable,
                        onLessonTap: (lesson) {
                          setState(() => _selectedLesson = lesson);
                        },
                        selectedLessonId: _selectedLesson?.id,
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: _selectedModule == null
                ? EmptyState(
                    icon: Icons.folder_open,
                    headline: 'Select a module',
                    subtext: 'Choose a module from the left to view or edit its content.',
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedModule!.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate900,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_lessonsByModule[_selectedModule!.id] ?? []).length} lesson(s)',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.slate600,
                              ),
                        ),
                        const SizedBox(height: 24),
                        if (_isVersionEditable)
                          FilledButton.icon(
                            onPressed: () => _addLesson(_selectedModule!),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Lesson'),
                          ),
                        const SizedBox(height: 24),
                        if (_selectedLesson != null) ...[
                          Text(
                            _selectedLesson!.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (_selectedLesson!.durationMinutes != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Chip(
                                label: Text(
                                  '${_selectedLesson!.durationMinutes} min',
                                ),
                                backgroundColor: AppColors.teal50,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Odoo-inspired stepped wizard for creating a new course.
class _CreateCourseWizard extends StatefulWidget {
  const _CreateCourseWizard({
    required this.organizations,
    required this.onCreated,
    required this.onCancel,
  });

  final List<Organization> organizations;
  final void Function(Map<String, dynamic> data) onCreated;
  final VoidCallback onCancel;

  @override
  State<_CreateCourseWizard> createState() => _CreateCourseWizardState();
}

class _CreateCourseWizardState extends State<_CreateCourseWizard> {
  int _step = 0;
  final _titleController = TextEditingController();
  final _sopController = TextEditingController();
  final _descController = TextEditingController();
  Organization? _selectedOrg;

  @override
  void initState() {
    super.initState();
    if (widget.organizations.isNotEmpty && _selectedOrg == null) {
      _selectedOrg = widget.organizations.first;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sopController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step == 0 && _titleController.text.trim().isEmpty) return;
    if (_step == 1 && _selectedOrg?.id == null) return;
    if (_step < 2) {
      setState(() => _step++);
    } else {
      widget.onCreated({
        'title': _titleController.text.trim(),
        'orgId': _selectedOrg!.id,
        'sop': _sopController.text.trim(),
        'desc': _descController.text.trim(),
      });
    }
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      widget.onCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = ['Title', 'Organization', 'SOP & Description'];
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline, size: 28, color: AppColors.indigo600),
                const SizedBox(width: 12),
                Text(
                  'Create Course',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate900,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: steps.asMap().entries.map((e) {
                final isActive = e.key == _step;
                final isPast = e.key < _step;
                return Expanded(
                  child: Row(
                    children: [
                      if (e.key > 0)
                        Expanded(
                          child: Divider(
                            color: isPast ? AppColors.teal500 : AppColors.slate200,
                            thickness: 2,
                          ),
                        ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.indigo50
                                : (isPast ? AppColors.teal50 : AppColors.slate100),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isActive
                                  ? AppColors.indigo600
                                  : (isPast ? AppColors.teal600 : AppColors.slate300),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                    color: isActive
                                        ? AppColors.indigo700
                                        : (isPast ? AppColors.teal700 : AppColors.slate600),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      if (e.key < steps.length - 1)
                        Expanded(
                          child: Divider(
                            color: isPast ? AppColors.teal500 : AppColors.slate200,
                            thickness: 2,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildStepContent(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _back,
                  child: Text(_step == 0 ? 'Cancel' : 'Back'),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    if (_step == 0 && _titleController.text.trim().isEmpty) return;
                    if (_step == 1 && _selectedOrg?.id == null) return;
                    _next();
                  },
                  child: Text(_step == 2 ? 'Create Course' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Course title',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'e.g. GMP Fundamentals',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.slate50,
              ),
              autofocus: true,
              onChanged: (_) => setState(() {}),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Organization',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Organization>(
              value: _selectedOrg ?? (widget.organizations.isNotEmpty ? widget.organizations.first : null),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.slate50,
              ),
              items: widget.organizations
                  .map((o) => DropdownMenuItem(
                        value: o,
                        child: Text(o.name),
                      ))
                  .toList(),
              onChanged: (o) => setState(() => _selectedOrg = o),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'SOP Number (optional)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _sopController,
              decoration: InputDecoration(
                hintText: 'e.g. SOP-001',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.slate50,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Description (optional)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate800,
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Brief course description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.slate50,
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final valid = items.where((x) => x.isNotEmpty).toList();
    if (valid.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < valid.length; i++) ...[
          if (i > 0)
            Icon(Icons.chevron_right, size: 18, color: AppColors.slate400),
          Text(
            valid[i],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: i < valid.length - 1 ? AppColors.slate600 : AppColors.slate900,
                  fontWeight: i == valid.length - 1 ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
        ],
      ],
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.module,
    required this.lessons,
    required this.materialTypeByMaterialId,
    required this.isExpanded,
    required this.isSelected,
    required this.onTap,
    required this.onAddLesson,
    required this.canEdit,
    required this.onLessonTap,
    this.selectedLessonId,
  });

  final Module module;
  final List<Lesson> lessons;
  final Map<int, String> materialTypeByMaterialId;
  final bool isExpanded;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onAddLesson;
  final bool canEdit;
  final void Function(Lesson) onLessonTap;
  final int? selectedLessonId;

  IconData _materialIcon(String? type) {
    if (type == null) return Icons.play_circle_outline;
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'video':
        return Icons.videocam_outlined;
      case 'scorm':
        return Icons.quiz_outlined;
      default:
        return Icons.play_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.indigo50 : null,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(color: AppColors.indigo200)
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.folder_open : Icons.folder,
                  size: 20,
                  color: AppColors.teal600,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    module.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: AppColors.slate800,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${lessons.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.slate500,
                      ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          ...lessons.map((l) {
                final matType = materialTypeByMaterialId[l.materialId];
                return Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4),
                  child: InkWell(
                    onTap: () => onLessonTap(l),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: selectedLessonId == l.id ? AppColors.slate100 : null,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _materialIcon(matType),
                            size: 18,
                            color: matType == 'pdf'
                                ? AppColors.destructive
                                : matType == 'video'
                                    ? AppColors.indigo600
                                    : AppColors.slate500,
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l.title,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate700,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (l.durationMinutes != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.teal50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${l.durationMinutes}m',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.teal700,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          if (canEdit)
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 4),
              child: TextButton.icon(
                onPressed: onAddLesson,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add lesson'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.teal600,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
