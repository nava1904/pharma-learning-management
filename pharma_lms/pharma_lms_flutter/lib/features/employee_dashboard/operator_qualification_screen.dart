import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design_system/pharma_design_system.dart';
import '../../providers/user_provider.dart';
import 'widgets/employee_page_scaffold.dart';

/// Manufacturing-style operator view: minimal UI to look up qualification by asset/equipment code.
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

    return userAsync.when(
      loading: () => const EmployeePageLoading(cardCount: 2),
      error: (e, _) => EmployeePageError(message: '$e'),
      data: (user) {
        final roleLabel = user?.jobRole?.name ?? 'GxP learner';
        return EmployeePageScaffold(
          title: 'Operator qualification check',
          subtitle: 'Signed in as $roleLabel',
          icon: Icons.qr_code_scanner_rounded,
          scrollable: false,
          child: ListView(
            padding: const EdgeInsets.only(bottom: PharmaSpacing.xl),
            children: [
              Text(
                'Floor / operator mode',
                style: PharmaTypography.headingMedium,
              ),
              const SizedBox(height: PharmaSpacing.sm),
              Text(
                'Scan or enter an equipment / asset code '
                '(when equipment master data is connected, this will verify training currency).',
                style: PharmaTypography.body.copyWith(
                  color: PharmaColors.textSecondary,
                ),
              ),
              const SizedBox(height: PharmaSpacing.xl),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Asset / equipment code',
                  border: const OutlineInputBorder(),
                  hintText: 'Paste QR payload or type code',
                  prefixIcon: const Icon(Icons.qr_code_rounded),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: PharmaColors.emerald600,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: PharmaSpacing.md),
              FilledButton.icon(
                onPressed: () {
                  final code = _codeController.text.trim();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        code.isEmpty
                            ? 'Enter a code first.'
                            : 'Code "$code" recorded. Connect equipment master + training matrix APIs to show live qualification.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.verified_rounded, size: 18),
                label: const Text('Check qualification'),
                style: FilledButton.styleFrom(
                  backgroundColor: PharmaColors.emerald600,
                  padding: const EdgeInsets.symmetric(
                    horizontal: PharmaSpacing.lg,
                    vertical: PharmaSpacing.md,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
