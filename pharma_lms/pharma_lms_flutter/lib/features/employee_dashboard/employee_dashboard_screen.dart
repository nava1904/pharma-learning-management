import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' hide Material;
import 'package:intl/intl.dart';

import '../../design_system/pharma_design_system.dart';
import '../../providers/dashboard_providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// DESIGN TOKENS — mapped to PharmaDesignSystem
// ═══════════════════════════════════════════════════════════════════════════════
const Color _bgColor = PharmaColors.pageBg;
const Color _cardColor = PharmaColors.cardBg;
const Color _tealAccent = Color(0xFF48CFCB); // Teal chart/bars (accent)
const Color _coralAccent = Color(0xFFF89B80); // Coral/Orange chart/bars (accent)
const Color _textDark = PharmaColors.textPrimary;
const Color _textMuted = PharmaColors.textTertiary;
const Color _iconDark = PharmaColors.gray900;

final BorderRadius _cardRadius = PharmaRadius.cardRadius;
final BoxShadow _softShadow = BoxShadow(
  color: Colors.black.withValues(alpha: 0.03),
  blurRadius: 20,
  offset: const Offset(0, 4),
);

class EmployeeDashboardScreen extends ConsumerWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We use the existing consolidated provider - NO MOCK DATA
    final dashboardAsync = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      backgroundColor: _bgColor,
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _tealAccent)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (summary) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── CENTER CANVAS (Left 2/3 of the screen) ───
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. WELCOME HEADER (Matches: "Hello, Shubham 👋")
                      Text(
                        'Hello, ${summary.user.firstName} 👋',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your compliance training overview',
                        style: TextStyle(fontSize: 16, color: _textMuted),
                      ),
                      const SizedBox(height: 32),

                      // 2. STAT CARDS (Matches: "Total Enrolled", "Completed", "Quiz Score")
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              title: 'Total Enrolled',
                              value: (summary.inProgress.length + summary.toDo.length).toString(),
                              icon: Icons.visibility_outlined,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _StatCard(
                              title: 'Completed',
                              value: summary.completed.length.toString(),
                              icon: Icons.check_circle_outline,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _StatCard(
                              title: 'Certificates',
                              value: summary.compliance.totalCertificates.toString(),
                              icon: Icons.workspace_premium_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // 3. CHARTS ROW
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Matches: "Compliance Training Hours" Bar Chart
                          Expanded(
                            flex: 3,
                            child: _ComplianceTrainingHoursChart(completedCourses: summary.completed),
                          ),
                          const SizedBox(width: 24),
                          // Matches: "Performance" Gauge Chart
                          Expanded(
                            flex: 2,
                            child: _PerformanceGauge(complianceRate: summary.compliance.complianceRate),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // 4. LEADER BOARD / PRIORITY LIST
                      const Text(
                        'Priority Training',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _textDark),
                      ),
                      const SizedBox(height: 16),
                      _PriorityTrainingList(
                        inProgress: summary.inProgress,
                        toDo: summary.toDo,
                      ),
                    ],
                  ),
                ),
              ),

              // ─── RIGHT CONTEXT PANEL (Matches: Profile, Calendar, To Do List) ───
              Container(
                width: 340,
                decoration: BoxDecoration(
                  color: _cardColor,
                  border: Border(left: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Profile" Header & Edit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _textDark)),
                          IconButton(
                            onPressed: () => context.go('/employee/profile'),
                            icon: const Icon(Icons.edit_outlined, color: _textMuted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Avatar with Compliance Ring
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: summary.compliance.complianceRate / 100,
                                    strokeWidth: 6,
                                    backgroundColor: _bgColor,
                                    color: _coralAccent,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CircleAvatar(
                                      backgroundColor: _tealAccent.withValues(alpha: 0.2),
                                      child: Text(
                                        summary.user.firstName.isNotEmpty ? summary.user.firstName[0] : 'U',
                                        style: const TextStyle(fontSize: 28, color: _tealAccent, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${summary.user.firstName} ${summary.user.lastName}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, color: Colors.green, size: 16),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              summary.user.jobRole?.name ?? 'Employee',
                              style: const TextStyle(color: _textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Calendar Strip
                      _WeeklyCalendar(),
                      const SizedBox(height: 32),

                      // To Do List
                      const Text(
                        'To Do List',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark),
                      ),
                      const SizedBox(height: 16),
                      _ToDoChecklist(toDoItems: summary.toDo, assignments: summary.assignments),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: STAT CARD
// Exactly matches the white card with the bottom-right black icon box
// ═══════════════════════════════════════════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: _cardRadius,
        boxShadow: [_softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, color: _textMuted, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: _textDark)),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _iconDark,
                  borderRadius: BorderRadius.circular(PharmaRadius.lg),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: COMPLIANCE TRAINING HOURS CHART
// Derives hours from actual completed courses (completed count per month)
// ═══════════════════════════════════════════════════════════════════════════════
class _ComplianceTrainingHoursChart extends StatelessWidget {
  final List<Enrollment> completedCourses;

  const _ComplianceTrainingHoursChart({required this.completedCourses});

  @override
  Widget build(BuildContext context) {
    // Derive real monthly completion counts from completed enrollments
    final now = DateTime.now();
    final months = List.generate(5, (i) => DateTime(now.year, now.month - 4 + i));
    final monthLabels = months.map((d) => DateFormat('MMM').format(d)).toList();
    final List<double> hoursData = months.map((month) {
      final count = completedCourses.where((e) {
        final completedAt = e.completedAt;
        if (completedAt == null) return false;
        return completedAt.year == month.year && completedAt.month == month.month;
      }).length;
      // Approximate 1.5 hours per completed course
      return count * 1.5;
    }).toList();
    final maxY = (hoursData.reduce((a, b) => a > b ? a : b) * 1.3).clamp(10.0, 200.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Compliance Training Hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark)),
        const SizedBox(height: 16),
        Container(
          height: 250,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: _cardColor, borderRadius: _cardRadius, boxShadow: [_softShadow]),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(color: Colors.black.withValues(alpha: 0.05), strokeWidth: 1),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() < 0 || value.toInt() >= monthLabels.length) return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(monthLabels[value.toInt()], style: const TextStyle(color: _textMuted, fontSize: 12)),
                      );
                    },
                  ),
                ),
              ),
              barGroups: hoursData.asMap().entries.map((entry) {
                // Alternating colors based on the screenshot
                final isTeal = entry.key % 2 == 1; 
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: isTeal ? _tealAccent : _coralAccent,
                      width: 32,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: PERFORMANCE GAUGE
// Half-circle donut chart using fl_chart
// ═══════════════════════════════════════════════════════════════════════════════
class _PerformanceGauge extends StatelessWidget {
  final double complianceRate;

  const _PerformanceGauge({required this.complianceRate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark)),
        const SizedBox(height: 16),
        Container(
          height: 250,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: _cardColor, borderRadius: _cardRadius, boxShadow: [_softShadow]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: _tealAccent, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 8),
                      const Text('Compliance', style: TextStyle(fontSize: 12, color: _textMuted)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(8)),
                    child: const Text('Monthly v', style: TextStyle(fontSize: 12, color: _textDark)),
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: [
                          PieChartSectionData(value: complianceRate, color: _tealAccent, radius: 15, showTitle: false),
                          PieChartSectionData(value: 100 - complianceRate, color: _bgColor, radius: 15, showTitle: false),
                          // Hidden bottom half to make it a semi-circle
                          PieChartSectionData(value: 100, color: Colors.transparent, radius: 15, showTitle: false),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        const Text('Your Score:', style: TextStyle(color: _textMuted, fontSize: 14)),
                        Text('${complianceRate.toInt()}%', style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: complianceRate >= 80 ? _tealAccent : _coralAccent,
                        )),
                        if (complianceRate < 80)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text('Below 80% threshold',
                              style: TextStyle(color: _coralAccent, fontSize: 11, fontWeight: FontWeight.w600)),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: PRIORITY TRAINING LIST
// Matches the "Leader Board" style list at the bottom
// ═══════════════════════════════════════════════════════════════════════════════
class _PriorityTrainingList extends StatelessWidget {
  final List<Enrollment> inProgress;
  final List<Enrollment> toDo;

  const _PriorityTrainingList({required this.inProgress, required this.toDo});

  @override
  Widget build(BuildContext context) {
    final combined = [...inProgress, ...toDo].take(4).toList();

    if (combined.isEmpty) {
      return const Center(child: Text('All caught up!', style: TextStyle(color: _textMuted)));
    }

    return Container(
      decoration: BoxDecoration(color: _cardColor, borderRadius: _cardRadius, boxShadow: [_softShadow]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: const [
                SizedBox(width: 40, child: Text('STATUS', style: TextStyle(fontSize: 10, color: _textMuted, fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('COURSE NAME', style: TextStyle(fontSize: 10, color: _textMuted, fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('EST. TIME', style: TextStyle(fontSize: 10, color: _textMuted, fontWeight: FontWeight.bold))),
                SizedBox(width: 100, child: Text('ACTION', style: TextStyle(fontSize: 10, color: _textMuted, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              ],
            ),
          ),
          const Divider(height: 1, color: _bgColor),
          ...combined.map((enrollment) {
            final isStarted = enrollment.status == 'in_progress';
            final course = enrollment.courseVersion?.course;
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _bgColor))),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(
                      isStarted ? Icons.play_arrow : Icons.fiber_manual_record, 
                      color: isStarted ? _tealAccent : _coralAccent,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.menu_book, size: 16, color: _textMuted),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            course?.title ?? 'Course',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: _textDark, fontSize: 14),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text('—', style: TextStyle(color: _textMuted, fontSize: 13)),
                  ),
                  SizedBox(
                    width: 100,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.go('/employee/course/${course?.id ?? enrollment.courseVersionId}', extra: {
                          'courseVersionId': enrollment.courseVersionId.toString(),
                          'enrollmentId': enrollment.id?.toString(),
                        }),
                        child: Text(isStarted ? 'Resume' : 'Start', style: const TextStyle(color: _tealAccent, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: CALENDAR STRIP
// ═══════════════════════════════════════════════════════════════════════════════
class _WeeklyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekDates = List.generate(7, (index) => now.subtract(Duration(days: now.weekday - 1 - index)));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _cardColor, borderRadius: _cardRadius, boxShadow: [_softShadow], border: Border.all(color: _bgColor)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.chevron_left, size: 16, color: _textMuted),
              Text(DateFormat('MMMM yyyy').format(now), style: const TextStyle(fontWeight: FontWeight.bold, color: _textDark)),
              const Icon(Icons.chevron_right, size: 16, color: _textMuted),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDates.map((date) {
              final isToday = date.day == now.day && date.month == now.month;
              return Container(
                width: 32,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: isToday ? BoxDecoration(color: _iconDark, borderRadius: BorderRadius.circular(16)) : null,
                child: Column(
                  children: [
                    Text(DateFormat('E').format(date).substring(0, 1), style: TextStyle(fontSize: 10, color: isToday ? Colors.white70 : _textMuted)),
                    const SizedBox(height: 8),
                    Text('${date.day}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isToday ? Colors.white : _textDark)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// WIDGET: TO-DO LIST CHECKBOXES
// ═══════════════════════════════════════════════════════════════════════════════
class _ToDoChecklist extends StatelessWidget {
  final List<Enrollment> toDoItems;
  final List<TrainingAssignment> assignments;

  const _ToDoChecklist({required this.toDoItems, required this.assignments});

  @override
  Widget build(BuildContext context) {
    if (toDoItems.isEmpty) return const Text('All caught up!', style: TextStyle(color: _textMuted));

    return Column(
      children: toDoItems.take(5).map((enrollment) {
        final course = enrollment.courseVersion?.course;
        final assignment = assignments.where((a) => a.courseVersionId == enrollment.courseVersionId).firstOrNull;
        final dueText = assignment != null ? DateFormat('MMM d').format(assignment.dueDate) : 'Soon';

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(border: Border.all(color: _textMuted), borderRadius: BorderRadius.circular(6)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course?.title ?? 'Training', style: const TextStyle(fontWeight: FontWeight.w600, color: _textDark, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text('Due: $dueText', style: const TextStyle(color: _coralAccent, fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}