import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_client/pharma_lms_client.dart' show AccessLog;
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import 'package:pharma_lms_flutter/design_system/pharma_design_system.dart';

class UserAccessLogsScreen extends ConsumerStatefulWidget {
  final int userId;
  final String userName;

  const UserAccessLogsScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  ConsumerState<UserAccessLogsScreen> createState() => _UserAccessLogsScreenState();
}

class _UserAccessLogsScreenState extends ConsumerState<UserAccessLogsScreen> {
  DateTime? _from;
  DateTime? _to;
  bool _exporting = false;

  Future<List<AccessLog>> _load() async {
    return client.audit.getAccessLogs(
      userId: widget.userId,
      from: _from,
      to: _to,
      limit: 500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access Logs'),
        elevation: 0,
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<AccessLog>>(
        future: _load(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error loading access logs: ${snap.error}'));
          }

          final logs = snap.data ?? const <AccessLog>[];
          return ListView(
            padding: EdgeInsets.all(PharmaSpacing.cardPadding),
            children: [
              Container(
                padding: EdgeInsets.all(PharmaSpacing.md),
                decoration: BoxDecoration(
                  color: PharmaColors.infoBg,
                  borderRadius: BorderRadius.circular(PharmaSpacing.sm),
                  border: Border.all(color: PharmaColors.info),
                ),
                child: Text(
                  'Access logs for: ${widget.userName}',
                  style: PharmaTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PharmaColors.infoText,
                  ),
                ),
              ),
              SizedBox(height: PharmaSpacing.md),
              Wrap(
                spacing: PharmaSpacing.md,
                runSpacing: PharmaSpacing.md,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        initialDate: _from ?? DateTime.now().subtract(const Duration(days: 30)),
                      );
                      if (picked == null) return;
                      setState(() => _from = DateTime(picked.year, picked.month, picked.day));
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text(_from == null ? 'From date' : 'From: ${_from!.toIso8601String().split('T').first}'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(const Duration(days: 1)),
                        initialDate: _to ?? DateTime.now(),
                      );
                      if (picked == null) return;
                      setState(() => _to = DateTime(picked.year, picked.month, picked.day, 23, 59, 59));
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text(_to == null ? 'To date' : 'To: ${_to!.toIso8601String().split('T').first}'),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _from = null;
                      _to = null;
                    }),
                    child: const Text('Clear'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _exporting
                        ? null
                        : () async {
                            setState(() => _exporting = true);
                            try {
                              final csv = _toCsv(logs);
                              final bytes = Uint8List.fromList(utf8.encode(csv));
                              await saveBytesToFile(bytes, 'user_${widget.userId}_access_logs.csv');
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Access logs CSV saved')),
                              );
                            } finally {
                              if (mounted) setState(() => _exporting = false);
                            }
                          },
                    icon: const Icon(Icons.download),
                    label: Text(_exporting ? 'Exporting...' : 'Export CSV'),
                  ),
                ],
              ),
              SizedBox(height: PharmaSpacing.md),
              Text(
                '${logs.length} entries',
                style: PharmaTypography.headingMedium.copyWith(color: PharmaColors.primary),
              ),
              SizedBox(height: PharmaSpacing.md),
              ...logs.map(_logCard),
              if (logs.isEmpty)
                Text(
                  'No access logs found.',
                  style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _logCard(AccessLog log) {
    return Card(
      margin: EdgeInsets.only(bottom: PharmaSpacing.md),
      child: Padding(
        padding: EdgeInsets.all(PharmaSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              log.action.toUpperCase(),
              style: PharmaTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: PharmaSpacing.xs),
            Text(
              '${log.success ? 'OK' : 'FAIL'} • ${log.timestamp.toLocal()}',
              style: PharmaTypography.caption.copyWith(color: PharmaColors.textSecondary),
            ),
            if ((log.ipAddress ?? '').isNotEmpty) ...[
              SizedBox(height: PharmaSpacing.xs),
              Text(log.ipAddress!, style: PharmaTypography.caption),
            ],
            if ((log.userAgent ?? '').isNotEmpty) ...[
              SizedBox(height: PharmaSpacing.xs),
              Text(log.userAgent!, style: PharmaTypography.caption),
            ],
          ],
        ),
      ),
    );
  }

  String _toCsv(List<AccessLog> logs) {
    final b = StringBuffer();
    b.writeln('timestamp,action,success,ipAddress,userAgent');
    for (final l in logs) {
      final ts = l.timestamp.toIso8601String();
      final action = l.action.replaceAll('"', '""');
      final ok = l.success ? 'true' : 'false';
      final ip = (l.ipAddress ?? '').replaceAll('"', '""');
      final ua = (l.userAgent ?? '').replaceAll('"', '""');
      b.writeln('"$ts","$action","$ok","$ip","$ua"');
    }
    return b.toString();
  }
}

