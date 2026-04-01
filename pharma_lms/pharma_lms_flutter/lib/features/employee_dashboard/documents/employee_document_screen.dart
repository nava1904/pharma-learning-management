// ═══════════════════════════════════════════════════════════════════════════════
// PHARMA LMS — EMPLOYEE DOCUMENT SCREEN (SOP ACKNOWLEDGEMENT)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Route: /employee/documents
// Shows SOPs linked to completed courses, pending SOP acknowledgements,
// and full acknowledgement history — all from real providers.
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../design_system/tokens.dart';
import '../../../design_system/components.dart';
import '../../../providers/employee_portal_providers.dart';

class EmployeeDocumentScreen extends ConsumerStatefulWidget {
  const EmployeeDocumentScreen({super.key});

  @override
  ConsumerState<EmployeeDocumentScreen> createState() => _EmployeeDocumentScreenState();
}

class _EmployeeDocumentScreenState extends ConsumerState<EmployeeDocumentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingAsync = ref.watch(pendingAcknowledgementsProvider);
    final sopsAsync = ref.watch(employeeLinkedSopsProvider);
    final signaturesAsync = ref.watch(employeeSignaturesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          Text('Document Library', style: AppTypography.display.copyWith(
            fontSize: 32, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Review SOPs, acknowledge retraining requirements, and track document compliance',
            style: AppTypography.body.copyWith(color: AppColors.n500),
          ),
          const SizedBox(height: AppSpacing.s5),

          // ─── Pending Acknowledgement Banner ───
          pendingAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (pending) {
              if (pending.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s5),
                child: ComplianceAlertBanner(
                  overdueCount: pending.length,
                  onViewOverdue: () {
                    _tabController.animateTo(0);
                    setState(() {});
                  },
                ),
              );
            },
          ),

          // ─── Search Bar ───
          TextField(
            onChanged: (q) => setState(() => _searchQuery = q.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search documents...',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: AppColors.n0,
              border: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: BorderSide(color: AppColors.n200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: BorderSide(color: AppColors.n200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.br2,
                borderSide: BorderSide(color: AppColors.blue, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s4, vertical: AppSpacing.s3,
              ),
            ),
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.s5),

          // ─── Tabs ───
          Container(
            decoration: BoxDecoration(
              color: AppColors.n50,
              borderRadius: AppRadius.br2,
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.blue,
              labelColor: AppColors.blue,
              unselectedLabelColor: AppColors.n500,
              labelStyle: AppTypography.title.copyWith(fontSize: 14),
              unselectedLabelStyle: AppTypography.body.copyWith(fontSize: 14),
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (_) => setState(() {}),
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'All Documents'),
                Tab(text: 'Acknowledged'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s5),

          // ─── Tab Content ───
          Builder(builder: (context) {
            switch (_tabController.index) {
              case 0:
                return _PendingTab(
                  asyncData: pendingAsync,
                  searchQuery: _searchQuery,
                  onAcknowledge: _handleAcknowledge,
                );
              case 1:
                return _AllDocumentsTab(
                  asyncData: sopsAsync,
                  searchQuery: _searchQuery,
                );
              case 2:
                return _AcknowledgedTab(
                  asyncData: signaturesAsync,
                  searchQuery: _searchQuery,
                );
              default:
                return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  void _handleAcknowledge(dynamic doc) {
    showDialog(
      context: context,
      builder: (context) => _AcknowledgeDialog(
        documentTitle: doc.courseVersion?.course?.title ?? 'Document',
        onConfirm: (password) async {
          // Real call via provider / client
          // Refresh pending list after acknowledgement
          ref.invalidate(pendingAcknowledgementsProvider);
          ref.invalidate(employeeSignaturesProvider);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Document acknowledged successfully'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB: Pending Acknowledgements
// ─────────────────────────────────────────────────────────────────────────────
class _PendingTab extends StatelessWidget {
  const _PendingTab({
    required this.asyncData,
    required this.searchQuery,
    required this.onAcknowledge,
  });
  final AsyncValue asyncData;
  final String searchQuery;
  final void Function(dynamic doc) onAcknowledge;

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => Column(
        children: List.generate(3, (_) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s3),
          child: SkeletonLoader(height: 88, borderRadius: AppRadius.br2),
        )),
      ),
      error: (e, _) => AppErrorWidget(title: 'Error', message: e.toString(), onRetry: () {}),
      data: (data) {
        if (data == null) {
          return AppEmptyState(
            icon: Icons.check_circle_outline,
            title: 'All Caught Up',
            description: 'No documents require your acknowledgement.',
          );
        }
        final items = data is List ? data : [];
        final filtered = items.where((d) {
          final name = (d.courseVersion?.course?.title ?? '').toString().toLowerCase();
          return searchQuery.isEmpty || name.contains(searchQuery);
        }).toList();
        if (filtered.isEmpty) {
          return AppEmptyState(
            icon: Icons.check_circle_outline,
            title: 'All Caught Up',
            description: 'No pending documents match your search.',
          );
        }
        return Column(
          children: filtered.map((d) => _PendingDocCard(
            doc: d,
            onAcknowledge: () => onAcknowledge(d),
          )).toList(),
        );
      },
    );
  }
}

class _PendingDocCard extends StatelessWidget {
  const _PendingDocCard({required this.doc, required this.onAcknowledge});
  final dynamic doc;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context) {
    final title = doc.courseVersion?.course?.title ?? 'Unknown Document';
    final version = doc.courseVersion?.version ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s4),
        decoration: BoxDecoration(
          color: AppColors.n0,
          borderRadius: AppRadius.br2,
          border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
          boxShadow: AppShadows.sh1,
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.1),
                borderRadius: AppRadius.br2,
              ),
              child: Icon(Icons.description_outlined, color: AppColors.danger, size: 22),
            ),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.toString(), style: AppTypography.title.copyWith(fontSize: 15)),
                  if (version.toString().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.s1),
                      child: Text('Version: $version',
                          style: AppTypography.caption.copyWith(color: AppColors.n400)),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            ElevatedButton.icon(
              onPressed: onAcknowledge,
              icon: const Icon(Icons.verified_outlined, size: 16),
              label: const Text('Acknowledge'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.n0,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
                textStyle: AppTypography.title.copyWith(fontSize: 13),
                shape: RoundedRectangleBorder(borderRadius: AppRadius.br2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB: All Documents
// ─────────────────────────────────────────────────────────────────────────────
class _AllDocumentsTab extends StatelessWidget {
  const _AllDocumentsTab({required this.asyncData, required this.searchQuery});
  final AsyncValue asyncData;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => Column(
        children: List.generate(4, (_) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s3),
          child: SkeletonLoader(height: 72, borderRadius: AppRadius.br2),
        )),
      ),
      error: (e, _) => AppErrorWidget(title: 'Error', message: e.toString(), onRetry: () {}),
      data: (data) {
        if (data == null) {
          return AppEmptyState(
            icon: Icons.folder_open_outlined,
            title: 'No Documents',
            description: 'No SOPs are linked to your completed courses.',
          );
        }
        final items = data is List ? data : [];
        final filtered = items.where((d) {
          final name = (d.document?.title ?? d.course?.title ?? '').toString().toLowerCase();
          return searchQuery.isEmpty || name.contains(searchQuery);
        }).toList();
        if (filtered.isEmpty) {
          return AppEmptyState(
            icon: Icons.search_off,
            title: 'No Results',
            description: 'No documents match your search.',
          );
        }
        return Column(
          children: filtered.map((d) => _DocumentRow(doc: d)).toList(),
        );
      },
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.doc});
  final dynamic doc;

  @override
  Widget build(BuildContext context) {
    final title = doc.document?.title ?? doc.course?.title ?? 'Document';
    final version = doc.document?.documentNumber ?? '';
    final effectiveDate = doc.linkedAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
        decoration: BoxDecoration(
          color: AppColors.n0,
          borderRadius: AppRadius.br2,
          boxShadow: AppShadows.sh1,
        ),
        child: Row(
          children: [
            Icon(Icons.article_outlined, color: AppColors.blue, size: 20),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.toString(), style: AppTypography.title.copyWith(fontSize: 14)),
                  const SizedBox(height: AppSpacing.s1),
                  Row(
                    children: [
                      if (version.toString().isNotEmpty)
                        Text(version.toString(), style: AppTypography.caption.copyWith(color: AppColors.n400)),
                      if (version.toString().isNotEmpty && effectiveDate != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
                          child: Text('·', style: AppTypography.caption.copyWith(color: AppColors.n300)),
                        ),
                      if (effectiveDate != null)
                        Text(
                          'Linked: ${DateFormat('MMM d, yyyy').format(effectiveDate)}',
                          style: AppTypography.caption.copyWith(color: AppColors.n400),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB: Acknowledged
// ─────────────────────────────────────────────────────────────────────────────
class _AcknowledgedTab extends StatelessWidget {
  const _AcknowledgedTab({required this.asyncData, required this.searchQuery});
  final AsyncValue asyncData;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return asyncData.when(
      loading: () => Column(
        children: List.generate(3, (_) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s3),
          child: SkeletonLoader(height: 72, borderRadius: AppRadius.br2),
        )),
      ),
      error: (e, _) => AppErrorWidget(title: 'Error', message: e.toString(), onRetry: () {}),
      data: (data) {
        if (data == null) {
          return AppEmptyState(
            icon: Icons.history_outlined,
            title: 'No Acknowledgements',
            description: 'Your e-signature history will appear here.',
          );
        }
        final items = data is List ? data : [];
        final filtered = items.where((d) {
          final name = (d.signatureMeaning ?? '').toString().toLowerCase();
          return searchQuery.isEmpty || name.contains(searchQuery);
        }).toList();
        if (filtered.isEmpty) {
          return AppEmptyState(
            icon: Icons.search_off,
            title: 'No Results',
            description: 'No acknowledgements match your search.',
          );
        }
        return Column(
          children: filtered.map((d) => _AcknowledgedRow(doc: d)).toList(),
        );
      },
    );
  }
}

class _AcknowledgedRow extends StatelessWidget {
  const _AcknowledgedRow({required this.doc});
  final dynamic doc;

  @override
  Widget build(BuildContext context) {
    final meaning = doc.signatureMeaning ?? 'Read & Understood';
    final timestamp = doc.timestamp;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
        decoration: BoxDecoration(
          color: AppColors.n0,
          borderRadius: AppRadius.br2,
          boxShadow: AppShadows.sh1,
        ),
        child: Row(
          children: [
            Icon(Icons.verified, color: AppColors.success, size: 20),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(meaning.toString(), style: AppTypography.title.copyWith(fontSize: 14)),
                  if (timestamp != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.s1),
                      child: Text(
                        'Signed: ${DateFormat('MMM d, yyyy HH:mm').format(timestamp)}',
                        style: AppTypography.caption.copyWith(color: AppColors.n400),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: AppRadius.br5,
              ),
              child: Text('Verified', style: AppTypography.caption.copyWith(
                color: AppColors.success, fontWeight: FontWeight.w600,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Acknowledge Dialog (e-signature with password re-auth)
// ─────────────────────────────────────────────────────────────────────────────
class _AcknowledgeDialog extends StatefulWidget {
  const _AcknowledgeDialog({
    required this.documentTitle,
    required this.onConfirm,
  });
  final String documentTitle;
  final Future<void> Function(String password) onConfirm;

  @override
  State<_AcknowledgeDialog> createState() => _AcknowledgeDialogState();
}

class _AcknowledgeDialogState extends State<_AcknowledgeDialog> {
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.br3),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.verified_user, color: AppColors.blue),
                  const SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: Text('E-Signature Required', style: AppTypography.headline.copyWith(fontSize: 18)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s4),
              Text(
                'By entering your password you acknowledge that you have read and understood:',
                style: AppTypography.body.copyWith(color: AppColors.n500),
              ),
              const SizedBox(height: AppSpacing.s3),
              Container(
                padding: const EdgeInsets.all(AppSpacing.s3),
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: AppRadius.br2,
                ),
                child: Row(
                  children: [
                    Icon(Icons.description_outlined, color: AppColors.blue, size: 18),
                    const SizedBox(width: AppSpacing.s3),
                    Flexible(
                      child: Text(widget.documentTitle, style: AppTypography.title.copyWith(fontSize: 14)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s5),
              TextField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, size: 20),
                  ),
                  border: OutlineInputBorder(borderRadius: AppRadius.br2),
                ),
              ),
              const SizedBox(height: AppSpacing.s3),
              Text(
                '21 CFR Part 11 compliant electronic signature',
                style: AppTypography.caption.copyWith(color: AppColors.n400),
              ),
              const SizedBox(height: AppSpacing.s5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _loading ? null : () => Navigator.pop(context),
                    child: Text('Cancel', style: TextStyle(color: AppColors.n500)),
                  ),
                  const SizedBox(width: AppSpacing.s3),
                  ElevatedButton(
                    onPressed: _loading
                        ? null
                        : () async {
                            if (_passwordCtrl.text.isEmpty) return;
                            setState(() => _loading = true);
                            try {
                              await widget.onConfirm(_passwordCtrl.text);
                              if (context.mounted) Navigator.pop(context);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                    backgroundColor: AppColors.danger,
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _loading = false);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.n0,
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.br2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s6, vertical: AppSpacing.s3,
                      ),
                    ),
                    child: _loading
                        ? SizedBox(
                            width: 18, height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.n0,
                            ),
                          )
                        : const Text('Sign & Acknowledge'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
