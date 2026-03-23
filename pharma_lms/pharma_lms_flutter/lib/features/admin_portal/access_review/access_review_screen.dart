
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/access_review_provider.dart';
import 'access_review_header.dart';
import 'access_review_warning_banner.dart';
import 'access_review_table.dart';
import 'access_review_justification_dialog.dart';
import 'access_review_esignature_dialog.dart';

/// PharmaLMS Admin Portal - Access Review Screen (Scaffold)
///
/// This is the main entry for the Access Review feature, matching the regulatory and UI requirements.

class AccessReviewScreen extends ConsumerWidget {
  const AccessReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Parameterize windowId as needed
    const int windowId = 1;
    final reviewsAsync = ref.watch(accessReviewProvider(windowId));

    return reviewsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading access reviews: $e')),
      data: (reviews) {
        // Compute summary stats from reviews
        final totalToReview = reviews.length;
        final recertified = reviews.where((r) => r.decision == 'APPROVED').length;
        final revoked = reviews.where((r) => r.decision == 'REVOKED').length;
        final pending = reviews.where((r) => r.decision == 'PENDING').length;
        final progress = totalToReview > 0 ? recertified / totalToReview : 0.0;
        final daysLeft = 10; // TODO: Compute from windowClose
        final windowOpen = reviews.isNotEmpty ? reviews.first.windowOpen : DateTime.now();
        final windowClose = reviews.isNotEmpty ? reviews.first.windowClose : DateTime.now();
        final pendingAutoRevoke = pending;

        // Map backend data to AccessReviewRowData for table
        final rows = reviews.map((r) => AccessReviewRowData(
          employeeName: r.user?.firstName ?? 'Unknown',
          employeeId: r.user?.employeeId ?? '',
          deptRole: '${r.user?.department?.name ?? ''}\n${r.user?.jobRole?.name ?? ''}',
          site: r.user?.site?.name ?? '',
          hireDate: r.user?.createdAt != null ? r.user!.createdAt.toIso8601String().split('T').first : '',
          compliancePercent: 100, // TODO: Compute real compliance
          status: r.user?.status ?? '',
          mfaType: 'TOTP', // TODO: Fetch real MFA type
          lastLogin: '', // TODO: Fetch real last login
          loginRisk: '', // TODO: Compute login risk
          avatarUrl: '', // TODO: Provide avatar URL
        )).toList();

        void onRecertify(AccessReviewRowData row) {
          showDialog(
            context: context,
            builder: (context) => AccessReviewJustificationDialog(
              action: 'Recertify',
              onSubmit: (justification) async {
                // TODO: Call backend to recertify
                Navigator.of(context).pop();
                ref.invalidate(accessReviewProvider(windowId));
              },
            ),
          );
        }

        void onRevoke(AccessReviewRowData row) {
          showDialog(
            context: context,
            builder: (context) => AccessReviewJustificationDialog(
              action: 'Revoke',
              onSubmit: (justification) async {
                // TODO: Call backend to revoke
                Navigator.of(context).pop();
                ref.invalidate(accessReviewProvider(windowId));
              },
            ),
          );
        }

        void onSign() {
          showDialog(
            context: context,
            builder: (context) => AccessReviewESignatureDialog(
              onSign: (password, reason) {
                // TODO: Call backend to submit e-signature
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review signed!')),
                );
              },
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Privileged Access Review'),
            actions: [
              ElevatedButton.icon(
                onPressed: onSign,
                icon: const Icon(Icons.edit_document),
                label: const Text('Sign & Export'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessReviewHeader(
                  totalToReview: totalToReview,
                  recertified: recertified,
                  revoked: revoked,
                  pending: pending,
                  daysLeft: daysLeft,
                  progress: progress,
                  windowOpen: windowOpen,
                  windowClose: windowClose,
                ),
                AccessReviewWarningBanner(pendingAutoRevoke: pendingAutoRevoke),
                const SizedBox(height: 16),
                Expanded(
                  child: AccessReviewTable(
                    rows: rows,
                    onRecertify: onRecertify,
                    onRevoke: onRevoke,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
