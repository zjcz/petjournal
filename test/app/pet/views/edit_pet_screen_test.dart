import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/views/edit_pet_screen.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:go_router/go_router.dart';

import 'edit_pet_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;
  late SpeciesModel testSpecies;
  late PetModel testPet;

  /// Creates the EditPetScreen widget wrapped with ProviderScope and router.
  Widget createScreen(MockDatabaseService db, {PetModel? pet}) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: EditPetScreen(pet: pet),
        ),
      ),
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
    mockGoRouter = MockGoRouter();

    testSpecies = const SpeciesModel(
      speciesId: 1,
      name: 'Dog',
      userAdded: false,
    );
    testPet = PetModel(
      petId: 1,
      name: 'Fido',
      breed: 'Labrador',
      colour: 'Black',
      petSex: PetSex.male,
      dob: DateTime(2020, 1, 1),
      dobEstimate: false,
      diet: 'Kibble',
      notes: 'Friendly',
      history: 'Adopted',
      isNeutered: true,
      neuterDate: DateTime(2021, 1, 1),
      status: PetStatus.active,
      statusDate: DateTime.now(),
      species: testSpecies,
      isMicrochipped: true,
      microchipDate: DateTime(2020, 2, 1),
      microchipNotes: 'No issues',
      microchipNumber: '123456',
      microchipCompany: 'PetChipCo',
    );
    // Patch: mockDb.getAllSpeciesTypes returns SpeciesType, not SpeciesModel
    when(mockDb.getAllSpeciesTypes()).thenAnswer(
      (_) => Stream.value([
        SpeciesType(speciesId: 1, name: 'Dog', userAdded: false),
      ]),
    );
  });

  group('EditPetScreen', () {
    testWidgets('renders all required fields for new pet', (tester) async {
      // Arrange + Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Add Pet'), findsOneWidget);
      expect(find.text('Name*'), findsOneWidget);
      expect(find.text('Species*'), findsOneWidget);
      expect(find.text('Breed*'), findsOneWidget);
      expect(find.text('Colour*'), findsOneWidget);
      expect(find.text('Sex*'), findsOneWidget);
      expect(find.text('Current Status*'), findsOneWidget);
      expect(find.text('Health & Care'), findsOneWidget);
      expect(find.text('Microchip Information'), findsOneWidget);
      expect(find.text('Additional Notes'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('shows validation errors when required fields are empty', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Species is required'), findsOneWidget);
      expect(find.text('Breed is required'), findsOneWidget);
      expect(find.text('Colour is required'), findsOneWidget);
      expect(
        find.text('Please correct the errors in the form.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'shows validation errors when required fields linked to optional fields are empty',
      (tester) async {
        // Arrange
        await tester.pumpWidget(createScreen(mockDb));
        await tester.pumpAndSettle();
        // Act
        final neuterCheckboxFinder = find.widgetWithText(
          CheckboxListTile,
          "Is Neutered/Spayed?",
        );
        final microchipCheckboxFinder = find.widgetWithText(
          CheckboxListTile,
          "Is Microchipped?",
        );
        final scrollableFinder = find.byType(Scrollable).last;
        await tester.scrollUntilVisible(
          neuterCheckboxFinder,
          10,
          scrollable: scrollableFinder,
        );
        await tester.tap(neuterCheckboxFinder);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          microchipCheckboxFinder,
          10,
          scrollable: scrollableFinder,
        );
        await tester.tap(microchipCheckboxFinder);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        expect(
          find.text('Neuter date is required if pet is neutered'),
          findsOneWidget,
        );
        expect(
          find.text('Microchip number is required if pet is microchipped'),
          findsOneWidget,
        );
        expect(find.text('Please select a date'), findsOneWidget);
        expect(
          find.text('Please correct the errors in the form.'),
          findsOneWidget,
        );
      },
    );

    testWidgets('saves pet and navigates to view screen on valid input', (
      tester,
    ) async {
      // Arrange
      when(
        mockDb.createPet(
          any,
          any,
          any,
          any,
          any,
          any,
          any,
          any,
          any,
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
      ).thenAnswer((_) async => null);
      // Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(EditPetScreen.petNameKey), 'Buddy');
      await tester.pumpAndSettle();

      // Select species
      await tester.tap(find.byKey(EditPetScreen.petSpeciesKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dog').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(EditPetScreen.petBreedKey), 'Beagle');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(EditPetScreen.petColourKey), 'Brown');
      await tester.pumpAndSettle();

      // Select sex
      await tester.tap(find.byKey(EditPetScreen.petSexKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('male').last);
      await tester.pumpAndSettle();
      // Select status
      await tester.tap(find.byKey(EditPetScreen.petStatusKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Active').last);
      await tester.pumpAndSettle();
      // Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      verify(
        mockDb.createPet(
          any,
          any,
          any,
          any,
          any,
          any,
          any,
          any,
          any,
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
    });

    testWidgets('shows delete button and deletes pet when confirmed', (
      tester,
    ) async {
      // Arrange
      when(mockDb.deletePet(any)).thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(createScreen(mockDb, pet: testPet));
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
      verify(mockDb.deletePet(testPet.petId)).called(1);
      expect(
        find.text('${testPet.name} was removed successfully!'),
        findsOneWidget,
      );
    });

    testWidgets('shows save changes dialog on pop with unsaved changes', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(find.byKey(EditPetScreen.petNameKey), 'Buddy');
      await tester.pumpAndSettle();
      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      await widgetsAppState.didPopRoute();
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Any unsaved changes will be lost!'), findsOneWidget);
    });

    testWidgets('handles API/database errors gracefully', (tester) async {
      // Arrange
      when(mockDb.getAllSpeciesTypes()).thenThrow(Exception('DB error'));
      // Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.textContaining('Error loading data'), findsOneWidget);
    });
  });
}
