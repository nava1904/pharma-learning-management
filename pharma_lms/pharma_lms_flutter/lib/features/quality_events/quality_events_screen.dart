import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/repository_providers.dart';
import '../esignature/esignature_screen.dart' show showEsignatureModal;

/// Quality Events and CAPA management - QA role.
class QualityEventsScreen extends ConsumerStatefulWidget {
  const QualityEventsScreen({super.key});

  @override
  ConsumerState<QualityEventsScreen> createState() => _QualityEventsScreenState();
}

class _QualityEventsScreenState extends ConsumerState<QualityEventsScreen> {
  List<QualityEvent> _events = [];
  List<Capa> _capas = [];
  bool _loading = true;
  String? _error;
  String? _eventTypeFilter;
  String? _statusFilter;
  int _selectedTab = 0; // 0 = Events, 1 = CAPAs

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
    final repo = ref.read(qualityEventRepositoryProvider);
    try {
      if (_selectedTab == 0) {
        final events = await repo.listQualityEvents(
          eventType: _eventTypeFilter,
          status: _statusFilter,
        );
        setState(() {
          _events = events;
          _loading = false;
        });
      } else {
        final capas = await repo.listCapas(
          status: _statusFilter,
        );
        setState(() {
          _capas = capas;
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

  Future<void> _showCreateEvent() async {
    final titleController = TextEditingController();
    String eventType = 'deviation';
    String status = 'Open';
    final refController = TextEditingController();

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: const Text('Create Quality Event'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: eventType,
                    decoration: const InputDecoration(
                      labelText: 'Event Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['deviation', 'capa', 'change_control']
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (t) => setState(() => eventType = t ?? 'deviation'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Open', 'In Progress', 'Closed']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (s) => setState(() => status = s ?? 'Open'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: refController,
                    decoration: const InputDecoration(
                      labelText: 'Reference ID (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
    if (ok != true || !mounted) return;
    if (titleController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title is required')),
        );
      }
      return;
    }
    final repo = ref.read(qualityEventRepositoryProvider);
    try {
      await repo.createQualityEvent(
        eventType: eventType,
        title: titleController.text.trim(),
        status: status,
        referenceId: refController.text.trim().isEmpty
            ? null
            : refController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quality event created')),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _showCreateCapa(QualityEvent event) async {
    if (event.id == null) return;
    final descController = TextEditingController();
    final rootCauseController = TextEditingController();
    bool trainingRequired = false;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setState) {
          return AlertDialog(
            title: Text('Create CAPA for ${event.title}'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: rootCauseController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Root Cause',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    title: const Text('Training required'),
                    value: trainingRequired,
                    onChanged: (v) => setState(() => trainingRequired = v ?? false),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
    if (ok != true || !mounted) return;
    final repo = ref.read(qualityEventRepositoryProvider);
    try {
      await repo.createCapa(
        qualityEventId: event.id!,
        description: descController.text.trim().isEmpty
            ? null
            : descController.text.trim(),
        rootCause: rootCauseController.text.trim().isEmpty
            ? null
            : rootCauseController.text.trim(),
        trainingRequired: trainingRequired,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CAPA created')),
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _showCapaActions(Capa capa) async {
    if (capa.id == null) return;
    final statuses = [
      'Initiation',
      'Investigation',
      'ActionPlanApproved',
      'Implementation',
      'Verification',
      'Closed',
    ];

    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Update Status'),
              leading: const Icon(Icons.update),
              onTap: () async {
                Navigator.pop(ctx);
                final newStatus = await showDialog<String>(
                  context: context,
                  builder: (ctx2) => SimpleDialog(
                    title: const Text('Select Status'),
                    children: statuses
                        .where((s) => s != capa.status)
                        .map((s) => SimpleDialogOption(
                              onPressed: () => Navigator.pop(ctx2, s),
                              child: Text(s),
                            ))
                        .toList(),
                  ),
                );
                if (newStatus != null && mounted) {
                  final repo = ref.read(qualityEventRepositoryProvider);
                  try {
                    await repo.updateCapaStatus(
                      capaId: capa.id!,
                      status: newStatus,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Status updated')),
                      );
                      _load();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed: $e')),
                      );
                    }
                  }
                }
              },
            ),
            if (capa.status != 'Closed')
              ListTile(
                title: const Text('Close CAPA'),
                leading: const Icon(Icons.check_circle),
                onTap: () async {
                  Navigator.pop(ctx);
                  
                  // QA-WF-04: Require e-signature for CAPA closure (21 CFR Part 11)
                  final esignatureId = await showEsignatureModal(
                    context,
                    entityType: 'capa',
                    entityId: capa.id.toString(),
                    signatureMeaning: 'I certify this CAPA is effectively closed and verified',
                  );

                  if (esignatureId == null || !mounted) {
                    // User cancelled or signature failed
                    return;
                  }

                  final user = await client.user.getUserByEmail('qa@pharmacorp.demo');
                  if (user?.id == null) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('QA user not found')),
                      );
                    }
                    return;
                  }
                  final repo = ref.read(qualityEventRepositoryProvider);
                  try {
                    await repo.closeCapa(
                      capaId: capa.id!,
                      closedById: user!.id!,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('CAPA closed with e-signature verification'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      _load();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed: $e')),
                      );
                    }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quality Events'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/qa'),
        ),
        actions: [
          DropdownButton<String?>(
            value: _eventTypeFilter,
            hint: const Text('Type'),
            items: [
              const DropdownMenuItem(value: null, child: Text('All')),
              ...['deviation', 'capa', 'change_control']
                  .map((t) => DropdownMenuItem(value: t, child: Text(t))),
            ],
            onChanged: (v) {
              setState(() {
                _eventTypeFilter = v;
                _load();
              });
            },
          ),
          DropdownButton<String?>(
            value: _statusFilter,
            hint: const Text('Status'),
            items: [
              const DropdownMenuItem(value: null, child: Text('All')),
              ...{'Open', 'In Progress', 'Closed', 'Initiation', 'Verification'}
                  .map((s) => DropdownMenuItem(value: s, child: Text(s))),
            ],
            onChanged: (v) {
              setState(() {
                _statusFilter = v;
                _load();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loading ? null : _load,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateEvent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedTab = 0;
                      _load();
                    });
                  },
                  child: Text(
                    'Quality Events',
                    style: TextStyle(
                      fontWeight:
                          _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedTab = 1;
                      _load();
                    });
                  },
                  child: Text(
                    'CAPAs',
                    style: TextStyle(
                      fontWeight:
                          _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _loading
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
                        child: _selectedTab == 0
                            ? _buildEventsList()
                            : _buildCapasList(),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    if (_events.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No quality events. Create one to get started.'),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _events.length,
      itemBuilder: (context, i) {
        final e = _events[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              e.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${e.eventType} • ${e.status}'),
                if (e.referenceId != null) Text('Ref: ${e.referenceId}'),
                Text(
                  e.createdAt.toIso8601String().split('T').first,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            trailing: e.eventType == 'capa'
                ? IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _showCreateCapa(e),
                    tooltip: 'Create CAPA',
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildCapasList() {
    if (_capas.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No CAPAs. Create a quality event of type "capa" first.'),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _capas.length,
      itemBuilder: (context, i) {
        final c = _capas[i];
        final isClosed = c.status == 'Closed';
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            onTap: () => _showCapaActions(c),
            title: Text(
              c.description ?? 'CAPA #${c.id}',
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${c.status}'),
                if (c.rootCause != null) Text('Root cause: ${c.rootCause}'),
                if (c.effectivenessCheckDue != null)
                  Text(
                    'Effectiveness due: ${c.effectivenessCheckDue!.toIso8601String().split('T').first}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (c.closedAt != null)
                  Text(
                    'Closed: ${c.closedAt!.toIso8601String().split('T').first}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (c.qualityEvent != null)
                  Text(
                    'Event: ${c.qualityEvent!.title}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
                  trailing: isClosed
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Closed'),
                  )
                : const Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
