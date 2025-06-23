import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/app/species/views/widgets/species_dropdown.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'species_dropdown_test.mocks.dart';

final _formKey = GlobalKey<FormState>();
const String key = 'species_dropdown';

Widget createDropdown(
  DatabaseService db,
  SpeciesModel? species,
  Function(SpeciesModel?) onChanged,
  String? Function(SpeciesModel?) onValidate,
) {
  SpeciesDropdown dropdown = SpeciesDropdown(
    key: const Key(key),
    species: species,
    onChanged: onChanged,
    onValidate: onValidate,
  );

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: MaterialApp(
          home: Scaffold(
            body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: dropdown,
            ),
          ),
        ),
      );
    },
  );
}

@GenerateMocks([DatabaseService])
void main() {
  group('Test building dropdown', () {
    testWidgets('show the widget with no species record', (tester) async {
      final databaseService = MockDatabaseService();
      when(
        databaseService.getAllSpeciesTypes(),
      ).thenAnswer((_) => Stream.value([]));

      await tester.pumpWidget(
        createDropdown(databaseService, null, (_) {}, (_) {
          return null;
        }),
      );
      await tester.pumpAndSettle();

      verify(databaseService.getAllSpeciesTypes()).called(1);
      expect(
        find.text("No species found.  Click + to add one"),
        findsOneWidget,
      );
      expect(find.byType(DropdownButtonFormField<SpeciesModel>), findsNothing);
    });
    testWidgets('show the dropdown with species record', (tester) async {
      int speciesId = 5;
      String speciesName = 'new species';

      final databaseService = MockDatabaseService();
      when(databaseService.getAllSpeciesTypes()).thenAnswer(
        (_) => Stream.value([
          SpeciesType(
            speciesId: speciesId,
            name: speciesName,
            userAdded: false,
          ),
        ]),
      );

      await tester.pumpWidget(
        createDropdown(databaseService, null, (_) {}, (_) {
          return null;
        }),
      );
      await tester.pumpAndSettle();

      verify(databaseService.getAllSpeciesTypes()).called(1);
      expect(find.text("Species"), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<SpeciesModel>), findsOneWidget);
    });

    testWidgets('is the species record selectable', (tester) async {
      int speciesId = 5;
      String speciesName = 'new species';
      SpeciesModel? onSelectionChangedValue;
      bool onSelectionChangedCalled = false;

      onSelectionChanged(SpeciesModel? value) {
        onSelectionChangedValue = value;
        onSelectionChangedCalled = true;
      }

      String? onValidate(SpeciesModel? value) => null;

      final databaseService = MockDatabaseService();
      when(databaseService.getAllSpeciesTypes()).thenAnswer(
        (_) => Stream.value([
          SpeciesType(
            speciesId: speciesId,
            name: speciesName,
            userAdded: false,
          ),
        ]),
      );

      await tester.pumpWidget(
        createDropdown(databaseService, null, onSelectionChanged, onValidate),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<SpeciesModel>));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(DropdownMenuItem<SpeciesModel>, speciesName).last,
      );
      await tester.pump();

      expect(onSelectionChangedValue, isNotNull);
      expect(onSelectionChangedValue?.speciesId, equals(speciesId));
      expect(onSelectionChangedCalled, isTrue);
    });

    testWidgets('no item selected fails validation', (tester) async {
      int speciesId = 5;
      String speciesName = 'new species';
      String validationMessage = "failed validation";
      SpeciesModel? onValidateValue;
      bool onValidateCalled = false;

      onSelectionChanged(SpeciesModel? value) => {};
      String? onValidate(SpeciesModel? value) {
        onValidateValue = value;
        onValidateCalled = true;
        return validationMessage;
      }

      final databaseService = MockDatabaseService();
      when(databaseService.getAllSpeciesTypes()).thenAnswer(
        (_) => Stream.value([
          SpeciesType(
            speciesId: speciesId,
            name: speciesName,
            userAdded: false,
          ),
        ]),
      );
      await tester.pumpWidget(
        createDropdown(databaseService, null, onSelectionChanged, onValidate),
      );
      await tester.pumpAndSettle();

      bool isValid = _formKey.currentState!.validate();

      expect(onValidateValue, isNull);
      expect(onValidateCalled, isTrue);
      expect(isValid, isFalse);
    });

    testWidgets('item selected passes validation', (tester) async {
      int speciesId = 5;
      String speciesName = 'new species';
      String validationMessage = "failed validation";
      SpeciesModel? onSelectionChangedValue;
      bool onSelectionChangedCalled = false;
      SpeciesModel? onValidateValue;
      bool onValidateCalled = false;

      onSelectionChanged(SpeciesModel? value) {
        onSelectionChangedValue = value;
        onSelectionChangedCalled = true;
      }

      String? onValidate(SpeciesModel? value) {
        onValidateValue = value;
        onValidateCalled = true;
        return value == null ? validationMessage : null;
      }

      final databaseService = MockDatabaseService();
      when(databaseService.getAllSpeciesTypes()).thenAnswer(
        (_) => Stream.value([
          SpeciesType(
            speciesId: speciesId,
            name: speciesName,
            userAdded: false,
          ),
        ]),
      );
      await tester.pumpWidget(
        createDropdown(databaseService, null, onSelectionChanged, onValidate),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<SpeciesModel>));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(DropdownMenuItem<SpeciesModel>, speciesName).last,
      );
      await tester.pump();

      bool isValid = _formKey.currentState!.validate();

      expect(onSelectionChangedValue, isNotNull);
      expect(onSelectionChangedValue?.speciesId, equals(speciesId));
      expect(onSelectionChangedCalled, isTrue);

      expect(onValidateValue, isNotNull);
      expect(onValidateValue?.speciesId, equals(speciesId));
      expect(onValidateCalled, isTrue);
      expect(isValid, isTrue);
    });

    testWidgets('specified species is pre selected', (tester) async {
      int speciesId1 = 1;
      String speciesName1 = 'new species one';
      int speciesId2 = 2;
      String speciesName2 = 'new species two';
      int speciesId3 = 3;
      String speciesName3 = 'new species three';
      int selectedSpeciesId = 2;

      onSelectionChanged(SpeciesModel? value) {}
      String? onValidate(SpeciesModel? value) => null;

      final databaseService = MockDatabaseService();
      when(databaseService.getAllSpeciesTypes()).thenAnswer(
        (_) => Stream.value([
          SpeciesType(
            speciesId: speciesId1,
            name: speciesName1,
            userAdded: false,
          ),
          SpeciesType(
            speciesId: speciesId2,
            name: speciesName2,
            userAdded: false,
          ),
          SpeciesType(
            speciesId: speciesId3,
            name: speciesName3,
            userAdded: false,
          ),
        ]),
      );
      await tester.pumpWidget(
        createDropdown(
          databaseService,
          SpeciesModel(
            speciesId: selectedSpeciesId,
            name: speciesName2,
            userAdded: false,
          ),
          onSelectionChanged,
          onValidate,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(speciesName2), findsOneWidget);
    });
  });
}
