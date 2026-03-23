import 'package:flutter/material.dart';

class AccessReviewHeader extends StatelessWidget {
  final int totalToReview;
  final int recertified;
  final int revoked;
  final int pending;
  final int daysLeft;
  final double progress;
  final DateTime windowOpen;
  final DateTime windowClose;

  const AccessReviewHeader({
    super.key,
    required this.totalToReview,
    required this.recertified,
    required this.revoked,
    required this.pending,
    required this.daysLeft,
    required this.progress,
    required this.windowOpen,
    required this.windowClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Q1 2026 Privileged Access Review',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            _DaysLeftBadge(daysLeft: daysLeft),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _StatCard(label: 'Total to Review', value: totalToReview.toString()),
            _StatCard(label: 'Recertified', value: recertified.toString()),
            _StatCard(label: 'Revoked', value: revoked.toString()),
            _StatCard(label: 'Pending', value: pending.toString()),
            _ProgressBar(progress: progress),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  const _ProgressBar({required this.progress});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress', style: Theme.of(context).textTheme.labelMedium),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

class _DaysLeftBadge extends StatelessWidget {
  final int daysLeft;
  const _DaysLeftBadge({required this.daysLeft});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$daysLeft Days Left',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
