import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/widgets/weight_units_dropdown.dart';

void main() {
  group('WeightUnitsDropdown Tests', () {
    testWidgets(
      'build should display default label text when no custom label provided',
      (tester) async {
        // Arrange
        var selectedUnit = WeightUnits.metric;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WeightUnitsDropdown(
                value: selectedUnit,
                onChanged: (WeightUnits? unit) {
                  selectedUnit = unit ?? selectedUnit;
                },
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Weight Units'), findsOneWidget);
      },
    );

    testWidgets('build should display custom label text when provided', (
      tester,
    ) async {
      // Arrange
      const customLabel = 'Custom Label';
      var selectedUnit = WeightUnits.metric;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeightUnitsDropdown(
              value: selectedUnit,
              onChanged: (WeightUnits? unit) {
                selectedUnit = unit ?? selectedUnit;
              },
              labelText: customLabel,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(customLabel), findsOneWidget);
    });

    testWidgets('build should display all weight unit options', (tester) async {
      // Arrange
      var selectedUnit = WeightUnits.metric;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeightUnitsDropdown(
              value: selectedUnit,
              onChanged: (WeightUnits? unit) {
                selectedUnit = unit ?? selectedUnit;
              },
            ),
          ),
        ),
      );

      // Open the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<WeightUnits>));
      await tester.pumpAndSettle();

      // Assert
      for (final unit in WeightUnits.values) {
        // Note - widget contains 2 widgets with the same text - one in the list and one in the dropdown
        // so we use findsWidgets to check for multiple instances
        expect(find.text(unit.niceName), findsWidgets);
      }
    });

    testWidgets('onChanged should be called when selecting a new value', (
      tester,
    ) async {
      // Arrange
      var selectedUnit = WeightUnits.metric;
      WeightUnits? changedUnit;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeightUnitsDropdown(
              value: selectedUnit,
              onChanged: (WeightUnits? unit) {
                changedUnit = unit;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(DropdownButtonFormField<WeightUnits>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(WeightUnits.imperial.niceName));
      await tester.pumpAndSettle();

      // Assert
      expect(changedUnit, equals(WeightUnits.imperial));
    });

    testWidgets('should show current value when initialized', (tester) async {
      // Arrange
      final selectedUnit = WeightUnits.metric;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeightUnitsDropdown(
              value: selectedUnit,
              onChanged: (WeightUnits? unit) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(selectedUnit.niceName), findsOneWidget);
    });
  });
}
