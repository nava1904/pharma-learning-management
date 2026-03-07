import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuditorPortalScreen extends StatelessWidget {
  const AuditorPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditor Inspection Portal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Audit Trail'),
              subtitle: const Text('View immutable audit logs for inspection'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => context.push('/audit-trail'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Compliance Report'),
              subtitle: const Text('Department compliance and audit readiness'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => context.push('/compliance-report'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.draw),
              title: const Text('Electronic Signatures'),
              subtitle: const Text('Verify e-signature records'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => context.push('/esignature-verification'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export for Inspection'),
              subtitle: const Text('Generate inspection-ready reports'),
              onTap: () => context.push('/compliance-report'),
            ),
          ),
        ],
      ),
    );
  }
}
