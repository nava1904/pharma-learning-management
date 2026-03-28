
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharma_lms_flutter/core/client.dart';
import 'package:pharma_lms_flutter/core/file_download.dart';
import '../../../providers/access_review_provider.dart';
import 'access_review_header.dart';
import 'access_review_warning_banner.dart';
import 'access_review_table.dart';
import 'access_review_justification_dialog.dart';
import 'access_review_esignature_dialog.dart';
import 'dart:convert';
import 'dart:typed_data';

/// Vyuh lms admin portal — Access Review screen (scaffold).
///
/// This is the main entry for the Access Review feature, matching the regulatory and UI requirements.

class AccessReviewScreen extends ConsumerWidget {
  final int windowId;
  const AccessReviewScreen({super.key, this.windowId = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  final windowOpen = reviews.isNotEmpty ? reviews.first.windowOpen : DateTime.now();
  final windowClose = reviews.isNotEmpty ? reviews.first.windowClose : DateTime.now();
  final now = DateTime.now();
  final daysLeft = windowClose.difference(now).inDays.clamp(0, 999);
        final pendingAutoRevoke = pending;

        // Map backend data to AccessReviewRowData for table
        final rows = reviews.map((r) => AccessReviewRowData(
          reviewId: r.id ?? 0,
          employeeName: r.user?.firstName ?? 'Unknown',
          employeeId: r.user?.employeeId ?? '',
          deptRole: '${r.user?.department?.name ?? ''}\n${r.user?.jobRole?.name ?? ''}',
          site: r.user?.site?.name ?? '',
          hireDate: r.user?.createdAt != null ? r.user!.createdAt.toIso8601String().split('T').first : '',
          compliancePercent: (r.user?.compliancePercent ?? 100).round(),
          status: r.user?.status ?? '',
          mfaType: r.user?.mfaEnabled == true ? 'MFA' : 'None',
          lastLogin: r.user?.lastLogin != null ? r.user!.lastLogin!.toIso8601String().split('T').first : '',
          loginRisk: '', // Not available in PharmaUser
          avatarUrl: '', // Not available in PharmaUser
          decision: r.decision,
        )).toList();

        Future<void> callRecertify(AccessReviewRowData row, String justification) async {
          if (row.reviewId <= 0) throw Exception('Invalid review id');
          await client.accessReview.recertify(
            reviewId: row.reviewId,
            justification: justification,
          );
        }

        Future<void> callRevoke(AccessReviewRowData row, String justification) async {
          if (row.reviewId <= 0) throw Exception('Invalid review id');
          await client.accessReview.revoke(
            reviewId: row.reviewId,
            justification: justification,
          );
        }

        Future<void> callSignESignature(String password, String reason) async {
          await client.accessReview.signReview(
            windowId: windowId,
            password: password,
            reason: reason,
          );
          final dataUrl = await client.accessReview.exportSignedPdf(windowId: windowId);
          if (!dataUrl.startsWith('data:application/pdf;base64,')) {
            throw Exception('Unexpected export response');
          }
          final b64 = dataUrl.split(',').last;
          final bytes = base64Decode(b64);
          await saveBytesToFile(Uint8List.fromList(bytes), 'access_review_window_$windowId.pdf');
        }

        void onRecertify(AccessReviewRowData row) {
          showDialog(
            context: context,
            builder: (context) => AccessReviewJustificationDialog(
              action: 'Recertify',
              onSubmit: (justification) async {
                await callRecertify(row, justification);
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
                await callRevoke(row, justification);
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
              onSign: (password, reason) async {
                try {
                  await callSignESignature(password, reason);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Review signed and PDF exported')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign/export failed: $e')),
                    );
                  }
                }
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
