import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/app/pet/views/edit_pet_vaccination_screen.dart';
import 'package:petjournal/constants/defaults.dart' as defaults;
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:go_router/go_router.dart';

import 'edit_pet_vaccination_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;
  late Pet testPet;
  late PetVaccinationModel testPetVaccination;

  Widget createScreen(
    MockDatabaseService db, {
    PetVaccinationModel? petVaccination,
  }) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: EditPetVaccinationScreen(
            petId: 1,
            petVaccination: petVaccination,
          ),
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
      sex: PetSex.male.dataValue,
      dob: DateTime(2020, 1, 1),
      dobEstimate: false,
      diet: 'Kibble',
      notes: 'Friendly',
      history: 'Adopted',
      isNeutered: true,
      neuterDate: DateTime(2021, 1, 1),
      status: PetStatus.active.dataValue,
      statusDate: DateTime.now(),
      isMicrochipped: true,
      microchipDate: DateTime(2020, 2, 1),
      microchipNotes: 'No issues',
      microchipNumber: '123456',
      microchipCompany: 'PetChipCo',
    );

    testPetVaccination = PetVaccinationModel(
      petVaccinationId: 1,
      petId: 1,
      name: 'Rabies',
      administeredDate: DateTime(2024, 5, 28),
      expiryDate: DateTime(2024, 6, 1),
      reminderDate: null,
      notes: null,
      vaccineBatchNumber: 'batch 123',
      vaccineManufacturer: 'Vaccine Manufacturer',
      administeredBy: 'Dr. Smith',
    );

    when(mockDb.getPet(any)).thenAnswer((_) async => testPet);
    when(mockDb.watchSettings()).thenAnswer(
      (_) => Stream.value(
        Setting(
          settingsId: defaults.defaultSettingsId,
          acceptedTermsAndConditions: true,
          optIntoAnalyticsWarning: true,
          onBoardingComplete: true,
          defaultWeightUnit: WeightUnits.metric.dataValue,
          createLinkedJournalEntries: false,
        ),
      ),
    );
  });

  group('EditPetVaccinationScreen', () {
    testWidgets('renders all required fields for new pet vaccination', (
      tester,
    ) async {
      // Arrange + Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Add Vaccination'), findsOneWidget);
      expect(find.text('Administered Date*'), findsOneWidget);
      expect(find.text('Expiry Date'), findsOneWidget);
      expect(find.text('Reminder Date'), findsOneWidget);
      expect(find.text('Notes (Optional)'), findsOneWidget);
      expect(find.text('Batch Number (Optional)'), findsOneWidget);
      expect(find.text('Manufacturer (Optional)'), findsOneWidget);
      expect(find.text('Administered By (Optional)'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('shows validation errors when required fields are empty', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(
        find.byKey(EditPetVaccinationScreen.petVacNameKey),
        '',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Name is required'), findsOneWidget);
      // Do not test - defaults to today
      //expect(find.text('Please select an administered date'), findsOneWidget);
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
          mockDb.updatePetVaccination(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        ).thenAnswer((_) async => 1);
        // Act
        await tester.pumpWidget(
          createScreen(mockDb, petVaccination: testPetVaccination),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(EditPetVaccinationScreen.petVacAdministeredDateKey),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditPetVaccinationScreen.petVacNameKey),
          'Rabies',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.updatePetVaccination(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        ).called(1);
        verifyNever(
          mockDb.createPetVaccination(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        );
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets(
      'saves pet vaccination for new pet vaccination and navigates back on valid input',
      (tester) async {
        // Arrange
        when(
          mockDb.createPetVaccination(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        ).thenAnswer(
          (_) async => PetVaccination(
            petVaccinationId: 1,
            pet: 1,
            name: 'Rabies',
            administeredDate: DateTime.now(),
            expiryDate: DateTime.now(),
            reminderDate: DateTime.now(),
            notes: null,
            vaccineBatchNumber: '',
            vaccineManufacturer: '',
            administeredBy: '',
          ),
        );
        // Act
        await tester.pumpWidget(createScreen(mockDb));
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(EditPetVaccinationScreen.petVacAdministeredDateKey),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditPetVaccinationScreen.petVacNameKey),
          'Rabies',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.createPetVaccination(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          ),
        ).called(1);
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets('shows delete button and deletes pet vaccination when confirmed', (
      tester,
    ) async {
      // Arrange
      when(mockDb.deletePetVaccination(any)).thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(
        createScreen(mockDb, petVaccination: testPetVaccination),
      );
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
      verify(
        mockDb.deletePetVaccination(testPetVaccination.petVaccinationId!),
      ).called(1);
      expect(
        find.text('Vaccination entry was removed successfully!'),
        findsOneWidget,
      );
      verify(mockGoRouter.go(any)).called(1);
    });

    testWidgets('does not show delete button for add new pet vaccination', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(createScreen(mockDb, petVaccination: null));
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
        find.byKey(EditPetVaccinationScreen.petVacNameKey),
        'Rabies',
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
