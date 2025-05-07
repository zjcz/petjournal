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

  group('PetMicrochip CRUD Operations', () {
    test('create a new pet microchip record with all fields', () async {
      final testDate = DateTime(2025, 1, 1);
      final testNotes = 'Test Notes';
      final testNumber = '123456789';
      final testCompany = 'Test Company';

      // Get the pet ID from the pet created in setUp
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipDate: testDate,
        microchipNotes: testNotes,
        microchipNumber: testNumber,
        microchipCompany: testCompany,
      );

      expect(petMicrochip, match.isNotNull);
      expect(petMicrochip?.pet, equals(pet.petId));
      expect(petMicrochip?.isMicrochipped, isTrue);
      expect(petMicrochip?.microchipDate, equals(testDate));
      expect(petMicrochip?.microchipNotes, equals(testNotes));
      expect(petMicrochip?.microchipNumber, equals(testNumber));
      expect(petMicrochip?.microchipCompany, equals(testCompany));
    });

    test('create a pet microchip record with minimal fields', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
      );

      expect(petMicrochip, match.isNotNull);
      expect(petMicrochip?.isMicrochipped, isTrue);
      expect(petMicrochip?.microchipDate, match.isNull);
      expect(petMicrochip?.microchipNotes, match.isNull);
      expect(petMicrochip?.microchipNumber, match.isNull);
      expect(petMicrochip?.microchipCompany, match.isNull);
    });

    test('get pet microchip returns null for non-existent record', () async {
      final petMicrochip = await database.getPetMicrochip(999);
      expect(petMicrochip, match.isNull);
    });

    test('get pet microchip returns correct record', () async {
      // First create a pet microchip
      final pet = await database.getPet(1);
      final testDate = DateTime(2025, 1, 1);
      final createdPetMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipDate: testDate,
        microchipNotes: 'Test Notes',
        microchipNumber: '123456789',
        microchipCompany: 'Test Company',
      );

      expect(createdPetMicrochip, match.isNotNull);
      final microchipId = createdPetMicrochip!.petMicrochipId;

      // Now retrieve it and verify
      final retrievedMicrochip = await database.getPetMicrochip(microchipId);
      expect(retrievedMicrochip, match.isNotNull);
      expect(retrievedMicrochip?.isMicrochipped, isTrue);
      expect(retrievedMicrochip?.microchipDate, equals(testDate));
      expect(retrievedMicrochip?.microchipNotes, equals('Test Notes'));
      expect(retrievedMicrochip?.microchipNumber, equals('123456789'));
      expect(retrievedMicrochip?.microchipCompany, equals('Test Company'));
    });

    test(
      'getAllPetMicrochipsForPet returns empty list when no microchips exist',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final microchips =
            await database.getAllPetMicrochipsForPet(pet!.petId).first;
        expect(microchips, isEmpty);
      },
    );

    test(
      'getAllPetMicrochipsForPet returns all microchips for a pet',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        // Create multiple pet microchips
        await database.createPetMicrochip(
          petId: pet!.petId,
          isMicrochipped: true,
          microchipDate: DateTime(2025, 1, 1),
          microchipNotes: 'Notes 1',
          microchipNumber: '123456789',
          microchipCompany: 'Company 1',
        );

        await database.createPetMicrochip(
          petId: pet.petId,
          isMicrochipped: true,
          microchipDate: DateTime(2025, 2, 1),
          microchipNotes: 'Notes 2',
          microchipNumber: '987654321',
          microchipCompany: 'Company 2',
        );

        final microchips =
            await database.getAllPetMicrochipsForPet(pet.petId).first;
        expect(microchips.length, equals(2));
        // Verify they're ordered by microchip date
        expect(microchips[0].microchipDate, equals(DateTime(2025, 1, 1)));
        expect(microchips[1].microchipDate, equals(DateTime(2025, 2, 1)));
      },
    );

    test('update pet microchip updates all fields correctly', () async {
      // First create a pet microchip
      final pet = await database.getPet(1);
      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipDate: DateTime(2025, 1, 1),
        microchipNotes: 'Test Notes',
        microchipNumber: '123456789',
        microchipCompany: 'Test Company',
      );

      expect(petMicrochip, match.isNotNull);
      final microchipId = petMicrochip!.petMicrochipId;

      // Update the pet microchip
      final newDate = DateTime(2025, 5, 1);
      final updatedCount = await database.updatePetMicrochip(
        id: microchipId,
        isMicrochipped: false,
        microchipDate: newDate,
        microchipNotes: 'Updated Notes',
        microchipNumber: '987654321',
        microchipCompany: 'Updated Company',
      );

      expect(updatedCount, equals(1));

      // Verify the update
      final updatedMicrochip = await database.getPetMicrochip(microchipId);
      expect(updatedMicrochip?.isMicrochipped, isFalse);
      expect(updatedMicrochip?.microchipDate, equals(newDate));
      expect(updatedMicrochip?.microchipNotes, equals('Updated Notes'));
      expect(updatedMicrochip?.microchipNumber, equals('987654321'));
      expect(updatedMicrochip?.microchipCompany, equals('Updated Company'));
    });

    test('update returns 0 for non-existent pet microchip', () async {
      final updatedCount = await database.updatePetMicrochip(
        id: 999,
        isMicrochipped: true,
        microchipDate: DateTime(2025, 1, 1),
        microchipNotes: 'Test Notes',
        microchipNumber: '123456789',
        microchipCompany: 'Test Company',
      );

      expect(updatedCount, equals(0));
    });

    test('delete pet microchip removes the correct record', () async {
      // First create a pet microchip
      final pet = await database.getPet(1);
      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipDate: DateTime(2025, 1, 1),
        microchipNotes: 'Test Notes',
        microchipNumber: '123456789',
        microchipCompany: 'Test Company',
      );

      expect(petMicrochip, match.isNotNull);
      final microchipId = petMicrochip!.petMicrochipId;

      // Delete the pet microchip
      final deletedCount = await database.deletePetMicrochip(microchipId);
      expect(deletedCount, equals(1));

      // Verify it's gone
      final deletedMicrochip = await database.getPetMicrochip(microchipId);
      expect(deletedMicrochip, match.isNull);
    });

    test('delete returns 0 for non-existent pet microchip', () async {
      final deletedCount = await database.deletePetMicrochip(999);
      expect(deletedCount, equals(0));
    });

    test(
      'error handling - create with invalid pet ID throws exception',
      () async {
        expect(
          () async => await database.createPetMicrochip(
            petId: 999, // Non-existent pet ID
            isMicrochipped: true,
          ),
          throwsException,
        );
      },
    );

    test('watchPetMicrochip emits updates when microchip changes', () async {
      // First create a pet microchip
      final pet = await database.getPet(1);
      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipNumber: '123456789',
      );

      expect(petMicrochip, match.isNotNull);
      final microchipId = petMicrochip!.petMicrochipId;

      // Start watching the pet microchip
      final stream = database.watchPetMicrochip(microchipId);

      // Collect initial value
      final initialValue = await stream.first;
      expect(initialValue?.microchipNumber, equals('123456789'));

      // Update the pet microchip
      await database.updatePetMicrochip(
        id: microchipId,
        microchipNumber: '987654321',
      );

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the update was emitted
      final updatedValue = await stream.first;
      expect(updatedValue?.microchipNumber, equals('987654321'));
    });

    test('partial update only modifies specified fields', () async {
      // First create a pet microchip with all fields
      final pet = await database.getPet(1);
      final originalDate = DateTime(2025, 1, 1);
      final petMicrochip = await database.createPetMicrochip(
        petId: pet!.petId,
        isMicrochipped: true,
        microchipDate: originalDate,
        microchipNotes: 'Original Notes',
        microchipNumber: '123456789',
        microchipCompany: 'Original Company',
      );

      expect(petMicrochip, match.isNotNull);
      final microchipId = petMicrochip!.petMicrochipId;

      // Update only the microchip number and company
      final updatedCount = await database.updatePetMicrochip(
        id: microchipId,
        microchipNumber: '987654321',
        microchipCompany: 'Updated Company',
      );

      expect(updatedCount, equals(1));

      // Verify only specified fields were updated
      final updatedMicrochip = await database.getPetMicrochip(microchipId);
      expect(updatedMicrochip?.isMicrochipped, isTrue); // Unchanged
      expect(
        updatedMicrochip?.microchipDate,
        equals(originalDate),
      ); // Unchanged
      expect(
        updatedMicrochip?.microchipNotes,
        equals('Original Notes'),
      ); // Unchanged
      expect(updatedMicrochip?.microchipNumber, equals('987654321')); // Changed
      expect(
        updatedMicrochip?.microchipCompany,
        equals('Updated Company'),
      ); // Changed
    });
  });
}
