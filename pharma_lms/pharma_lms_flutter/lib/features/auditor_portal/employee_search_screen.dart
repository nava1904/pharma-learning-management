import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'training_record_detail_sheet.dart';

/// AUD-02: Employee search for audit with full training chain view.
class EmployeeSearchScreen extends ConsumerStatefulWidget {
  const EmployeeSearchScreen({super.key});

  @override
  ConsumerState<EmployeeSearchScreen> createState() =>
      _EmployeeSearchScreenState();
}

class _EmployeeSearchScreenState extends ConsumerState<EmployeeSearchScreen> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _loading = false;
  String? _error;
  final Set<int> _expandedIndices = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _results = [];
      _expandedIndices.clear();
    });

    try {
      final results = await client.inspection.searchEmployeesForAudit(
        query: query,
        limit: 20,
      );
      if (mounted) {
        setState(() {
          _results = results;
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

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  void _showTrainingRecordDetail(BuildContext context, {
    required int trainingRecordId,
    required String courseTitle,
    int? score,
    String? passedAt,
    required bool canAddAnnotation,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => TrainingRecordDetailSheet(
        trainingRecordId: trainingRecordId,
        courseTitle: courseTitle,
        score: score,
        passedAt: passedAt,
        canAddAnnotation: canAddAnnotation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/auditor'),
        ),
        title: const Text('Employee Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by name, email, or ID...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _loading ? null : _search,
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Search'),
                ),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _error!,
                style: TextStyle(color: AppColors.destructive),
              ),
            ),
          Expanded(
            child: _results.isEmpty && !_loading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.trim().isEmpty
                              ? Icons.person_search
                              : Icons.search_off,
                          size: 64,
                          color: AppColors.slate300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.trim().isEmpty
                              ? 'Enter a search term to find employees'
                              : 'No results found',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.slate600,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        if (_searchController.text.trim().isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Search by name, email, or employee ID',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.slate500,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final r = _results[index];
                      return _EmployeeResultCard(
                        data: r,
                        expanded: _expandedIndices.contains(index),
                        onTap: () => _toggleExpanded(index),
                        canAddAnnotation:
                            ref.watch(selectedRoleProvider) == AppRole.qa,
                        onRecordTap: (id, title, score, passedAt, canAdd) =>
                            _showTrainingRecordDetail(
                          context,
                          trainingRecordId: id,
                          courseTitle: title,
                          score: score,
                          passedAt: passedAt,
                          canAddAnnotation: canAdd,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeResultCard extends StatelessWidget {
  const _EmployeeResultCard({
    required this.data,
    required this.expanded,
    required this.onTap,
    this.canAddAnnotation = false,
    required this.onRecordTap,
  });

  final Map<String, dynamic> data;
  final bool expanded;
  final VoidCallback onTap;
  final bool canAddAnnotation;
  final void Function(
    int trainingRecordId,
    String courseTitle,
    int? score,
    String? passedAt,
    bool canAddAnnotation,
  ) onRecordTap;

  @override
  Widget build(BuildContext context) {
    final user = data['user'] as Map<String, dynamic>? ?? {};
    final userName =
        '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim();
    final email = user['email'] as String? ?? '';
    final userId = data['userId'] as int? ?? 0;

    final assignments =
        (data['assignments'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    final enrollments =
        (data['enrollments'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    final records =
        (data['records'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
    final certificates =
        (data['certificates'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.isNotEmpty ? userName : 'Unknown',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          email,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'ID: $userId',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _ChainBadge(
                    label: 'Assignments',
                    count: assignments.length,
                  ),
                  const SizedBox(width: 8),
                  _ChainBadge(
                    label: 'Enrollments',
                    count: enrollments.length,
                  ),
                  const SizedBox(width: 8),
                  _ChainBadge(
                    label: 'Records',
                    count: records.length,
                  ),
                  const SizedBox(width: 8),
                  _ChainBadge(
                    label: 'Certificates',
                    count: certificates.length,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ChainSection(
                    title: 'Assignments',
                    items: assignments,
                    fields: ['courseTitle', 'dueDate', 'status', 'priority'],
                  ),
                  const SizedBox(height: 12),
                  _ChainSection(
                    title: 'Enrollments',
                    items: enrollments,
                    fields: [
                      'courseTitle',
                      'status',
                      'startedAt',
                      'completedAt',
                      'assignmentId'
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ChainSection(
                    title: 'Training Records',
                    items: records,
                    fields: [
                      'courseTitle',
                      'score',
                      'passedAt',
                      'enrollmentId',
                    ],
                    onItemTap: (item) {
                      if (item['id'] != null) {
                        onRecordTap(
                          item['id'] as int,
                          item['courseTitle'] as String? ?? 'Training Record',
                          item['score'] as int?,
                          item['passedAt'] as String?,
                          canAddAnnotation,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  _ChainSection(
                    title: 'Certificates',
                    items: certificates,
                    fields: [
                      'courseTitle',
                      'status',
                      'issuedAt',
                      'expiresAt',
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ChainBadge extends StatelessWidget {
  const _ChainBadge({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$count',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _ChainSection extends StatelessWidget {
  const _ChainSection({
    required this.title,
    required this.items,
    required this.fields,
    this.onItemTap,
  });

  final String title;
  final List<Map<String, dynamic>> items;
  final List<String> fields;
  final void Function(Map<String, dynamic> item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text('$title: None');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        ...items.map((item) {
          final parts = <String>[];
          for (final f in fields) {
            final v = item[f];
            if (v != null) parts.add('$f: $v');
          }
          final child = Padding(
            padding: const EdgeInsets.only(left: 8, top: 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    parts.join(' • '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                if (onItemTap != null)
                  TextButton(
                    onPressed: () => onItemTap!(item),
                    child: const Text('View'),
                  ),
              ],
            ),
          );
          return child;
        }),
      ],
    );
  }
}
