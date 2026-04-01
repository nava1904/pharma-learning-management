// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE TRAINING CALENDAR SCREEN
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/calendar
// Calendar view of training deadlines, batch sessions, certificate expiry.
// All data from real providers — no hardcoded events.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../design_system/tokens.dart';
import '../../../design_system/components.dart';
import '../../../providers/employee_portal_providers.dart';

class EmployeeTrainingCalendarScreen extends ConsumerStatefulWidget {
  const EmployeeTrainingCalendarScreen({super.key});

  @override
  ConsumerState<EmployeeTrainingCalendarScreen> createState() =>
      _EmployeeTrainingCalendarScreenState();
}

class _EmployeeTrainingCalendarScreenState
    extends ConsumerState<EmployeeTrainingCalendarScreen> {
  late DateTime _selectedMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(employeeCalendarEventsProvider);

    return eventsAsync.when(
      loading: () => SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(height: 36, width: 280),
            const SizedBox(height: AppSpacing.s6),
            SkeletonLoader(height: 350, borderRadius: AppRadius.br3),
          ],
        ),
      ),
      error: (e, _) => AppErrorWidget(
        title: 'Unable to Load Calendar',
        message: e.toString(),
        onRetry: () => ref.invalidate(employeeCalendarEventsProvider),
      ),
      data: (events) => _CalendarContent(
        events: events,
        selectedMonth: _selectedMonth,
        selectedDate: _selectedDate,
        onMonthChanged: (m) => setState(() => _selectedMonth = m),
        onDateSelected: (d) => setState(() => _selectedDate = d),
      ),
    );
  }
}

class _CalendarContent extends StatelessWidget {
  const _CalendarContent({
    required this.events,
    required this.selectedMonth,
    this.selectedDate,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  final List<CalendarEvent> events;
  final DateTime selectedMonth;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    // Events for selected date
    final dayEvents = selectedDate != null
        ? events.where((e) =>
            e.date.year == selectedDate!.year &&
            e.date.month == selectedDate!.month &&
            e.date.day == selectedDate!.day).toList()
        : <CalendarEvent>[];

    // Upcoming events (next 30 days)
    final now = DateTime.now();
    final upcoming = events
        .where((e) => e.date.isAfter(now) && e.date.isBefore(now.add(const Duration(days: 30))))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Training Calendar', style: AppTypography.display.copyWith(
            fontSize: 32, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'View training deadlines, batch sessions, and requalification dates',
            style: AppTypography.body.copyWith(color: AppColors.n500),
          ),
          const SizedBox(height: AppSpacing.s7),

          // ─── Calendar Grid ───
          Container(
            padding: const EdgeInsets.all(AppSpacing.s5),
            decoration: BoxDecoration(
              color: AppColors.n0,
              borderRadius: AppRadius.br3,
              boxShadow: AppShadows.sh1,
            ),
            child: Column(
              children: [
                // Month navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => onMonthChanged(
                        DateTime(selectedMonth.year, selectedMonth.month - 1),
                      ),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(selectedMonth),
                      style: AppTypography.headline.copyWith(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () => onMonthChanged(
                        DateTime(selectedMonth.year, selectedMonth.month + 1),
                      ),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s4),

                // Day headers
                Row(
                  children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      .map((d) => Expanded(
                            child: Center(
                              child: Text(d,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.n400,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.s3),

                // Calendar grid
                _buildCalendarGrid(events),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s6),

          // ─── Selected Day Events ───
          if (selectedDate != null) ...[
            Text(
              'Events on ${DateFormat('EEEE, MMMM d').format(selectedDate!)}',
              style: AppTypography.headline.copyWith(fontSize: 18),
            ),
            const SizedBox(height: AppSpacing.s4),
            if (dayEvents.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s4),
                child: Text('No events on this date.',
                    style: AppTypography.body.copyWith(color: AppColors.n400)),
              )
            else
              ...dayEvents.map((e) => _EventCard(event: e)),
            const SizedBox(height: AppSpacing.s6),
          ],

          // ─── Upcoming Events ───
          Text('Upcoming (Next 30 Days)', style: AppTypography.headline.copyWith(fontSize: 18)),
          const SizedBox(height: AppSpacing.s4),
          if (upcoming.isEmpty)
            AppEmptyState(
              icon: Icons.event_available,
              title: 'No Upcoming Events',
              description: 'You have no training deadlines or sessions in the next 30 days.',
            )
          else
            ...upcoming.map((e) => _EventCard(event: e)),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(List<CalendarEvent> events) {
    final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final lastDay = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    final startWeekday = firstDay.weekday; // 1 = Monday
    final totalDays = lastDay.day;
    final today = DateTime.now();

    // Build event lookup by day
    final eventsByDay = <int, List<CalendarEvent>>{};
    for (final e in events) {
      if (e.date.year == selectedMonth.year && e.date.month == selectedMonth.month) {
        eventsByDay.putIfAbsent(e.date.day, () => []).add(e);
      }
    }

    final cells = <Widget>[];
    // Empty cells before first day
    for (var i = 1; i < startWeekday; i++) {
      cells.add(const SizedBox());
    }
    // Day cells
    for (var day = 1; day <= totalDays; day++) {
      final isToday = today.year == selectedMonth.year &&
          today.month == selectedMonth.month &&
          today.day == day;
      final isSelected = selectedDate != null &&
          selectedDate!.year == selectedMonth.year &&
          selectedDate!.month == selectedMonth.month &&
          selectedDate!.day == day;
      final dayEvents = eventsByDay[day] ?? [];
      final hasEvents = dayEvents.isNotEmpty;
      final hasDueDate = dayEvents.any((e) => e.type == 'due_date');
      final hasExpiry = dayEvents.any((e) => e.type == 'cert_expiry');

      cells.add(GestureDetector(
        onTap: () => onDateSelected(DateTime(selectedMonth.year, selectedMonth.month, day)),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.blue
                : isToday
                    ? AppColors.blueLight
                    : null,
            borderRadius: AppRadius.br1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$day',
                style: AppTypography.body.copyWith(
                  color: isSelected ? AppColors.n0 : isToday ? AppColors.blue : AppColors.n700,
                  fontWeight: isToday || isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              if (hasEvents)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasDueDate)
                      Container(
                        width: 5, height: 5,
                        margin: const EdgeInsets.only(top: 2, right: 1),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.n0 : AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (hasExpiry)
                      Container(
                        width: 5, height: 5,
                        margin: const EdgeInsets.only(top: 2, left: 1),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.n0 : AppColors.warning,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ));
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.2,
      children: cells,
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});
  final CalendarEvent event;

  Color get _color {
    switch (event.type) {
      case 'due_date':
        return AppColors.danger;
      case 'cert_expiry':
        return AppColors.warning;
      case 'batch_session':
        return AppColors.teal;
      default:
        return AppColors.blue;
    }
  }

  IconData get _icon {
    switch (event.type) {
      case 'due_date':
        return Icons.assignment_late_outlined;
      case 'cert_expiry':
        return Icons.timer_outlined;
      case 'batch_session':
        return Icons.groups_outlined;
      default:
        return Icons.event_outlined;
    }
  }

  String get _typeLabel {
    switch (event.type) {
      case 'due_date':
        return 'Training Deadline';
      case 'cert_expiry':
        return 'Certificate Expiry';
      case 'batch_session':
        return 'Batch Session';
      default:
        return 'Event';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Material(
        color: AppColors.n0,
        borderRadius: AppRadius.br2,
        child: InkWell(
          borderRadius: AppRadius.br2,
          onTap: event.route != null ? () => context.go(event.route!) : null,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.s4),
            decoration: BoxDecoration(
              borderRadius: AppRadius.br2,
              border: Border(left: BorderSide(color: _color, width: 4)),
              boxShadow: AppShadows.sh1,
            ),
            child: Row(
              children: [
                Icon(_icon, color: _color, size: 20),
                const SizedBox(width: AppSpacing.s4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: AppTypography.title.copyWith(fontSize: 15)),
                      const SizedBox(height: AppSpacing.s1),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: 2),
                            decoration: BoxDecoration(
                              color: _color.withValues(alpha: 0.1),
                              borderRadius: AppRadius.br5,
                            ),
                            child: Text(_typeLabel,
                                style: AppTypography.caption.copyWith(color: _color, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: AppSpacing.s3),
                          Text(
                            DateFormat('MMM d, yyyy').format(event.date),
                            style: AppTypography.caption.copyWith(color: AppColors.n400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (event.route != null) Icon(Icons.chevron_right, color: AppColors.n400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
