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
      null,
    );
  });

  tearDown(() => database.close());

  group('PetVaccination CRUD Operations', () {
    test('create a new pet vaccination record', () async {
      final testName = 'Rabies Vaccine';
      final testAdministeredDate = DateTime(2025, 1, 1);
      final testExpiryDate = DateTime(2026, 1, 1);
      final testReminderDate = DateTime(2025, 12, 1);
      final testNotes = 'Test Notes';
      final testBatchNumber = 'BATCH123';
      final testManufacturer = 'VacCorp';
      final testAdministeredBy = 'Dr. Smith';

      // Get the pet ID from the pet created in setUp
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final vaccination = await database.createPetVaccination(
        pet!.petId,
        testName,
        testAdministeredDate,
        testExpiryDate,
        testReminderDate,
        testNotes,
        testBatchNumber,
        testManufacturer,
        testAdministeredBy,
      );

      expect(vaccination, match.isNotNull);
      expect(vaccination?.pet, equals(pet.petId));
      expect(vaccination?.name, equals(testName));
      expect(vaccination?.administeredDate, equals(testAdministeredDate));
      expect(vaccination?.expiryDate, equals(testExpiryDate));
      expect(vaccination?.reminderDate, equals(testReminderDate));
      expect(vaccination?.notes, equals(testNotes));
      expect(vaccination?.vaccineBatchNumber, equals(testBatchNumber));
      expect(vaccination?.vaccineManufacturer, equals(testManufacturer));
      expect(vaccination?.administeredBy, equals(testAdministeredBy));
    });

    test('create a pet vaccination record without optional notes', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      final vaccination = await database.createPetVaccination(
        pet!.petId,
        'Rabies',
        DateTime(2025, 1, 1),
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 1),
        null,
        'BATCH123',
        'VacCorp',
        'Dr. Smith',
      );

      expect(vaccination, match.isNotNull);
      expect(vaccination?.notes, match.isNull);
    });

        test(
      'create a pet vaccination record without optional expiry date',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final vaccination = await database.createPetVaccination(
          pet!.petId,
          'Rabies',
          DateTime(2025, 1, 1),
          null,
          null,
          'these are new notes',
          'BATCH123',
          'VacCorp',
          'Dr. Smith',
        );

        expect(vaccination, match.isNotNull);
        expect(vaccination?.expiryDate, match.isNull);
      },
    );

    test(
      'create a pet vaccination record without optional reminder date',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final vaccination = await database.createPetVaccination(
          pet!.petId,
          'Rabies',
          DateTime(2025, 1, 1),
          DateTime(2026, 1, 1),
          null,
          'these are new notes',
          'BATCH123',
          'VacCorp',
          'Dr. Smith',
        );

        expect(vaccination, match.isNotNull);
        expect(vaccination?.reminderDate, match.isNull);
      },
    );

    test('get pet vaccination returns null for non-existent record', () async {
      final vaccination = await database.getPetVaccination(999);
      expect(vaccination, match.isNull);
    });

    test('get pet vaccination returns correct record', () async {
      // First create a pet vaccination
      final pet = await database.getPet(1);
      final testAdministeredDate = DateTime(2025, 1, 1);
      final createdVaccination = await database.createPetVaccination(
        pet!.petId,
        'Rabies',
        testAdministeredDate,
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 1),
        'Test Notes',
        'BATCH123',
        'VacCorp',
        'Dr. Smith',
      );

      expect(createdVaccination, match.isNotNull);
      final vaccinationId = createdVaccination!.petVaccinationId;

      // Now retrieve it and verify
      final retrievedVaccination = await database.getPetVaccination(
        vaccinationId,
      );
      expect(retrievedVaccination, match.isNotNull);
      expect(retrievedVaccination?.name, equals('Rabies'));
      expect(
        retrievedVaccination?.administeredDate,
        equals(testAdministeredDate),
      );
      expect(retrievedVaccination?.notes, equals('Test Notes'));
      expect(retrievedVaccination?.vaccineBatchNumber, equals('BATCH123'));
      expect(retrievedVaccination?.vaccineManufacturer, equals('VacCorp'));
      expect(retrievedVaccination?.administeredBy, equals('Dr. Smith'));
    });

    test(
      'getAllPetVaccinationsForPet returns empty list when no vaccinations exist',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final vaccinations = await database
            .getAllPetVaccinationsForPet(pet!.petId)
            .first;
        expect(vaccinations, isEmpty);
      },
    );

    test(
      'getAllPetVaccinationsForPet returns all vaccinations for a pet sorted by name',
      () async {
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        // Create multiple pet vaccinations
        await database.createPetVaccination(
          pet!.petId,
          'Rabies',
          DateTime(2025, 1, 1),
          DateTime(2026, 1, 1),
          DateTime(2025, 12, 1),
          'Notes 1',
          'BATCH1',
          'VacCorp',
          'Dr. Smith',
        );

        await database.createPetVaccination(
          pet.petId,
          'Bordetella',
          DateTime(2025, 2, 1),
          DateTime(2026, 2, 1),
          DateTime(2026, 1, 1),
          'Notes 2',
          'BATCH2',
          'VacCorp',
          'Dr. Jones',
        );

        final vaccinations = await database
            .getAllPetVaccinationsForPet(pet.petId)
            .first;
        expect(vaccinations.length, equals(2));
        // Verify they're ordered by name
        expect(vaccinations[0].name, equals('Bordetella'));
        expect(vaccinations[1].name, equals('Rabies'));
      },
    );

    test('update pet vaccination updates all fields correctly', () async {
      // First create a pet vaccination
      final pet = await database.getPet(1);
      final vaccination = await database.createPetVaccination(
        pet!.petId,
        'Rabies',
        DateTime(2025, 1, 1),
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 1),
        'Test Notes',
        'BATCH1',
        'VacCorp',
        'Dr. Smith',
      );

      expect(vaccination, match.isNotNull);

      // Update values
      final newAdministeredDate = DateTime(2025, 2, 1);
      final newExpiryDate = DateTime(2026, 2, 1);
      final newReminderDate = DateTime(2026, 1, 1);

      // Perform update
      final updateCount = await database.updatePetVaccination(
        vaccination!.petVaccinationId,
        'Updated Rabies',
        newAdministeredDate,
        newExpiryDate,
        newReminderDate,
        'Updated Notes',
        'BATCH2',
        'NewVacCorp',
        'Dr. Jones',
      );

      expect(updateCount, equals(1));

      // Read back the updated vaccination
      final updatedVaccination = await database.getPetVaccination(
        vaccination.petVaccinationId,
      );
      expect(updatedVaccination?.name, equals('Updated Rabies'));
      expect(updatedVaccination?.administeredDate, equals(newAdministeredDate));
      expect(updatedVaccination?.expiryDate, equals(newExpiryDate));
      expect(updatedVaccination?.reminderDate, equals(newReminderDate));
      expect(updatedVaccination?.notes, equals('Updated Notes'));
      expect(updatedVaccination?.vaccineBatchNumber, equals('BATCH2'));
      expect(updatedVaccination?.vaccineManufacturer, equals('NewVacCorp'));
      expect(updatedVaccination?.administeredBy, equals('Dr. Jones'));
    });

    test(
      'update pet vaccination without optional fields updates correctly',
      () async {
        // First create a pet vaccination
        final pet = await database.getPet(1);
        final vaccination = await database.createPetVaccination(
          pet!.petId,
          'Rabies',
          DateTime(2025, 1, 1),
          DateTime(2026, 1, 1),
          DateTime(2025, 12, 1),
          'Test Notes',
          'BATCH1',
          'VacCorp',
          'Dr. Smith',
        );

        expect(vaccination, match.isNotNull);

        // Update values
        final newAdministeredDate = DateTime(2025, 2, 1);
        final newExpiryDate = DateTime(2026, 2, 1);
        final DateTime? newReminderDate = null;
        final String? newNotes = null;

        // Perform update
        final updateCount = await database.updatePetVaccination(
          vaccination!.petVaccinationId,
          'Updated Rabies',
          newAdministeredDate,
          newExpiryDate,
          newReminderDate,
          newNotes,
          'BATCH2',
          'NewVacCorp',
          'Dr. Jones',
        );

        expect(updateCount, equals(1));

        // Read back the updated vaccination
        final updatedVaccination = await database.getPetVaccination(
          vaccination.petVaccinationId,
        );
        expect(updatedVaccination?.name, equals('Updated Rabies'));
        expect(
          updatedVaccination?.administeredDate,
          equals(newAdministeredDate),
        );
        expect(updatedVaccination?.expiryDate, equals(newExpiryDate));
        expect(updatedVaccination?.reminderDate, match.isNull);
        expect(updatedVaccination?.notes, match.isNull);
        expect(updatedVaccination?.vaccineBatchNumber, equals('BATCH2'));
        expect(updatedVaccination?.vaccineManufacturer, equals('NewVacCorp'));
        expect(updatedVaccination?.administeredBy, equals('Dr. Jones'));
      },
    );

    test('update returns 0 for non-existent pet vaccination', () async {
      final updatedCount = await database.updatePetVaccination(
        999,
        'Rabies',
        DateTime(2025, 1, 1),
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 1),
        'Test Notes',
        'BATCH1',
        'VacCorp',
        'Dr. Smith',
      );

      expect(updatedCount, equals(0));
    });

    test('delete pet vaccination removes the correct record', () async {
      // First create a pet vaccination
      final pet = await database.getPet(1);
      final vaccination = await database.createPetVaccination(
        pet!.petId,
        'Rabies',
        DateTime(2025, 1, 1),
        DateTime(2026, 1, 1),
        DateTime(2025, 12, 1),
        'Test Notes',
        'BATCH1',
        'VacCorp',
        'Dr. Smith',
      );

      expect(vaccination, match.isNotNull);
      final vaccinationId = vaccination!.petVaccinationId;

      // Delete the vaccination
      final deletedCount = await database.deletePetVaccination(vaccinationId);
      expect(deletedCount, equals(1));

      // Verify it's gone
      final deletedVaccination = await database.getPetVaccination(
        vaccinationId,
      );
      expect(deletedVaccination, match.isNull);
    });

    test('delete returns 0 for non-existent pet vaccination', () async {
      final deletedCount = await database.deletePetVaccination(999);
      expect(deletedCount, equals(0));
    });

    test(
      'watchPetVaccination emits updates when vaccination changes',
      () async {
        // First create a pet vaccination
        final pet = await database.getPet(1);
        final vaccination = await database.createPetVaccination(
          pet!.petId,
          'Rabies',
          DateTime(2025, 1, 1),
          DateTime(2026, 1, 1),
          DateTime(2025, 12, 1),
          'Test Notes',
          'BATCH1',
          'VacCorp',
          'Dr. Smith',
        );

        expect(vaccination, match.isNotNull);
        final vaccinationId = vaccination!.petVaccinationId;

        // Start watching the vaccination and collect emissions
        final emissions = <PetVaccination?>[];
        final subscription = database
            .watchPetVaccination(vaccinationId)
            .listen(emissions.add);

        // Wait for the first emission
        await Future<void>.delayed(const Duration(milliseconds: 100));
        expect(emissions.length, equals(1));
        expect(emissions.first?.name, equals('Rabies'));

        // Update the vaccination
        await database.updatePetVaccination(
          vaccinationId,
          'Updated Rabies',
          DateTime(2025, 2, 1),
          DateTime(2026, 2, 1),
          DateTime(2026, 1, 1),
          'Updated Notes',
          'BATCH2',
          'NewVacCorp',
          'Dr. Jones',
        );

        // Wait for the update emission
        await Future<void>.delayed(const Duration(milliseconds: 100));
        expect(emissions.length, equals(2));
        expect(emissions.last?.name, equals('Updated Rabies'));

        // Clean up
        await subscription.cancel();
      },
    );

    test('create pet vaccination throws exception with invalid data', () async {
      final pet = await database.getPet(1);
      expect(pet, match.isNotNull);

      expect(
        () => database.createPetVaccination(
          999, // Non-existent pet ID
          'Rabies',
          DateTime(2025, 1, 1),
          DateTime(2026, 1, 1),
          DateTime(2025, 12, 1),
          'Test Notes',
          'BATCH1',
          'VacCorp',
          'Dr. Smith',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
