import 'package:flutter/material.dart';

class AccessReviewWarningBanner extends StatelessWidget {
  final int pendingAutoRevoke;
  const AccessReviewWarningBanner({super.key, required this.pendingAutoRevoke});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange[800]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$pendingAutoRevoke records pending auto-revocation. Review immediately.',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[900]),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Code: UPDATE users SET status='REVOKED' WHERE last_login < NOW() - INTERVAL '90 days' AND review_status='PENDING';",
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
