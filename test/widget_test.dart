import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TapBack basic widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('TapBack'))),
    );

    expect(find.text('TapBack'), findsOneWidget);
  });
}
