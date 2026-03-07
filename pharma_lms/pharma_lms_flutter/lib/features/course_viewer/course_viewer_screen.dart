import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/client.dart';

/// Course viewer with modules, lessons, minimum read time, and assessment.
class CourseViewerScreen extends StatefulWidget {
  const CourseViewerScreen({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.courseVersionId,
    this.enrollmentId,
    this.userId,
  });

  final String courseId;
  final String? courseTitle;
  final int? courseVersionId;
  final int? enrollmentId;
  final int? userId;

  @override
  State<CourseViewerScreen> createState() => _CourseViewerScreenState();
}

class _CourseViewerScreenState extends State<CourseViewerScreen> {
  List<Module> _modules = [];
  List<Lesson> _lessons = [];
  String? _courseTitle;
  bool _loading = true;
  String? _error;
  int _currentLessonIndex = 0;
  int _currentLessonElapsedSeconds = 0;
  Timer? _readTimer;
  final Set<int> _lessonViewedMaterialIds = {};
  Lesson? _currentLessonWithMaterial;
  String? _materialViewUrl;
  bool _loadingMaterial = false;
  WebViewController? _materialWebController;

  int get _effectiveUserId => widget.userId ?? 0;
  int get _effectiveCourseVersionId => widget.courseVersionId ?? 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _readTimer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final courseVersionId = _effectiveCourseVersionId;
      if (courseVersionId == 0) {
        setState(() {
          _error = 'Missing course version. Go back and open from dashboard.';
          _loading = false;
        });
        return;
      }

      final version = await client.course.getCourseVersion(courseVersionId);
      _courseTitle = version?.course?.title ?? widget.courseTitle ?? 'Course';

      final modules = await client.course.getModulesForCourseVersion(courseVersionId);
      final allLessons = <Lesson>[];
      for (final m in modules) {
        if (m.id != null) {
          final lessons = await client.course.getLessonsForModule(m.id!);
          allLessons.addAll(lessons);
        }
      }
      allLessons.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      if (_effectiveUserId > 0) {
        for (final l in allLessons) {
          final p = await client.material.getProgress(
            userId: _effectiveUserId,
            materialId: l.materialId,
          );
          if (p != null && (p.progressPct >= 100 || p.completedAt != null)) {
            _lessonViewedMaterialIds.add(l.materialId);
          }
        }
      }

      setState(() {
        _modules = modules;
        _lessons = allLessons;
        _loading = false;
      });
      if (allLessons.isNotEmpty && mounted) {
        _loadLessonMaterial(allLessons[0]);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _startReadTimer(Lesson lesson) {
    _readTimer?.cancel();
    final durationMinutes = lesson.durationMinutes ?? 1;
    final requiredSeconds = durationMinutes * 60;
    if (_lessonViewedMaterialIds.contains(lesson.materialId)) return;

    _readTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      _currentLessonElapsedSeconds++;
      setState(() {});
      if (_currentLessonElapsedSeconds >= requiredSeconds && _effectiveUserId > 0) {
        _readTimer?.cancel();
        _lessonViewedMaterialIds.add(lesson.materialId);
        try {
          await client.material.updateProgress(
            userId: _effectiveUserId,
            materialId: lesson.materialId,
            progressPct: 100,
            completedAt: DateTime.now(),
          );
        } catch (_) {}
        setState(() {});
      }
    });
  }

  void _stopReadTimer() {
    _readTimer?.cancel();
    _currentLessonElapsedSeconds = 0;
  }

  bool get _allLessonsViewed {
    if (_lessons.isEmpty) return false;
    for (final l in _lessons) {
      if (!_lessonViewedMaterialIds.contains(l.materialId)) return false;
    }
    return true;
  }

  int _remainingSeconds(Lesson lesson) {
    final durationMinutes = lesson.durationMinutes ?? 1;
    final required = durationMinutes * 60;
    if (_lessonViewedMaterialIds.contains(lesson.materialId)) return 0;
    final remaining = required - _currentLessonElapsedSeconds;
    return remaining > 0 ? remaining : 0;
  }

  bool _canProceed(Lesson lesson) =>
      _lessonViewedMaterialIds.contains(lesson.materialId);

  Future<void> _loadLessonMaterial(Lesson lesson) async {
    if (lesson.id == null) return;
    setState(() {
      _currentLessonWithMaterial = null;
      _materialViewUrl = null;
      _materialWebController = null;
      _loadingMaterial = true;
    });
    try {
      final lessonWithMaterial =
          await client.course.getLessonWithMaterial(lesson.id!);
      String? viewUrl;
      final material = lessonWithMaterial?.material;
      if (material?.storageKey != null) {
        viewUrl = await client.material.getMaterialViewUrl(material!.storageKey!);
      }
      if (mounted) {
        WebViewController? controller;
        if (viewUrl != null) {
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(viewUrl));
        }
        setState(() {
          _currentLessonWithMaterial = lessonWithMaterial;
          _materialViewUrl = viewUrl;
          _materialWebController = controller;
          _loadingMaterial = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loadingMaterial = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(_courseTitle ?? widget.courseTitle ?? 'Course')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final currentLesson = _lessons.isNotEmpty && _currentLessonIndex < _lessons.length
        ? _lessons[_currentLessonIndex]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_courseTitle ?? 'Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_modules.isNotEmpty)
                    ..._modules.map((m) => Card(
                          child: ExpansionTile(
                            title: Text(m.title),
                            children: _lessons
                                .where((l) => l.moduleId == m.id)
                                .map((l) => ListTile(
                                      title: Text(l.title),
                                      trailing: _lessonViewedMaterialIds
                                              .contains(l.materialId)
                                          ? const Icon(Icons.check_circle,
                                              color: Colors.green)
                                          : null,
                                    ))
                                .toList(),
                          ),
                        )),
                  const SizedBox(height: 16),
                  if (currentLesson != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentLesson.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            if (_loadingMaterial)
                              const SizedBox(
                                height: 200,
                                child: Center(
                                    child: CircularProgressIndicator()),
                              )
                            else if (_materialViewUrl != null &&
                                _materialWebController != null &&
                                _currentLessonWithMaterial?.material != null)
                              SizedBox(
                                height: 400,
                                child: WebViewWidget(
                                  controller: _materialWebController!,
                                ),
                              )
                            else if (_currentLessonWithMaterial?.material !=
                                null)
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentLessonWithMaterial!
                                        .material!.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Type: ${_currentLessonWithMaterial!.material!.materialType}. '
                                    'Minimum read time applies.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              )
                            else
                              const Text(
                                'No material content. '
                                'Minimum read time applies.',
                              ),
                            const SizedBox(height: 16),
                            Builder(
                              builder: (context) {
                                final remaining = _remainingSeconds(currentLesson);
                                final canProceed = _canProceed(currentLesson);
                                if (canProceed) {
                                  return const Text('✓ Ready to proceed');
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Read for ${remaining}s more',
                                      style: TextStyle(
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _startReadTimer(currentLesson),
                                      child: const Text('Start reading timer'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (_lessons.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No lessons in this course.'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_lessons.isNotEmpty)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _currentLessonIndex > 0
                            ? () {
                                _stopReadTimer();
                                final nextIndex = _currentLessonIndex - 1;
                                _loadLessonMaterial(_lessons[nextIndex]);
                                setState(() => _currentLessonIndex = nextIndex);
                              }
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                    ),
                  if (_lessons.isNotEmpty) const SizedBox(width: 16),
                  if (_lessons.isNotEmpty)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _currentLessonIndex < _lessons.length - 1
                            ? (_canProceed(currentLesson!)
                                ? () {
                                    _stopReadTimer();
                                    final nextIndex = _currentLessonIndex + 1;
                                    _loadLessonMaterial(_lessons[nextIndex]);
                                    setState(() => _currentLessonIndex =
                                        nextIndex);
                                  }
                                : null)
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _allLessonsViewed &&
                          widget.enrollmentId != null &&
                          _effectiveCourseVersionId > 0
                      ? () {
                          context.push(
                            '/assessment/${widget.courseId}',
                            extra: {
                              'courseVersionId': _effectiveCourseVersionId,
                              'enrollmentId': widget.enrollmentId,
                              'userId': _effectiveUserId,
                            },
                          );
                        }
                      : null,
                  child: const Text('Take Assessment'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
