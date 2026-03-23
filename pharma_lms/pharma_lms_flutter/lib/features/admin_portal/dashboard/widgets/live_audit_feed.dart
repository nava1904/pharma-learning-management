import 'package:flutter/material.dart';

class LiveAuditFeed extends StatelessWidget {
  final List<AuditEvent> events;
  const LiveAuditFeed({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      width: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LIVE AUDIT FEED',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Last 10 events in vyuhlms',
            style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, i) {
                final e = events[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '${e.timestamp} UTC\n${e.action}: ${e.summary}',
                    style: const TextStyle(color: Colors.white, fontFamily: 'JetBrains Mono', fontSize: 13),
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

class AuditEvent {
  final String timestamp;
  final String action;
  final String summary;
  AuditEvent({required this.timestamp, required this.action, required this.summary});
}
