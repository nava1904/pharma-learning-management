// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pharma_lms_flutter/main.dart';

void main() {
  testWidgets('App has no directionality or overflow errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          child: PharmaLmsApp(), // Use your actual app widget
        ),
      ),
    );
    // ...existing test code...
  });
}
