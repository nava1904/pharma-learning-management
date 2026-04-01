import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart'
    show TrainingBatch, BatchParticipantInfo, PharmaUser;
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';
import 'package:pharma_lms_flutter/providers/admin_providers_v2.dart';
import 'package:pharma_lms_flutter/providers/user_provider.dart';
import '../widgets/admin_page_frame.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// BATCH LIST SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchListScreen extends ConsumerStatefulWidget {
  const AdminBatchListScreen({super.key});

  @override
  ConsumerState<AdminBatchListScreen> createState() => _AdminBatchListScreenState();
}

class _AdminBatchListScreenState extends ConsumerState<AdminBatchListScreen> {
  String _statusFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final batchesAsync = ref.watch(adminBatchesProvider);
    final statsAsync = ref.watch(adminBatchStatsProvider);

    return batchesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: PharmaColors.danger),
            SizedBox(height: PharmaSpacing.md),
            Text('Error loading batches', style: PharmaTypography.body),
            SizedBox(height: PharmaSpacing.xs),
            Text(err.toString(), style: PharmaTypography.caption),
            SizedBox(height: PharmaSpacing.md),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(adminBatchesProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (batches) {
        final filteredBatches = _statusFilter == 'all'
            ? batches
            : batches.where((b) => b.status == _statusFilter).toList();

        return SingleChildScrollView(
          padding: EdgeInsets.all(PharmaSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              _buildPageHeader(context),
              SizedBox(height: PharmaSpacing.sectionGap),

              // Stats Row
              statsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (stats) => _buildStatsRow(stats, batches),
              ),
              SizedBox(height: PharmaSpacing.md),

              // Filters
              _buildFiltersRow(),
              SizedBox(height: PharmaSpacing.md),

              // Batches Grid
              _buildBatchesGrid(filteredBatches),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Training Batches', style: PharmaTypography.displayLarge),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              'Manage scheduled cohorts and instructor allocations',
              style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => context.push('/admin/batches/create'),
          icon: const Icon(Icons.add_circle_outline, size: 18),
          label: const Text('Create Batch'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PharmaColors.emerald600,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BatchStats stats, List<TrainingBatch> batches) {
    final totalEnrolled = batches.fold<int>(0, (sum, b) => sum + b.enrolledCount);

    return Row(
      children: [
        _buildStatCard('Total Batches', stats.total.toString(), Icons.groups_outlined, PharmaColors.info),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('In Progress', stats.inProgress.toString(), Icons.play_circle_outline, PharmaColors.success),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Scheduled', stats.scheduled.toString(), Icons.schedule_outlined, PharmaColors.warning),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Completed', stats.completed.toString(), Icons.check_circle_outline, PharmaColors.textTertiary),
        SizedBox(width: PharmaSpacing.md),
        _buildStatCard('Total Enrolled', totalEnrolled.toString(), Icons.people_outline, PharmaColors.emerald600),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(PharmaSpacing.cardPadding),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(PharmaRadius.sm),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: PharmaSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: PharmaTypography.headingSmall),
                Text(label, style: PharmaTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: EdgeInsets.all(PharmaSpacing.cardPadding),
      decoration: BoxDecoration(
        color: PharmaColors.cardBg,
        border: Border.all(color: PharmaColors.borderLight),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
      ),
      child: Row(
        children: [
          Text('Status:', style: PharmaTypography.bodyMedium),
          SizedBox(width: PharmaSpacing.md),
          ...['all', 'in_progress', 'scheduled', 'completed'].map((status) => Padding(
            padding: EdgeInsets.only(right: PharmaSpacing.sm),
            child: ChoiceChip(
              label: Text(_statusLabel(status)),
              selected: _statusFilter == status,
              onSelected: (s) => setState(() => _statusFilter = status),
              selectedColor: PharmaColors.emerald100,
            ),
          )),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'all': return 'All';
      case 'in_progress': return 'In Progress';
      case 'scheduled': return 'Scheduled';
      case 'completed': return 'Completed';
      case 'cancelled': return 'Cancelled';
      default: return status;
    }
  }

  Widget _buildBatchesGrid(List<TrainingBatch> batches) {
    if (batches.isEmpty) {
      return Container(
        padding: EdgeInsets.all(PharmaSpacing.xl),
        decoration: BoxDecoration(
          color: PharmaColors.cardBg,
          border: Border.all(color: PharmaColors.borderLight),
          borderRadius: BorderRadius.circular(PharmaRadius.md),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: PharmaColors.textTertiary),
              SizedBox(height: PharmaSpacing.md),
              Text(
                'No batches found',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
              SizedBox(height: PharmaSpacing.xs),
              Text(
                'Create a new training batch to get started',
                style: PharmaTypography.caption,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: batches.length,
      itemBuilder: (context, index) => _buildBatchCard(batches[index]),
    );
  }

  Widget _buildBatchCard(TrainingBatch batch) {
    final progress = batch.status == 'completed' 
        ? 1.0 
        : batch.enrolledCount > 0 ? (batch.completedCount / batch.enrolledCount) : 0.0;
    
    final courseTitle = batch.courseVersion?.course?.title ?? 'Course';
    final instructorName = batch.instructor != null 
        ? '${batch.instructor!.firstName} ${batch.instructor!.lastName}'
        : 'Not Assigned';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: batch.id == null ? null : () => context.push('/admin/batches/detail?batchId=${batch.id}'),
        borderRadius: BorderRadius.circular(PharmaRadius.md),
        child: Container(
          padding: EdgeInsets.all(PharmaSpacing.cardPadding),
          decoration: BoxDecoration(
            color: PharmaColors.cardBg,
            border: Border.all(color: PharmaColors.borderLight),
            borderRadius: BorderRadius.circular(PharmaRadius.md),
            boxShadow: PharmaShadows.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      batch.name,
                      style: PharmaTypography.headingSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusBadge(batch.status),
                ],
              ),
          SizedBox(height: PharmaSpacing.xs),
          Text(courseTitle, style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary)),
          SizedBox(height: PharmaSpacing.md),
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: PharmaColors.textTertiary),
              SizedBox(width: PharmaSpacing.xs),
              Expanded(
                child: Text(instructorName, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.xs),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: PharmaColors.textTertiary),
              SizedBox(width: PharmaSpacing.xs),
              Text(
                '${_formatDate(batch.startDate)} - ${_formatDate(batch.endDate)}',
                style: PharmaTypography.caption,
              ),
            ],
          ),
          if (batch.location != null && batch.location!.isNotEmpty) ...[
            SizedBox(height: PharmaSpacing.xs),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16, color: PharmaColors.textTertiary),
                SizedBox(width: PharmaSpacing.xs),
                Expanded(
                  child: Text(batch.location!, style: PharmaTypography.caption, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
          const Spacer(),
          // Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${batch.enrolledCount}/${batch.capacity} enrolled',
                style: PharmaTypography.caption,
              ),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: PharmaTypography.caption.copyWith(
                  color: progress >= 0.8 ? PharmaColors.success : PharmaColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: PharmaColors.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.8 ? PharmaColors.success : PharmaColors.emerald500,
              ),
              minHeight: 6,
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'in_progress':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.success;
        break;
      case 'scheduled':
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warning;
        break;
      case 'completed':
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
        break;
      case 'cancelled':
        bgColor = PharmaColors.dangerBg;
        textColor = PharmaColors.danger;
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PharmaRadius.sm),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: PharmaTypography.caption.copyWith(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CREATE BATCH SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchCreateScreen extends ConsumerStatefulWidget {
  const AdminBatchCreateScreen({super.key});

  @override
  ConsumerState<AdminBatchCreateScreen> createState() => _AdminBatchCreateScreenState();
}

class _AdminBatchCreateScreenState extends ConsumerState<AdminBatchCreateScreen> {
  final _name = TextEditingController();
  final _capacity = TextEditingController(text: '20');
  final _location = TextEditingController();
  final _notes = TextEditingController();
  final _meetingUrl = TextEditingController();
  final _description = TextEditingController();
  int? _courseVersionId;
  int? _instructorId;
  List<PharmaUser> _orgUsers = [];
  bool _loadingUsers = true;
  DateTime _start = DateTime.now().add(const Duration(days: 1));
  DateTime _end = DateTime.now().add(const Duration(days: 2));
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  String _medium = 'offline';
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _loadOrgUsers();
  }

  Future<void> _loadOrgUsers() async {
    final me = await ref.read(currentUserProvider.future);
    if (me?.organizationId == null) {
      if (mounted) setState(() => _loadingUsers = false);
      return;
    }
    try {
      final users = await client.organization.listUsers(organizationId: me!.organizationId);
      users.sort((a, b) {
        final an = '${a.firstName} ${a.lastName}'.trim();
        final bn = '${b.firstName} ${b.lastName}'.trim();
        return an.toLowerCase().compareTo(bn.toLowerCase());
      });
      if (mounted) {
        setState(() {
          _orgUsers = users.where((u) => u.status == 'active' && u.id != null).toList();
          _instructorId ??= me.id;
          _loadingUsers = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingUsers = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _capacity.dispose();
    _location.dispose();
    _notes.dispose();
    _meetingUrl.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final cv = _courseVersionId;
    if (cv == null || _name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and course version are required')),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      final me = await ref.read(currentUserProvider.future);
      if (me == null) throw Exception('Not authenticated');
      final cap = int.tryParse(_capacity.text.trim()) ?? 20;
      final instructorId = _instructorId ?? me.id;
      await client.trainingBatch.createBatch(
        organizationId: me.organizationId,
        courseVersionId: cv,
        name: _name.text.trim(),
        instructorId: instructorId,
        startDate: _start,
        endDate: _end,
        capacity: cap,
        location: _location.text.trim().isEmpty ? null : _location.text.trim(),
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        startTime: '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
        endTime: '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
        medium: _medium,
        meetingUrl: _meetingUrl.text.trim().isEmpty ? null : _meetingUrl.text.trim(),
        description: _description.text.trim().isEmpty ? null : _description.text.trim(),
      );
      ref.invalidate(adminBatchesProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Batch created')));
      context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(adminCoursesProvider);

    return AdminPageFrame(
      title: 'Create Batch',
      subtitle: 'Schedule instructor-led cohort training.',
      children: [
        AdminSectionCard(
          title: 'Details',
          child: coursesAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('$e'),
            data: (courses) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Batch name', border: OutlineInputBorder()),
                ),
                SizedBox(height: PharmaSpacing.md),
                if (_loadingUsers)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LinearProgressIndicator(),
                  )
                else
                  DropdownButtonFormField<int>(
                    initialValue: _orgUsers.any((u) => u.id == _instructorId) ? _instructorId : null,
                    decoration: const InputDecoration(
                      labelText: 'Instructor / trainer',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final u in _orgUsers)
                        if (u.id != null)
                          DropdownMenuItem(
                            value: u.id,
                            child: Text(
                              '${u.firstName} ${u.lastName} (${u.email})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                    ],
                    onChanged: (v) => setState(() => _instructorId = v),
                  ),
                SizedBox(height: PharmaSpacing.md),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Course (picks latest version)',
                    border: OutlineInputBorder(),
                  ),
                  items: courses
                      .where((c) => c.id != null)
                      .map((c) => DropdownMenuItem(value: c.id, child: Text(c.title)))
                      .toList(),
                  onChanged: (courseId) async {
                    if (courseId == null) return;
                    final versions = await client.course.getCourseVersions(courseId);
                    if (!mounted) return;
                    setState(() => _courseVersionId = versions.isNotEmpty ? versions.last.id : null);
                  },
                ),
                Text(
                  'Course version ID: ${_courseVersionId ?? "—"}',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                ),
                SizedBox(height: PharmaSpacing.md),
                TextField(
                  controller: _capacity,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Capacity', border: OutlineInputBorder()),
                ),
                SizedBox(height: PharmaSpacing.md),
                TextField(
                  controller: _location,
                  decoration: const InputDecoration(labelText: 'Location (optional)', border: OutlineInputBorder()),
                ),
                SizedBox(height: PharmaSpacing.md),
                TextField(
                  controller: _notes,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Notes (optional)', border: OutlineInputBorder()),
                ),
                SizedBox(height: PharmaSpacing.md),
                TextField(
                  controller: _description,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Detailed description (optional)', border: OutlineInputBorder()),
                ),
                SizedBox(height: PharmaSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _medium,
                  decoration: const InputDecoration(labelText: 'Medium', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'offline', child: Text('Offline (In-Person)')),
                    DropdownMenuItem(value: 'online', child: Text('Online')),
                    DropdownMenuItem(value: 'hybrid', child: Text('Hybrid')),
                  ],
                  onChanged: (v) => setState(() => _medium = v ?? 'offline'),
                ),
                if (_medium != 'offline') ...[
                  SizedBox(height: PharmaSpacing.md),
                  TextField(
                    controller: _meetingUrl,
                    decoration: const InputDecoration(
                      labelText: 'Meeting URL (Zoom, Teams, Meet)',
                      hintText: 'https://zoom.us/j/...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.videocam_outlined),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                ],
                SizedBox(height: PharmaSpacing.md),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                          initialDate: _start,
                        );
                        if (d != null) setState(() => _start = d);
                      },
                      child: Text('Start ${_start.toLocal().toString().split(' ').first}'),
                    ),
                    SizedBox(width: PharmaSpacing.sm),
                    OutlinedButton(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          firstDate: _start,
                          lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                          initialDate: _end,
                        );
                        if (d != null) setState(() => _end = d);
                      },
                      child: Text('End ${_end.toLocal().toString().split(' ').first}'),
                    ),
                  ],
                ),
                SizedBox(height: PharmaSpacing.md),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final t = await showTimePicker(context: context, initialTime: _startTime);
                        if (t != null) setState(() => _startTime = t);
                      },
                      icon: const Icon(Icons.schedule, size: 16),
                      label: Text('Start ${_startTime.format(context)}'),
                    ),
                    SizedBox(width: PharmaSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final t = await showTimePicker(context: context, initialTime: _endTime);
                        if (t != null) setState(() => _endTime = t);
                      },
                      icon: const Icon(Icons.schedule, size: 16),
                      label: Text('End ${_endTime.format(context)}'),
                    ),
                  ],
                ),
                SizedBox(height: PharmaSpacing.md),
                FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Saving…' : 'Create batch')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _batchDetailFormatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

// ═══════════════════════════════════════════════════════════════════════════════
// BATCH DETAIL SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class AdminBatchDetailScreen extends ConsumerStatefulWidget {
  const AdminBatchDetailScreen({super.key});

  @override
  ConsumerState<AdminBatchDetailScreen> createState() => _AdminBatchDetailScreenState();
}

class _AdminBatchDetailScreenState extends ConsumerState<AdminBatchDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TrainingBatch? _batch;
  bool _loading = true;
  bool _enrolling = false;
  bool _savingInstructor = false;
  List<PharmaUser> _instructorChoices = [];
  List<Map<String, dynamic>> _participants = [];
  final _learnerEmailController = TextEditingController();
  final _liveClassTitleController = TextEditingController();
  final _liveClassUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadBatch();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _learnerEmailController.dispose();
    _liveClassTitleController.dispose();
    _liveClassUrlController.dispose();
    super.dispose();
  }

  Future<void> _loadBatch() async {
    final idStr = GoRouterState.of(context).uri.queryParameters['batchId'];
    final batchId = int.tryParse(idStr ?? '') ?? 0;
    if (batchId <= 0) {
      setState(() => _loading = false);
      return;
    }
    try {
      final batch = await client.trainingBatch.getBatch(batchId);
      final me = await ref.read(currentUserProvider.future);
      List<PharmaUser> instructors = [];
      if (me?.organizationId != null) {
        try {
          instructors = await client.organization.listUsers(organizationId: me!.organizationId);
          instructors.sort((a, b) {
            final an = '${a.firstName} ${a.lastName}'.trim();
            final bn = '${b.firstName} ${b.lastName}'.trim();
            return an.toLowerCase().compareTo(bn.toLowerCase());
          });
        } catch (_) {}
      }
      if (batch != null) {
        final roster = await client.trainingBatch.listBatchParticipantsForEmployee(batchId);
        setState(() {
          _batch = batch;
          _instructorChoices = instructors.where((u) => u.status == 'active' && u.id != null).toList();
          _participants = roster.map((p) => {
            'userId': p.userId,
            'name': '${p.firstName} ${p.lastName}',
            'email': p.email,
            'role': p.role ?? 'learner',
          }).toList();
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _enrollLearner() async {
    final email = _learnerEmailController.text.trim();
    if (email.isEmpty || _batch?.id == null) return;
    final me = await ref.read(currentUserProvider.future);
    if (me?.organizationId == null) return;

    setState(() => _enrolling = true);
    try {
      final users = await client.organization.listUsers(organizationId: me!.organizationId);
      PharmaUser? match;
      final lower = email.toLowerCase();
      for (final u in users) {
        if (u.email.toLowerCase() == lower) {
          match = u;
          break;
        }
      }
      if (match?.id == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user with email "$email" in this organization.'),
              backgroundColor: PharmaColors.danger,
            ),
          );
        }
        return;
      }
      final b = _batch!;
      if (b.enrolledCount >= b.capacity) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Batch is at full capacity.'),
              backgroundColor: PharmaColors.warning,
            ),
          );
        }
        return;
      }
      final row = await client.trainingBatch.enrollUserInBatch(
        batchId: b.id!,
        userId: match!.id!,
        role: 'learner',
      );
      if (row == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not add member (permission denied, already enrolled, or invalid batch).',
              ),
              backgroundColor: PharmaColors.danger,
            ),
          );
        }
        return;
      }
      _learnerEmailController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${match.firstName} ${match.lastName} added to the batch.'),
            backgroundColor: PharmaColors.success,
          ),
        );
      }
      await _loadBatch();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _enrolling = false);
    }
  }

  Future<void> _updateInstructor(int? newInstructorId) async {
    if (newInstructorId == null || _batch?.id == null) return;
    setState(() => _savingInstructor = true);
    try {
      final updated = await client.trainingBatch.updateBatch(
        _batch!.id!,
        instructorId: newInstructorId,
      );
      if (updated != null && mounted) {
        setState(() => _batch = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Instructor updated.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: PharmaColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _savingInstructor = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final b = _batch;
    if (b == null) {
      return AdminPageFrame(
        title: 'Batch Detail',
        subtitle: '',
        children: const [
          AdminSectionCard(title: 'Not found', child: Text('Batch does not exist')),
        ],
      );
    }

    final courseTitle = b.courseVersion?.course?.title ?? 'Course';
    final instructorName = b.instructor != null
        ? '${b.instructor!.firstName} ${b.instructor!.lastName}'
        : 'Not Assigned';

    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(PharmaSpacing.pagePadding),
          color: PharmaColors.cardBg,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
              SizedBox(width: PharmaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b.name, style: PharmaTypography.displayLarge),
                    SizedBox(height: PharmaSpacing.xs),
                    Text(
                      '$courseTitle · $instructorName · ${b.medium ?? 'offline'} · '
                      '${_batchDetailFormatDate(b.startDate)} – ${_batchDetailFormatDate(b.endDate)}',
                      style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                    ),
                  ],
                ),
              ),
              _buildStatusBadgeInline(b.status),
            ],
          ),
        ),
        // Tabs
        Container(
          color: PharmaColors.cardBg,
          child: TabBar(
            controller: _tabController,
            labelColor: PharmaColors.emerald600,
            unselectedLabelColor: PharmaColors.textTertiary,
            indicatorColor: PharmaColors.emerald600,
            tabs: const [
              Tab(text: 'Summary'),
              Tab(text: 'Learners'),
              Tab(text: 'Live Classes'),
              Tab(text: 'Announcements'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSummaryTab(b),
              _buildLearnersTab(b),
              _buildLiveClassesTab(b),
              _buildAnnouncementsTab(b),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadgeInline(String status) {
    Color bgColor;
    Color textColor;
    switch (status) {
      case 'in_progress':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.success;
        break;
      case 'scheduled':
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warning;
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(PharmaRadius.sm)),
      child: Text(status.replaceAll('_', ' ').toUpperCase(),
          style: PharmaTypography.caption.copyWith(color: textColor, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildSummaryTab(TrainingBatch b) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminSectionCard(
            title: 'Instructor',
            child: _instructorChoices.isEmpty
                ? Text(
                    'Load users failed or none available. Pull to refresh batch.',
                    style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: _instructorChoices.any((u) => u.id == b.instructorId)
                              ? b.instructorId
                              : null,
                          decoration: const InputDecoration(
                            labelText: 'Assigned instructor',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            for (final u in _instructorChoices)
                              if (u.id != null)
                                DropdownMenuItem(
                                  value: u.id,
                                  child: Text(
                                    '${u.firstName} ${u.lastName} (${u.email})',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                          ],
                          onChanged: _savingInstructor ? null : (v) => _updateInstructor(v),
                        ),
                      ),
                      if (_savingInstructor) ...[
                        SizedBox(width: PharmaSpacing.md),
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ],
                    ],
                  ),
          ),
          SizedBox(height: PharmaSpacing.md),
          AdminSectionCard(
            title: 'Batch Details',
            child: AdminDataTable(
              columns: const ['Field', 'Value'],
              rows: [
                ['Capacity', '${b.capacity}'],
                ['Enrolled', '${b.enrolledCount}'],
                ['Completed', '${b.completedCount}'],
                ['Medium', b.medium ?? 'offline'],
                ['Location', b.location ?? '—'],
                ['Session Time', '${b.startTime ?? '—'} – ${b.endTime ?? '—'}'],
                if (b.meetingUrl != null && b.meetingUrl!.isNotEmpty)
                  ['Meeting URL', b.meetingUrl!],
                ['Course', b.courseVersion?.course?.title ?? '${b.courseVersionId}'],
                ['Description', b.description ?? b.notes ?? '—'],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearnersTab(TrainingBatch b) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _learnerEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Add learner by email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_add_outlined),
                  ),
                ),
              ),
              SizedBox(width: PharmaSpacing.sm),
              FilledButton.icon(
                onPressed: _enrolling ? null : _enrollLearner,
                icon: _enrolling
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add, size: 18),
                label: Text(_enrolling ? 'Adding…' : 'Enroll'),
                style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
              ),
            ],
          ),
          SizedBox(height: PharmaSpacing.md),
          AdminSectionCard(
            title: 'Roster (${_participants.length}/${b.capacity})',
            child: _participants.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(PharmaSpacing.md),
                    child: Text('No learners enrolled yet', style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary)),
                  )
                : AdminDataTable(
                    columns: const ['Name', 'Email', 'Role'],
                    rows: _participants.map((p) => [
                      p['name'] as String,
                      p['email'] as String,
                      p['role'] as String,
                    ]).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveClassesTab(TrainingBatch b) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton.icon(
            onPressed: () => _showCreateLiveClassDialog(b),
            icon: const Icon(Icons.videocam_outlined, size: 18),
            label: const Text('Create Live Class'),
            style: FilledButton.styleFrom(backgroundColor: PharmaColors.emerald600),
          ),
          SizedBox(height: PharmaSpacing.md),
          AdminSectionCard(
            title: 'Scheduled Sessions',
            child: Padding(
              padding: EdgeInsets.all(PharmaSpacing.md),
              child: Text(
                'Live class sessions for this batch will appear here.',
                style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateLiveClassDialog(TrainingBatch b) {
    _liveClassTitleController.clear();
    _liveClassUrlController.text = b.meetingUrl ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Live Class'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _liveClassTitleController,
              decoration: const InputDecoration(labelText: 'Session title', border: OutlineInputBorder()),
            ),
            SizedBox(height: PharmaSpacing.md),
            TextField(
              controller: _liveClassUrlController,
              decoration: const InputDecoration(
                labelText: 'Meeting URL',
                hintText: 'https://zoom.us/j/...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Live class session created')),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsTab(TrainingBatch b) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(PharmaSpacing.pagePadding),
      child: AdminSectionCard(
        title: 'Announcements',
        child: Padding(
          padding: EdgeInsets.all(PharmaSpacing.md),
          child: Text(
            'Post announcements to all batch participants.',
            style: PharmaTypography.body.copyWith(color: PharmaColors.textTertiary),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    switch (status) {
      case 'in_progress':
        bgColor = PharmaColors.successBg;
        textColor = PharmaColors.success;
        break;
      case 'scheduled':
        bgColor = PharmaColors.warningBg;
        textColor = PharmaColors.warning;
        break;
      default:
        bgColor = PharmaColors.gray100;
        textColor = PharmaColors.textTertiary;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: PharmaSpacing.sm, vertical: 2),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(PharmaRadius.sm)),
      child: Text(status.replaceAll('_', ' ').toUpperCase(),
          style: PharmaTypography.caption.copyWith(color: textColor, fontWeight: FontWeight.w600)),
    );
  }
}
