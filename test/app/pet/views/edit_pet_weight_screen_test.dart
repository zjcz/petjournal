import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/views/edit_pet_weight_screen.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/defaults.dart' as defaults;
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:go_router/go_router.dart';

import 'edit_pet_weight_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;
  late Pet testPet;
  late PetWeightModel testPetWeight;

  Widget createScreen(MockDatabaseService db, {PetWeightModel? petWeight}) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: EditPetWeightScreen(petId: 1, petWeight: petWeight),
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

    testPetWeight = PetWeightModel(
      petWeightId: 1,
      petId: 1,
      date: DateTime(2022, 1, 1),
      weight: 10.5,
      weightUnit: WeightUnits.metric,
      notes: 'Healthy weight',
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

  group('EditPetWeightScreen', () {
    testWidgets('renders all required fields for new pet weight', (tester) async {
      // Arrange + Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Add Weight'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Weight*'), findsOneWidget);
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
      await tester.enterText(find.byKey(EditPetWeightScreen.petWeightWeightKey), '');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
      expect(
        find.text('Please correct the errors in the form.'),
        findsOneWidget,
      );
    });

    testWidgets('saves pet weight for existing pet weight and navigates back on valid input', (
      tester,
    ) async {
      // Arrange
      when(mockDb.updatePetWeight(any, any, any, any, any))
          .thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(createScreen(mockDb, petWeight: testPetWeight));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(EditPetWeightScreen.petWeightDateKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(EditPetWeightScreen.petWeightWeightKey), '12.3');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      verify(mockDb.updatePetWeight(any, any, any, any, any)).called(1);
      verifyNever(mockDb.createPetWeight(any, any, any, any, any));
      verify(mockGoRouter.go(any)).called(1);
    });

    testWidgets('saves pet weight for new pet weight and navigates back on valid input', (
      tester,
    ) async {
      // Arrange
      when(mockDb.createPetWeight(any, any, any, any, any))
          .thenAnswer((_) async => PetWeight(petWeightId: 1, pet: 1, date: DateTime.now(), weight: 12.3, weightUnit: WeightUnits.metric.dataValue));
      // Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(EditPetWeightScreen.petWeightDateKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(EditPetWeightScreen.petWeightWeightKey), '12.3');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      verify(mockDb.createPetWeight(any, any, any, any, any)).called(1);
      verify(mockGoRouter.go(any)).called(1);
    });

    testWidgets('shows delete button and deletes pet weight when confirmed', (
      tester,
    ) async {
      // Arrange
      when(mockDb.deletePetWeight(any)).thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(createScreen(mockDb, petWeight: testPetWeight));
      await tester.pumpAndSettle();
      final buttonFinder = find.widgetWithText(TextButton, "Delete");
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      // Confirm dialog
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();
      // Assert
      verify(mockDb.deletePetWeight(testPetWeight.petWeightId!)).called(1);
      expect(
        find.text('Weight entry was removed successfully!'),
        findsOneWidget,
      );
      verify(mockGoRouter.go(any)).called(1);
    });


    testWidgets('does not show delete button for add new pet weight', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(createScreen(mockDb, petWeight: null));
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
      await tester.enterText(find.byKey(EditPetWeightScreen.petWeightWeightKey), '11.0');
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
