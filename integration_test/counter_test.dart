import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart' as app;
import 'helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final scenarios = [
    {'description': 'Fresh start', 'taps': 0, 'expected': '0'},
    {'description': 'Single tap', 'taps': 1, 'expected': '1'},
    {'description': 'Multiple taps', 'taps': 3, 'expected': '3'},
  ];

  for (final scenario in scenarios) {
    testWidgets(scenario['description'] as String, (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final taps = scenario['taps'] as int;
      final expected = scenario['expected'] as String;

      if (taps > 0) {
        await TestHelpers.tapIncrementButton(tester, times: taps);
      }

      TestHelpers.verifyCounterValue(tester, expected);
    });
  }
}
