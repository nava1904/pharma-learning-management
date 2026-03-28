import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';

/// Manufacturing-style “operator view”: minimal UI to look up qualification by asset/equipment code.
/// Full QR + equipment master integration is tracked in the LMS gap backlog.
class OperatorQualificationScreen extends ConsumerStatefulWidget {
  const OperatorQualificationScreen({super.key});

  @override
  ConsumerState<OperatorQualificationScreen> createState() =>
      _OperatorQualificationScreenState();
}

class _OperatorQualificationScreenState
    extends ConsumerState<OperatorQualificationScreen> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operator qualification check'),
        backgroundColor: PharmaColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(PharmaSpacing.pagePadding),
        child: userAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error: $e'),
          data: (user) {
            final roleLabel = user?.jobRole?.name ?? 'GxP learner';
            return ListView(
              children: [
                Text(
                  'Floor / operator mode',
                  style: PharmaTypography.headingLarge,
                ),
                SizedBox(height: PharmaSpacing.sm),
                Text(
                  'You are signed in as $roleLabel. Scan or enter an equipment / asset code '
                  '(when equipment master data is connected, this will verify training currency).',
                  style: PharmaTypography.body.copyWith(color: PharmaColors.textSecondary),
                ),
                SizedBox(height: PharmaSpacing.xl),
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Asset / equipment code',
                    border: OutlineInputBorder(),
                    hintText: 'Paste QR payload or type code',
                  ),
                ),
                SizedBox(height: PharmaSpacing.md),
                FilledButton(
                  onPressed: () {
                    final code = _codeController.text.trim();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          code.isEmpty
                              ? 'Enter a code first.'
                              : 'Code “$code” recorded. Connect equipment master + training matrix APIs to show live qualification.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Check qualification'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
