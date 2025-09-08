import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/constants/med_type.dart';
import 'package:petjournal/widgets/med_type_dropdown.dart';

void main() {
  group('MedTypeDropdown Tests', () {
    testWidgets(
      'build should display default label text when no custom label provided',
      (tester) async {
        // Arrange
        var selectedType = MedType.oral;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MedTypeDropdown(
                value: selectedType,
                onChanged: (MedType? type) {
                  selectedType = type ?? selectedType;
                },
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Medication Type'), findsOneWidget);
      },
    );

    testWidgets('build should display custom label text when provided', (
      tester,
    ) async {
      // Arrange
      const customLabel = 'Custom Label';
      var selectedType = MedType.oral;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedTypeDropdown(
              value: selectedType,
              onChanged: (MedType? unit) {
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

    testWidgets('build should display all medication type options', (
      tester,
    ) async {
      // Arrange
      var selectedType = MedType.oral;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedTypeDropdown(
              value: selectedType,
              onChanged: (MedType? type) {
                selectedType = type ?? selectedType;
              },
            ),
          ),
        ),
      );

      // Open the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<MedType>));
      await tester.pumpAndSettle();

      // Assert
      for (final type in MedType.values) {
        // Note - widget contains 2 widgets with the same text - one in the list and one in the dropdown
        // so we use findsWidgets to check for multiple instances
        expect(find.text(type.niceName), findsWidgets);
      }
    });

    testWidgets('onChanged should be called when selecting a new value', (
      tester,
    ) async {
      // Arrange
      var selectedType = MedType.oral;
      MedType? changedType;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedTypeDropdown(
              value: selectedType,
              onChanged: (MedType? type) {
                changedType = type;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(DropdownButtonFormField<MedType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(MedType.injection.niceName));
      await tester.pumpAndSettle();

      // Assert
      expect(changedType, equals(MedType.injection));
    });

    testWidgets('should show current value when initialized', (tester) async {
      // Arrange
      var selectedType = MedType.oral;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedTypeDropdown(value: selectedType, onChanged: (_) {}),
          ),
        ),
      );

      // Assert
      expect(find.text(selectedType.niceName), findsOneWidget);
    });

    testWidgets('validator should be called when saving', (tester) async {
      // Arrange
      final formKey = GlobalKey<FormState>();
      var selectedType = MedType.oral;
      MedType? validatorType;
      bool validationCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: MedTypeDropdown(
                value: selectedType,
                onChanged: (_) {},
                validator: (MedType? type) {
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
      await tester.tap(find.byType(DropdownButtonFormField<MedType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(MedType.injection.niceName));
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(validatorType, equals(MedType.injection));
      expect(validationCalled, isTrue);
      expect(find.text('validation called'), findsOneWidget);
    });
  });
}
