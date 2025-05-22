import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/widgets/analytics_opt_in.dart';

void main() {
  group('AnalyticsOptIn Tests', () {
    testWidgets('build should display analytics description text', (
      tester,
    ) async {
      // Arrange
      var optInValue = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsOptIn(
              optIntoAnalyticsValue: optInValue,
              onChanged: (bool value) {
                optInValue = value;
              },
            ),
          ),
        ),
      );

      // Assert
      expect(
        find.text(
          'I agree for analytics and crash data to be sent to Google to help improve this application',
        ),
        findsOneWidget,
      );
    });

    testWidgets('build should display switch with correct label', (
      tester,
    ) async {
      // Arrange
      var optInValue = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsOptIn(
              optIntoAnalyticsValue: optInValue,
              onChanged: (bool value) {
                optInValue = value;
              },
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('I agree'), findsOneWidget);
    });

    testWidgets('switch should reflect initial value', (tester) async {
      // Arrange
      const initialValue = true;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsOptIn(
              optIntoAnalyticsValue: initialValue,
              onChanged: (bool value) {},
            ),
          ),
        ),
      );

      // Assert
      final Switch switchWidget = tester.widget(find.byType(Switch));
      expect(switchWidget.value, equals(initialValue));
    });

    testWidgets('onChanged should be called when switch is toggled', (
      tester,
    ) async {
      // Arrange
      var optInValue = false;
      var wasChanged = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsOptIn(
              optIntoAnalyticsValue: optInValue,
              onChanged: (bool value) {
                wasChanged = true;
                optInValue = value;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Assert
      expect(wasChanged, isTrue);
      expect(optInValue, isTrue);
    });
  });
}
