// Basic Flutter widget test for Green Terminal app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:green_terminal/main.dart';

void main() {
  testWidgets('Green Terminal app builds without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GreenTerminalApp());

    // Verify that the app builds without crashing
    await tester.pump();
    
    // Basic checks - the app should load successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
