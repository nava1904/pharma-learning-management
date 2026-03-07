import 'package:flutter/material.dart';

import 'app_header.dart';

/// App shell wrapping authenticated screens with header.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    this.icon = Icons.school_rounded,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppHeader(title: title, icon: icon),
      body: child,
    );
  }
}
