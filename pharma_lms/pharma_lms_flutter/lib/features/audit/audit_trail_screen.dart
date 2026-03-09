import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// Immutable audit trail viewer - FDA 21 CFR Part 11.
class AuditTrailScreen extends StatefulWidget {
  const AuditTrailScreen({super.key});

  @override
  State<AuditTrailScreen> createState() => _AuditTrailScreenState();
}

enum _AuditTab { auditTrail, accessLogs }

class _AuditTrailScreenState extends State<AuditTrailScreen> {
  List<AuditTrail> _trail = [];
  List<AccessLog> _accessLogs = [];
  bool _loading = true;
  String? _error;
  String? _entityTypeFilter;
  _AuditTab _selectedTab = _AuditTab.auditTrail;

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
      if (_selectedTab == _AuditTab.auditTrail) {
        final results = await client.audit.getAuditTrail(
          entityType: _entityTypeFilter,
          from: _from,
          to: _to,
          limit: 100,
        );
        setState(() {
          _trail = results;
          _loading = false;
        });
      } else {
        final results = await client.audit.getAccessLogs(
          from: _from,
          to: _to,
          limit: 100,
        );
        setState(() {
          _accessLogs = results;
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  DateTime? _from;
  DateTime? _to;

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Trail'),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = _AuditTab.auditTrail;
                    _load();
                  });
                },
                child: Text(
                  'Audit Trail',
                  style: TextStyle(
                    fontWeight: _selectedTab == _AuditTab.auditTrail
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = _AuditTab.accessLogs;
                    _load();
                  });
                },
                child: Text(
                  'Access Logs',
                  style: TextStyle(
                    fontWeight: _selectedTab == _AuditTab.accessLogs
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
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
                          if (_selectedTab == _AuditTab.auditTrail)
                            DropdownButton<String?>(
                              value: _entityTypeFilter,
                              hint: const Text('Entity type'),
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('All'),
                                ),
                                ...['training_record', 'course', 'course_version', 'enrollment', 'certificate']
                                    .map((e) => DropdownMenuItem(
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
                      if (_selectedTab == _AuditTab.auditTrail) ...[
                        if (_trail.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('No audit records'),
                          )
                        else
                          ..._trail.map((a) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
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
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            )),
                      ] else ...[
                        if (_accessLogs.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('No access logs'),
                          )
                        else
                          ..._accessLogs.map((log) => Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text(
                                    log.action,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        log.timestamp.toIso8601String(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      if (log.user != null)
                                        Text(
                                          'User: ${log.user!.firstName} ${log.user!.lastName} (${log.user!.email})',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      if (log.ipAddress != null)
                                        Text(
                                          'IP: ${log.ipAddress}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      Text(
                                        'Success: ${log.success}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  leading: Icon(
                                    log.success
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: log.success
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  isThreeLine: true,
                                ),
                              )),
                      ],
                    ],
                  ),
                ),
    );
  }
}
