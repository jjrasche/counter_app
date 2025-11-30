import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelpers {
  static Future<void> tapIncrementButton(
    WidgetTester tester, {
    int times = 1,
  }) async {
    for (int i = 0; i < times; i++) {
      await tester.tap(find.byKey(const Key('increment-button')));
      await tester.pumpAndSettle();
    }
  }

  static void verifyCounterValue(WidgetTester tester, String expected) {
    expect(find.text(expected), findsOneWidget);
  }
}
