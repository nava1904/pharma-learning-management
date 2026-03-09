import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:pharma_lms_client/src/protocol/material/material.dart' as protocol;
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Course viewer with modules, lessons, minimum read time, and assessment.
/// Tab-focus pause: timer pauses when tab loses focus (server-enforced min read time).
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

class _CourseViewerScreenState extends State<CourseViewerScreen>
    with WidgetsBindingObserver {
  List<Module> _modules = [];
  List<Lesson> _lessons = [];
  String? _courseTitle;
  bool _loading = true;
  String? _error;
  int _currentLessonIndex = 0;
  int _currentLessonElapsedSeconds = 0;
  Timer? _readTimer;
  bool _timerPaused = false;
  final Set<int> _lessonViewedMaterialIds = {};
  Lesson? _currentLessonWithMaterial;
  String? _materialViewUrl;
  bool _loadingMaterial = false;
  WebViewController? _materialWebController;

  Enrollment? _enrollment;
  bool _acknowledgementChecked = false;
  bool _acknowledging = false;
  String? _acknowledgementError;
  List<SignatureMeaning> _signatureMeanings = [];
  String? _selectedSignatureMeaning;
  final _passwordController = TextEditingController();

  int get _effectiveUserId => widget.userId ?? 0;
  int get _effectiveCourseVersionId => widget.courseVersionId ?? 0;
  bool get _showRetrainingGate =>
      _enrollment?.retrainingChangeSummary != null &&
      _enrollment!.retrainingChangeSummary!.isNotEmpty &&
      _enrollment?.acknowledgedAt == null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _readTimer?.cancel();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _timerPaused = true;
    } else if (state == AppLifecycleState.resumed) {
      _timerPaused = false;
    }
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

      Enrollment? enrollment;
      if (widget.enrollmentId != null) {
        enrollment = await client.training.getEnrollmentById(widget.enrollmentId!);
        if (enrollment != null &&
            enrollment.retrainingChangeSummary != null &&
            enrollment.acknowledgedAt == null) {
          final meanings = await client.training.listSignatureMeanings();
          if (mounted) {
            setState(() {
              _signatureMeanings = meanings;
              _selectedSignatureMeaning = meanings.isNotEmpty
                  ? meanings.first.meaning
                  : 'I have read and understood';
            });
          }
        }
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
        _enrollment = enrollment;
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
      if (_timerPaused) return;
      _currentLessonElapsedSeconds++;
      setState(() {});
      if (_currentLessonElapsedSeconds >= requiredSeconds && _effectiveUserId > 0) {
        _readTimer?.cancel();
        _lessonViewedMaterialIds.add(lesson.materialId);
        try {
          final interactionJson = _currentLessonWithMaterial?.material != null
              ? _buildInteractionJson(_currentLessonWithMaterial!.material!)
              : null;
          await client.material.updateProgress(
            userId: _effectiveUserId,
            materialId: lesson.materialId,
            progressPct: 100,
            completedAt: DateTime.now(),
            timeSpentSeconds: _currentLessonElapsedSeconds,
            readTimeMet: true,
            lessonId: lesson.id,
            enrollmentId: widget.enrollmentId,
            interactionJson: interactionJson,
          );
        } catch (_) {}
        setState(() {});
      }
    });
  }

  String? _buildInteractionJson(protocol.Material material) {
    final type = material.materialType.toLowerCase();
    if (type == 'video') {
      return '{"videoWatchedPct": 100}';
    }
    if (type == 'pdf') {
      return '{"pdfScrollPct": 100}';
    }
    return null;
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

  String? _hashPassword(String password) {
    if (password.isEmpty) return null;
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _performAcknowledgement() async {
    final enrollmentId = widget.enrollmentId;
    final userId = _effectiveUserId;
    if (enrollmentId == null || userId == 0) return;

    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() => _acknowledgementError = 'Password is required for re-authentication.');
      return;
    }

    setState(() {
      _acknowledging = true;
      _acknowledgementError = null;
    });

    try {
      final passwordHash = _hashPassword(password);
      final updated = await client.training.acknowledgeRetraining(
        enrollmentId: enrollmentId,
        userId: userId,
        signatureMeaning: _selectedSignatureMeaning ?? 'I have read and understood',
        passwordReauthHash: passwordHash,
      );
      if (mounted) {
        setState(() {
          _enrollment = updated;
          _acknowledging = false;
          _acknowledgementError = null;
          _passwordController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _acknowledging = false;
          _acknowledgementError = e.toString();
        });
      }
    }
  }

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

    if (_showRetrainingGate) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_courseTitle ?? 'Course'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Retraining Change Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _enrollment!.retrainingChangeSummary!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      CheckboxListTile(
                        value: _acknowledgementChecked,
                        onChanged: (v) =>
                            setState(() => _acknowledgementChecked = v ?? false),
                        title: const Text(
                          'I have read and understood the changes above.',
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (_acknowledgementChecked) ...[
                        const SizedBox(height: 16),
                        if (_signatureMeanings.isNotEmpty)
                          DropdownButtonFormField<String>(
                            value: _selectedSignatureMeaning,
                            decoration: const InputDecoration(
                              labelText: 'Signature meaning',
                            ),
                            items: _signatureMeanings
                                .map((m) => DropdownMenuItem(
                                      value: m.meaning,
                                      child: Text(m.meaning),
                                    ))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedSignatureMeaning = v),
                          ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password (re-authentication)',
                          ),
                        ),
                        if (_acknowledgementError != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            _acknowledgementError!,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _acknowledging
                                ? null
                                : _performAcknowledgement,
                            icon: _acknowledging
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : const Icon(Icons.draw),
                            label: Text(_acknowledging ? 'Signing...' : 'E-Sign'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentLesson = _lessons.isNotEmpty && _currentLessonIndex < _lessons.length
        ? _lessons[_currentLessonIndex]
        : null;

    final progress = _lessons.isEmpty
        ? 0.0
        : _lessonViewedMaterialIds.length / _lessons.length;

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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.slate600,
                          ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.teal600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.slate200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal600),
                  ),
                ),
              ],
            ),
          ),
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
                  onPressed: !_showRetrainingGate &&
                          _allLessonsViewed &&
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
