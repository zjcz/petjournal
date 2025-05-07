import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
    );
  });

  tearDown(() => database.close());

  group('PetMed CRUD Operations', () {
    test('create a new pet med record', () async {
      final testName = 'Test Med';
      final testDose = '10mg';
      final testStartDate = DateTime(2025, 1, 1);
      final testEndDate = DateTime(2025, 12, 31);
      final testNotes = 'Test Notes';

      // Get the pet ID from the pet created in setUp
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petMed = await database.createPetMed(
        pet!.petId,
        testName,
        testDose,
        testStartDate,
        testEndDate,
        testNotes,
      );

      expect(petMed, match.isNotNull);
      expect(petMed?.pet, equals(pet.petId));
      expect(petMed?.name, equals(testName));
      expect(petMed?.dose, equals(testDose));
      expect(petMed?.startDate, equals(testStartDate));
      expect(petMed?.endDate, equals(testEndDate));
      expect(petMed?.notes, equals(testNotes));
    });

    test('create a pet med record without optional end date', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petMed = await database.createPetMed(
        pet!.petId,
        'Test Med',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Test Notes',
      );

      expect(petMed, match.isNotNull);
      expect(petMed?.endDate, match.isNull);
    });

    test('get pet med returns null for non-existent record', () async {
      final petMed = await database.getPetMed(999);
      expect(petMed, match.isNull);
    });

    test('get pet med returns correct record', () async {
      // First create a pet med
      final pet = await database.getPet(1);
      final testStartDate = DateTime(2025, 1, 1);
      final createdPetMed = await database.createPetMed(
        pet!.petId,
        'Test Med',
        '10mg',
        testStartDate,
        null,
        'Test Notes',
      );

      expect(createdPetMed, match.isNotNull);
      final petMedId = createdPetMed!.petMedId;

      // Now retrieve it and verify
      final retrievedPetMed = await database.getPetMed(petMedId);
      expect(retrievedPetMed, match.isNotNull);
      expect(retrievedPetMed?.name, equals('Test Med'));
      expect(retrievedPetMed?.dose, equals('10mg'));
      expect(retrievedPetMed?.startDate, equals(testStartDate));
      expect(retrievedPetMed?.notes, equals('Test Notes'));
    });

    test('getAllPetMedsForPet returns empty list when no meds exist', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petMeds = await database.getAllPetMedsForPet(pet!.petId).first;
      expect(petMeds, isEmpty);
    });

    test('getAllPetMedsForPet returns all meds for a pet', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      // Create multiple pet meds
      await database.createPetMed(
        pet!.petId,
        'Med 1',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Notes 1',
      );

      await database.createPetMed(
        pet.petId,
        'Med 2',
        '20mg',
        DateTime(2025, 2, 1),
        DateTime(2025, 12, 31),
        'Notes 2',
      );

      final petMeds = await database.getAllPetMedsForPet(pet.petId).first;
      expect(petMeds.length, equals(2));
      // Verify they're ordered by name
      expect(petMeds[0].name, equals('Med 1'));
      expect(petMeds[1].name, equals('Med 2'));
    });

    test('update pet med updates all fields correctly', () async {
      // First create a pet med
      final pet = await database.getPet(1);
      final petMed = await database.createPetMed(
        pet!.petId,
        'Test Med',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Test Notes',
      );

      expect(petMed, match.isNotNull);
      final petMedId = petMed!.petMedId;

      // Update the pet med
      final newStartDate = DateTime(2025, 5, 1);
      final newEndDate = DateTime(2025, 12, 31);
      final updatedCount = await database.updatePetMed(
        petMedId,
        'Updated Med',
        '20mg',
        newStartDate,
        newEndDate,
        'Updated Notes',
      );

      expect(updatedCount, equals(1));

      // Verify the update
      final updatedPetMed = await database.getPetMed(petMedId);
      expect(updatedPetMed?.name, equals('Updated Med'));
      expect(updatedPetMed?.dose, equals('20mg'));
      expect(updatedPetMed?.startDate, equals(newStartDate));
      expect(updatedPetMed?.endDate, equals(newEndDate));
      expect(updatedPetMed?.notes, equals('Updated Notes'));
    });

    test('update returns 0 for non-existent pet med', () async {
      final updatedCount = await database.updatePetMed(
        999,
        'Test Med',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Test Notes',
      );

      expect(updatedCount, equals(0));
    });

    test('delete pet med removes the correct record', () async {
      // First create a pet med
      final pet = await database.getPet(1);
      final petMed = await database.createPetMed(
        pet!.petId,
        'Test Med',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Test Notes',
      );

      expect(petMed, match.isNotNull);
      final petMedId = petMed!.petMedId;

      // Delete the pet med
      final deletedCount = await database.deletePetMed(petMedId);
      expect(deletedCount, equals(1));

      // Verify it's gone
      final deletedPetMed = await database.getPetMed(petMedId);
      expect(deletedPetMed, match.isNull);
    });

    test('delete returns 0 for non-existent pet med', () async {
      final deletedCount = await database.deletePetMed(999);
      expect(deletedCount, equals(0));
    });

    test('watchPetMed emits updates when pet med changes', () async {
      // First create a pet med
      final pet = await database.getPet(1);
      final petMed = await database.createPetMed(
        pet!.petId,
        'Test Med',
        '10mg',
        DateTime(2025, 1, 1),
        null,
        'Test Notes',
      );

      expect(petMed, match.isNotNull);
      final petMedId = petMed!.petMedId;

      // Start watching the pet med and collect emissions
      final stream = database.watchPetMed(petMedId);

      // Collect initial value
      final initialValue = await stream.first;
      expect(initialValue?.name, equals('Test Med'));
      expect(initialValue?.dose, equals('10mg'));

      // Update the pet med
      await database.updatePetMed(
        petMedId,
        'Updated Med',
        '20mg',
        DateTime(2025, 1, 1),
        null,
        'Updated Notes',
      );

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the update
      final updatedValue = await stream.first;
      expect(updatedValue?.name, equals('Updated Med'));
      expect(updatedValue?.dose, equals('20mg'));
    });
  });
}
