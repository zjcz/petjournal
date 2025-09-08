import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/views/edit_pet_med_screen.dart';
import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/app/settings/models/settings_model.dart';
import 'package:petjournal/constants/frequency_type.dart';
import 'package:petjournal/constants/med_type.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/data/lookups/settings_lookup.dart';

import 'edit_pet_med_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;
  late Pet testPet;
  late PetMedModel testPetMed;

  Widget createScreen(MockDatabaseService db, {PetMedModel? petMed}) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: EditPetMedScreen(petId: 1, petMed: petMed),
        ),
      ),
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
    mockGoRouter = MockGoRouter();

    testPet = Pet(
      petId: 1,
      name: 'Fido',
      speciesId: 1,
      breed: 'Labrador',
      colour: 'Black',
      sex: PetSex.male,
      dob: DateTime(2020, 1, 1),
      dobEstimate: false,
      diet: 'Kibble',
      notes: 'Friendly',
      history: 'Adopted',
      isNeutered: true,
      neuterDate: DateTime(2021, 1, 1),
      status: PetStatus.active,
      statusDate: DateTime.now(),
      isMicrochipped: true,
      microchipDate: DateTime(2020, 2, 1),
      microchipNotes: 'No issues',
      microchipNumber: '123456',
      microchipCompany: 'PetChipCo',
    );

    testPetMed = PetMedModel(
      petMedId: 1,
      petId: 1,
      name: 'Antibiotic',
      frequency: 1,
      frequencyType: FrequencyType.daily,
      doseUnit: 1.5,
      medType: MedType.oral,
      startDate: DateTime(2024, 5, 28),
      endDate: DateTime(2024, 6, 1),
      notes: 'Take with food',
    );

    when(mockDb.getPet(any)).thenAnswer((_) async => testPet);

    SettingsLookup().refreshSettings(
      SettingsModel(
        lastUsedVersion: '1.0.0',
        acceptedTermsAndConditions: true,
        optIntoAnalyticsWarning: true,
        onBoardingComplete: true,
        defaultWeightUnit: WeightUnits.metric,
        createLinkedJournalEntries: false,
      ),
    );
  });

  group('EditPetMedScreen', () {
    testWidgets('renders all required fields for new pet med', (tester) async {
      // Arrange + Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Add Medication'), findsOneWidget);
      expect(find.text('Name*'), findsOneWidget);
      expect(find.text('Frequency*'), findsOneWidget);
      expect(find.text('Frequency Type*'), findsOneWidget);
      expect(find.text('Dose*'), findsOneWidget);
      expect(find.text('Medication Type*'), findsOneWidget);
      expect(find.text('Start Date*'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
      expect(find.text('Notes (Optional)'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('shows validation errors when required fields are empty', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(find.byKey(EditPetMedScreen.petMedNameKey), '');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Dose is required'), findsOneWidget);
      expect(find.text('Frequency is required'), findsOneWidget);
      expect(find.text('Frequency Type is required'), findsOneWidget);
      expect(find.text('Medication Type is required'), findsOneWidget);
      expect(
        find.text('Please correct the errors in the form.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'saves pet note for existing pet note and navigates back on valid input',
      (tester) async {
        // Arrange
        when(
          mockDb.updatePetMed(any, any, any, any, any, any, any, any, any),
        ).thenAnswer((_) async => 1);
        // Act
        await tester.pumpWidget(createScreen(mockDb, petMed: testPetMed));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(EditPetMedScreen.petMedStartDateKey));
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditPetMedScreen.petMedNameKey),
          'Antibiotics',
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(EditPetMedScreen.petMedDoseKey),
          '12.3',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.updatePetMed(any, any, any, any, any, any, any, any, any),
        ).called(1);
        verifyNever(
          mockDb.createPetMed(any, any, any, any, any, any, any, any, any),
        );
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets(
      'saves pet med for new pet med and navigates back on valid input',
      (tester) async {
        // Arrange
        when(
          mockDb.createPetMed(any, any, any, any, any, any, any, any, any),
        ).thenAnswer(
          (_) async => PetMed(
            petMedId: 1,
            pet: 1,
            name: 'Antibiotic',
            frequency: 1,
            frequencyType: FrequencyType.daily,
            doseUnit: 1.5,
            medType: MedType.oral,
            startDate: DateTime.now(),
          ),
        );
        // Act
        await tester.pumpWidget(createScreen(mockDb));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(EditPetMedScreen.petMedStartDateKey));
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditPetMedScreen.petMedNameKey),
          'Antibiotics',
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(EditPetMedScreen.petMedFreqKey), '1');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(DropdownButtonFormField<FrequencyType>));
        await tester.pumpAndSettle();
        await tester.tap(find.text(FrequencyType.daily.niceName));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditPetMedScreen.petMedDoseKey),
          '1.5',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(DropdownButtonFormField<MedType>));
        await tester.pumpAndSettle();
        await tester.tap(find.text(MedType.oral.niceName));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.createPetMed(any, any, any, any, any, any, any, any, any),
        ).called(1);
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets('shows delete button and deletes pet med when confirmed', (
      tester,
    ) async {
      // Arrange
      when(mockDb.deletePetMed(any)).thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(createScreen(mockDb, petMed: testPetMed));
      await tester.pumpAndSettle();
      final buttonFinder = find.widgetWithText(TextButton, "Delete");
      final scrollableFinder = find.byType(Scrollable).last;
      await tester.scrollUntilVisible(
        buttonFinder,
        10,
        scrollable: scrollableFinder,
      );
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      // Confirm dialog
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();
      // Assert
      verify(mockDb.deletePetMed(testPetMed.petMedId!)).called(1);
      expect(
        find.text('Medication entry was removed successfully!'),
        findsOneWidget,
      );
      verify(mockGoRouter.go(any)).called(1);
    });

    testWidgets('does not show delete button for add new pet med', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(createScreen(mockDb, petMed: null));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('shows save changes dialog on pop with unsaved changes', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(
        find.byKey(EditPetMedScreen.petMedNameKey),
        'Antibiotic',
      );
      await tester.pumpAndSettle();
      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      await widgetsAppState.didPopRoute();
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Any unsaved changes will be lost!'), findsOneWidget);
    });
  });
}
