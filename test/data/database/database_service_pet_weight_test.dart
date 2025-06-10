import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;

void main() {
  late DatabaseService database;

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    database = DatabaseService(inMemory);
    // Create a species type that will be used by all tests
    await database
        .into(database.speciesTypes)
        .insert(SpeciesTypesCompanion.insert(name: 'Dog'));

    await database.createPet(
      'Rex',
      1,
      'Mixed',
      'Brown',
      PetSex.male,
      null,
      null,
      null,
      null,
      '',
      '',
      '',
      null,
      null,
      PetStatus.active,
      null,
      null,
      null,
      null,
      null,
    );
  });

  tearDown(() => database.close());

  group('PetWeight CRUD Operations', () {
    test('create a new pet weight record', () async {
      final testDate = DateTime(2025, 1, 1);
      final testWeight = 10.5;
      final testNotes = 'Test Notes';

      // Get the pet ID from the pet created in setUp
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petWeight = await database.createPetWeight(
        pet!.petId,
        testDate,
        testWeight,
        WeightUnits.metric,
        testNotes,
      );

      expect(petWeight, match.isNotNull);
      expect(petWeight?.pet, equals(pet.petId));
      expect(petWeight?.date, equals(testDate));
      expect(petWeight?.weight, equals(testWeight));
      expect(petWeight?.weightUnit, equals(WeightUnits.metric.dataValue));
      expect(petWeight?.notes, equals(testNotes));
    });

    test('create a pet weight record without optional notes', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petWeight = await database.createPetWeight(
        pet!.petId,
        DateTime(2025, 1, 1),
        10.5,
        WeightUnits.metric,
        null,
      );

      expect(petWeight, match.isNotNull);
      expect(petWeight?.notes, match.isNull);
    });

    test('get pet weight returns null for non-existent record', () async {
      final petWeight = await database.getPetWeight(999);
      expect(petWeight, match.isNull);
    });

    test('get pet weight returns correct record', () async {
      // First create a pet weight
      final pet = await database.getPet(1);
      final testDate = DateTime(2025, 1, 1);
      final createdPetWeight = await database.createPetWeight(
        pet!.petId,
        testDate,
        10.5,
        WeightUnits.metric,
        'Test Notes',
      );

      expect(createdPetWeight, match.isNotNull);
      final petWeightId = createdPetWeight!.petWeightId;

      // Now retrieve it and verify
      final retrievedPetWeight = await database.getPetWeight(petWeightId);
      expect(retrievedPetWeight, match.isNotNull);
      expect(retrievedPetWeight?.date, equals(testDate));
      expect(retrievedPetWeight?.weight, equals(10.5));
      expect(
        retrievedPetWeight?.weightUnit,
        equals(WeightUnits.metric.dataValue),
      );
      expect(retrievedPetWeight?.notes, equals('Test Notes'));
    });

    test(
      'getAllPetWeightsForPet returns empty list when no weights exist',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final petWeights =
            await database.getAllPetWeightsForPet(pet!.petId).first;
        expect(petWeights, isEmpty);
      },
    );

    test(
      'getAllPetWeightsForPet returns all weights for a pet sorted by date',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        // Create multiple pet weights with different dates
        await database.createPetWeight(
          pet!.petId,
          DateTime(2025, 1, 1),
          10.5,
          WeightUnits.metric,
          'Notes 1',
        );

        await database.createPetWeight(
          pet.petId,
          DateTime(2025, 2, 1),
          11.0,
          WeightUnits.imperial,
          'Notes 2',
        );

        final petWeights =
            await database.getAllPetWeightsForPet(pet.petId).first;
        expect(petWeights.length, equals(2));
        // Verify they're ordered by date descending
        expect(petWeights[0].date, equals(DateTime(2025, 2, 1)));
        expect(petWeights[1].date, equals(DateTime(2025, 1, 1)));
      },
    );

    test('update pet weight updates all fields correctly', () async {
      // First create a pet weight
      final pet = await database.getPet(1);
      final petWeight = await database.createPetWeight(
        pet!.petId,
        DateTime(2025, 1, 1),
        10.5,
        WeightUnits.metric,
        'Test Notes',
      );

      expect(petWeight, match.isNotNull);
      final petWeightId = petWeight!.petWeightId;

      // Update the pet weight
      final newDate = DateTime(2025, 5, 1);
      final updatedCount = await database.updatePetWeight(
        petWeightId,
        newDate,
        12.0,
        WeightUnits.imperial,
        'Updated Notes',
      );

      expect(updatedCount, equals(1));

      // Verify the update
      final updatedPetWeight = await database.getPetWeight(petWeightId);
      expect(updatedPetWeight?.date, equals(newDate));
      expect(updatedPetWeight?.weight, equals(12.0));
      expect(
        updatedPetWeight?.weightUnit,
        equals(WeightUnits.imperial.dataValue),
      );
      expect(updatedPetWeight?.notes, equals('Updated Notes'));
    });

    test('update returns 0 for non-existent pet weight', () async {
      final updatedCount = await database.updatePetWeight(
        999,
        DateTime(2025, 1, 1),
        10.5,
        WeightUnits.metric,
        'Test Notes',
      );

      expect(updatedCount, equals(0));
    });

    test('delete pet weight removes the correct record', () async {
      // First create a pet weight
      final pet = await database.getPet(1);
      final petWeight = await database.createPetWeight(
        pet!.petId,
        DateTime(2025, 1, 1),
        10.5,
        WeightUnits.metric,
        'Test Notes',
      );

      expect(petWeight, match.isNotNull);
      final petWeightId = petWeight!.petWeightId;

      // Delete the pet weight
      final deletedCount = await database.deletePetWeight(petWeightId);
      expect(deletedCount, equals(1));

      // Verify it's gone
      final deletedPetWeight = await database.getPetWeight(petWeightId);
      expect(deletedPetWeight, match.isNull);
    });

    test('delete returns 0 for non-existent pet weight', () async {
      final deletedCount = await database.deletePetWeight(999);
      expect(deletedCount, equals(0));
    });

    test('watchPetWeight emits updates when pet weight changes', () async {
      // First create a pet weight
      final pet = await database.getPet(1);
      final petWeight = await database.createPetWeight(
        pet!.petId,
        DateTime(2025, 1, 1),
        10.5,
        WeightUnits.metric,
        'Test Notes',
      );

      expect(petWeight, match.isNotNull);
      final petWeightId = petWeight!.petWeightId;

      // Start watching the pet weight
      final stream = database.watchPetWeight(petWeightId);

      // Collect initial value
      final initialValue = await stream.first;
      expect(initialValue?.weight, equals(10.5));
      expect(initialValue?.weightUnit, equals(WeightUnits.metric.dataValue));

      // Update the pet weight
      await database.updatePetWeight(
        petWeightId,
        DateTime(2025, 1, 1),
        12.0,
        WeightUnits.imperial,
        'Updated Notes',
      );

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the update
      final updatedValue = await stream.first;
      expect(updatedValue?.weight, equals(12.0));
      expect(updatedValue?.weightUnit, equals(WeightUnits.imperial.dataValue));
    });
  });
}
