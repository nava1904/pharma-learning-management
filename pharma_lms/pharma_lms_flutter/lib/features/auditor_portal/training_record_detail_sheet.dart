import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/user_provider.dart';

/// QA-08: Training record detail with annotations. QA can add, auditor view-only.
class TrainingRecordDetailSheet extends ConsumerStatefulWidget {
  const TrainingRecordDetailSheet({
    super.key,
    required this.trainingRecordId,
    required this.courseTitle,
    this.score,
    this.passedAt,
    this.canAddAnnotation = false,
  });

  final int trainingRecordId;
  final String courseTitle;
  final int? score;
  final String? passedAt;
  final bool canAddAnnotation;

  @override
  ConsumerState<TrainingRecordDetailSheet> createState() =>
      _TrainingRecordDetailSheetState();
}

class _TrainingRecordDetailSheetState
    extends ConsumerState<TrainingRecordDetailSheet> {
  List<TrainingRecordAnnotation> _annotations = [];
  bool _loading = true;
  String? _error;
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final annotations =
          await client.training.listAnnotations(widget.trainingRecordId);
      if (mounted) {
        setState(() {
          _annotations = annotations;
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

  Future<void> _addAnnotation() async {
    final note = _noteController.text.trim();
    if (note.isEmpty) return;

    final user = await ref.read(currentUserProvider.future);
    if (user?.id == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Must be logged in to add annotation')),
        );
      }
      return;
    }

    try {
      await client.training.addAnnotation(
        trainingRecordId: widget.trainingRecordId,
        authorId: user!.id!,
        note: note,
      );
      _noteController.clear();
      if (mounted) _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.slate300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (widget.score != null || widget.passedAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          [
                            if (widget.score != null) 'Score: ${widget.score}',
                            if (widget.passedAt != null)
                              'Completed: ${widget.passedAt?.split('T').first ?? widget.passedAt}',
                          ].join(' • '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Annotations',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (widget.canAddAnnotation) ...[
                      const Spacer(),
                      Expanded(
                        child: TextField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                            hintText: 'Add note...',
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: _addAnnotation,
                        child: const Text('Add'),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _error != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_error!),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: _load,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : _annotations.isEmpty
                            ? Center(
                                child: Text(
                                  widget.canAddAnnotation
                                      ? 'No annotations yet. Add one above.'
                                      : 'No annotations.',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                                itemCount: _annotations.length,
                                itemBuilder: (context, i) {
                                  final a = _annotations[i];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      title: Text(a.note),
                                      subtitle: Text(
                                        '${a.author?.firstName ?? ''} ${a.author?.lastName ?? ''} • ${a.createdAt.toIso8601String().split('T').first}',
                                        style:
                                            Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
