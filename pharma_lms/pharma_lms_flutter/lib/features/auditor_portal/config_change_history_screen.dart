import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';

/// Config change history - FDA 21 CFR Part 11 config audit trail.
class ConfigChangeHistoryScreen extends StatefulWidget {
  const ConfigChangeHistoryScreen({super.key});

  @override
  State<ConfigChangeHistoryScreen> createState() =>
      _ConfigChangeHistoryScreenState();
}

class _ConfigChangeHistoryScreenState extends State<ConfigChangeHistoryScreen> {
  List<AuditTrail> _trail = [];
  bool _loading = true;
  String? _error;
  String? _entityTypeFilter;
  DateTime? _from;
  DateTime? _to;

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
      final results = await client.audit.getConfigChangeLog(
        entityType: _entityTypeFilter,
        from: _from,
        to: _to,
        limit: 100,
      );
      setState(() {
        _trail = results;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/auditor'),
        ),
        title: const Text('Config Change History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loading ? null : _load,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _load,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          DropdownButton<String?>(
                            value: _entityTypeFilter,
                            hint: const Text('Entity type'),
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('All'),
                              ),
                              ...[
                                'system_configuration',
                                'signature_meaning',
                                'training_matrix',
                                'job_role',
                                'assessment',
                                'role',
                              ].map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  )),
                            ],
                            onChanged: (v) {
                              setState(() => _entityTypeFilter = v);
                              _load();
                            },
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today, size: 18),
                            label: Text(
                              _from == null
                                  ? 'From date'
                                  : _formatDate(_from!),
                            ),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _from ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && mounted) {
                                setState(() {
                                  _from = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                  );
                                });
                                _load();
                              }
                            },
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today, size: 18),
                            label: Text(
                              _to == null
                                  ? 'To date'
                                  : _formatDate(_to!),
                            ),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _to ?? _from ?? DateTime.now(),
                                firstDate: _from ?? DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && mounted) {
                                setState(() {
                                  _to = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                    23,
                                    59,
                                    59,
                                    999,
                                  );
                                });
                                _load();
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _entityTypeFilter = null;
                                _from = null;
                                _to = null;
                              });
                              _load();
                            },
                            child: const Text('Clear filters'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_trail.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Icon(Icons.change_history, size: 64, color: AppColors.slate300),
                              const SizedBox(height: 16),
                              Text(
                                'No config change records',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.slate600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Configuration changes will appear here when they occur',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.slate500,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        ..._trail.map((a) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.settings,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  '${a.entityType} / ${a.entityId}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Action: ${a.action}'),
                                    Text(
                                      a.timestamp.toIso8601String(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    if (a.user != null)
                                      Text(
                                        'User: ${a.user!.firstName} ${a.user!.lastName}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    if (a.newValueJson != null)
                                      Text(
                                        'New: ${a.newValueJson}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            )),
                    ],
                  ),
                ),
    );
  }
}
