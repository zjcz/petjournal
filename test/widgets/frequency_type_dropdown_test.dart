import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/constants/frequency_type.dart';
import 'package:petjournal/widgets/frequency_type_dropdown.dart';

void main() {
  group('FrequencyTypeDropdown Tests', () {
    testWidgets(
      'build should display default label text when no custom label provided',
      (tester) async {
        // Arrange
        var selectedType = FrequencyType.daily;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FrequencyTypeDropdown(
                value: selectedType,
                onChanged: (FrequencyType? type) {
                  selectedType = type ?? selectedType;
                },
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Frequency Type'), findsOneWidget);
      },
    );

    testWidgets('build should display custom label text when provided', (
      tester,
    ) async {
      // Arrange
      const customLabel = 'Custom Label';
      var selectedType = FrequencyType.daily;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrequencyTypeDropdown(
              value: selectedType,
              onChanged: (FrequencyType? unit) {
                selectedType = unit ?? selectedType;
              },
              labelText: customLabel,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(customLabel), findsOneWidget);
    });

    testWidgets('build should display all frequency type options', (
      tester,
    ) async {
      // Arrange
      var selectedType = FrequencyType.daily;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrequencyTypeDropdown(
              value: selectedType,
              onChanged: (FrequencyType? type) {
                selectedType = type ?? selectedType;
              },
            ),
          ),
        ),
      );

      // Open the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<FrequencyType>));
      await tester.pumpAndSettle();

      // Assert
      for (final type in FrequencyType.values) {
        // Note - widget contains 2 widgets with the same text - one in the list and one in the dropdown
        // so we use findsWidgets to check for multiple instances
        expect(find.text(type.niceName), findsWidgets);
      }
    });

    testWidgets('onChanged should be called when selecting a new value', (
      tester,
    ) async {
      // Arrange
      var selectedType = FrequencyType.daily;
      FrequencyType? changedType;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrequencyTypeDropdown(
              value: selectedType,
              onChanged: (FrequencyType? type) {
                changedType = type;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(DropdownButtonFormField<FrequencyType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(FrequencyType.weekly.niceName));
      await tester.pumpAndSettle();

      // Assert
      expect(changedType, equals(FrequencyType.weekly));
    });

    testWidgets('should show current value when initialized', (tester) async {
      // Arrange
      var selectedType = FrequencyType.monthly;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FrequencyTypeDropdown(value: selectedType, onChanged: (_) {}),
          ),
        ),
      );

      // Assert
      expect(find.text(selectedType.niceName), findsOneWidget);
    });

    testWidgets('validator should be called when saving', (tester) async {
      // Arrange
      final formKey = GlobalKey<FormState>();
      var selectedType = FrequencyType.monthly;
      FrequencyType? validatorType;
      bool validationCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: FrequencyTypeDropdown(
                value: selectedType,
                onChanged: (_) {},
                validator: (FrequencyType? type) {
                  validatorType = type;
                  validationCalled = true;
                  return 'validation called';
                },
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(DropdownButtonFormField<FrequencyType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(FrequencyType.weekly.niceName));
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(validatorType, equals(FrequencyType.weekly));
      expect(validationCalled, isTrue);
      expect(find.text('validation called'), findsOneWidget);
    });
  });
}
