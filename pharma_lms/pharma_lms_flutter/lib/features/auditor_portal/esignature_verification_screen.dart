import 'package:flutter/material.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart';

import '../../core/client.dart';

/// E-signature verification screen for auditors - 21 CFR Part 11 inspection readiness.
class EsignatureVerificationScreen extends StatefulWidget {
  const EsignatureVerificationScreen({super.key});

  @override
  State<EsignatureVerificationScreen> createState() =>
      _EsignatureVerificationScreenState();
}

class _EsignatureVerificationScreenState
    extends State<EsignatureVerificationScreen> {
  List<ElectronicSignature> _signatures = [];
  bool _loading = true;
  String? _error;
  String? _entityTypeFilter;

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
      final results = await client.training.listElectronicSignatures(
        from: _from,
        to: _to,
        entityType: _entityTypeFilter,
        limit: 100,
      );
      setState(() {
        _signatures = results;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  DateTime? _from;
  DateTime? _to;

  Future<void> _showIntegrityCheck(BuildContext context, int signatureId) async {
    try {
      final result = await client.training.getSignatureWithIntegrityCheck(
        signatureId,
      );
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            result.integrityViolation
                ? 'INTEGRITY VIOLATION'
                : 'Signature Verified',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (result.integrityViolation)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'HMAC mismatch - possible tampering detected. '
                    'Do not rely on this signature.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (result.signature != null) ...[
                Text('Meaning: ${result.signature!.signatureMeaning}'),
                Text('Entity: ${result.signature!.entityType} / ${result.signature!.entityId}'),
                Text('Time: ${result.signature!.timestamp.toIso8601String()}'),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: $e')),
        );
      }
    }
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronic Signatures'),
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
                                'training_record',
                                'certificate',
                                'approval_workflow',
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
                              _to == null ? 'To date' : _formatDate(_to!),
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
                      if (_signatures.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No electronic signatures found'),
                        )
                      else
                        ..._signatures.map((s) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Icon(
                                  Icons.draw,
                                  color: s.integrityHash == null
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                                onTap: s.id != null
                                    ? () => _showIntegrityCheck(context, s.id!)
                                    : null,
                                title: Text(
                                  s.signatureMeaning,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${s.entityType} / ${s.entityId}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    Text(
                                      s.timestamp.toIso8601String(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    if (s.user != null)
                                      Text(
                                        'User: ${s.user!.firstName} ${s.user!.lastName}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    if (s.ipAddress != null)
                                      Text(
                                        'IP: ${s.ipAddress}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    Text(
                                      'Password re-auth: ${s.passwordReauthHash != null ? "Yes" : "No"}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
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
