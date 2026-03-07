import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Course builder: modules, lessons, version history.
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
  bool _loading = true;
  String? _error;

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
      setState(() {
        _courses = courses;
        _loading = false;
      });
      if (widget.courseId != null) {
        _selectedCourse = courses.where((c) => c.id == widget.courseId).firstOrNull;
        if (_selectedCourse != null) await _loadVersions();
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _loadVersions() async {
    if (_selectedCourse?.id == null) return;
    try {
      final versions = await client.course.getCourseVersions(_selectedCourse!.id!);
      // Prefer draft version for editing; approved/effective cannot be edited
      final draftVersion = versions.where((v) => v.status == 'draft').firstOrNull;
      final editableVersion = draftVersion ??
          versions.where((v) => v.status != 'approved' && v.status != 'effective').firstOrNull;
      setState(() {
        _versions = versions;
        _selectedVersion = editableVersion ?? (versions.isNotEmpty ? versions.first : null);
      });
      if (_selectedVersion != null) await _loadModules();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _loadModules() async {
    if (_selectedVersion?.id == null) return;
    try {
      final modules = await client.course.getModulesForCourseVersion(_selectedVersion!.id!);
      setState(() => _modules = modules);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  bool get _isVersionEditable =>
      _selectedVersion != null &&
      _selectedVersion!.status != 'approved' &&
      _selectedVersion!.status != 'effective';

  Future<void> _addModule() async {
    if (_selectedVersion == null) return;
    if (!_isVersionEditable) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cannot edit approved version. Create a new version first.',
            ),
          ),
        );
      }
      return;
    }
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
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _createNewVersion() async {
    if (_selectedCourse?.id == null) return;
    final controller = TextEditingController(text: '${_versions.length + 1}.0');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New Version'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Version (e.g. 2.0)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Create')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await client.courseBuilder.createCourseVersion(
        courseId: _selectedCourse!.id!,
        version: controller.text.trim(),
        status: 'draft',
      );
      if (mounted) _loadVersions();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Builder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 280,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Courses', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._courses.map((c) => ListTile(
                      title: Text(c.title),
                      selected: _selectedCourse?.id == c.id,
                      onTap: () {
                        setState(() => _selectedCourse = c);
                        _loadVersions();
                      },
                    )),
                const SizedBox(height: 24),
                if (_selectedCourse != null) ...[
                  const Text('Versions', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._versions.map((v) => ListTile(
                        title: Text('v${v.version}'),
                        subtitle: Text(v.status),
                        selected: _selectedVersion?.id == v.id,
                        onTap: () {
                          setState(() => _selectedVersion = v);
                          _loadModules();
                        },
                      )),
                  if (_selectedVersion?.status == 'draft')
                    TextButton.icon(
                      onPressed: _submitForQa,
                      icon: const Icon(Icons.send),
                      label: const Text('Submit for QA'),
                    ),
                  TextButton.icon(
                    onPressed: _createNewVersion,
                    icon: const Icon(Icons.add),
                    label: const Text('New version'),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: _selectedVersion == null
                ? const Center(child: Text('Select a course and version'))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Row(
                        children: [
                          Text('Modules (${_selectedCourse?.title})', style: Theme.of(context).textTheme.titleMedium),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: _isVersionEditable ? _addModule : null,
                            icon: const Icon(Icons.add),
                            label: Text(
                              _isVersionEditable
                                  ? 'Add Module'
                                  : 'Add Module (create new version first)',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ..._modules.map((m) => Card(
                            child: ListTile(
                              title: Text(m.title),
                              subtitle: Text('Order: ${m.orderIndex}'),
                            ),
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
