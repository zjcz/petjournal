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
    );
  });

  tearDown(() => database.close());

  group('JournalEntry CRUD Operations', () {
    test(
      'createJournalEntryForPet should create journal entry and link record',
      () async {
        final testText = 'Test Entry';
        final testDate = DateTime(2025, 1, 1);

        // Get the pet ID from the pet created in setUp
        final pet = await database.getPet(1);
        expect(pet, match.isNotNull);

        final journalEntry = await database.createJournalEntryForPet(
          petIdList: [pet!.petId],
          entryText: testText,
          entryDate: testDate,
        );

        expect(journalEntry, match.isNotNull);
        expect(journalEntry?.entryText, equals(testText));
        expect(journalEntry?.entryDate, equals(testDate));

        // Verify entry appears in getAllJournalEntriesForPet
        final entries = await database
            .getAllJournalEntriesForPet(pet.petId)
            .first;
        expect(entries.length, equals(1));
        expect(entries.first.entryText, equals(testText));
      },
    );

    test(
      'createJournalEntryForPet should create journal entry and link multiple records',
      () async {
        final testText = 'Test Entry';
        final testDate = DateTime(2025, 1, 1);

        // Get the pet ID from the pet created in setUp
        final pet1 = await database.getPet(1);
        expect(pet1, match.isNotNull);

        // Create a second pet for linking
        final pet2 = await database.createPet(
          'Rover',
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
        );
        expect(pet2, match.isNotNull);

        final journalEntry = await database.createJournalEntryForPet(
          petIdList: [pet1!.petId, pet2!.petId],
          entryText: testText,
          entryDate: testDate,
        );

        expect(journalEntry, match.isNotNull);
        expect(journalEntry?.entryText, equals(testText));
        expect(journalEntry?.entryDate, equals(testDate));

        // Verify entry appears in getAllJournalEntriesForPet
        final pet1Entries = await database
            .getAllJournalEntriesForPet(pet1.petId)
            .first;
        expect(pet1Entries.length, equals(1));
        expect(pet1Entries.first.entryText, equals(testText));
        final pet2Entries = await database
            .getAllJournalEntriesForPet(pet2.petId)
            .first;
        expect(pet2Entries.length, equals(1));
        expect(pet2Entries.first.entryText, equals(testText));
        expect(pet1Entries.first.journalEntryId, equals(pet2Entries.first.journalEntryId));
      },
    );

    test(
      'getJournalEntry should return null for non-existent record',
      () async {
        final entry = await database.getJournalEntry(999);
        expect(entry, match.isNull);
      },
    );

    test('getJournalEntry should return correct record', () async {
      final testDate = DateTime(2025, 1, 1);
      final pet = await database.getPet(1);

      final created = await database.createJournalEntryForPet(
        petIdList: [pet!.petId],
        entryText: 'Test Entry',
        entryDate: testDate,
      );
      expect(created, match.isNotNull);

      final retrieved = await database.getJournalEntry(created!.journalEntryId);
      expect(retrieved, match.isNotNull);
      expect(retrieved?.entryText, equals('Test Entry'));
      expect(retrieved?.entryDate, equals(testDate));
    });

    test(
      'getAllJournalEntriesForPet should return empty list when no entries exist',
      () async {
        final pet = await database.getPet(1);
        final entries = await database
            .getAllJournalEntriesForPet(pet!.petId)
            .first;
        expect(entries, isEmpty);
      },
    );

    test(
      'getAllJournalEntriesForPet should return all entries for a pet',
      () async {
        final pet = await database.getPet(1);
        final testDate1 = DateTime(2025, 1, 1);
        final testDate2 = DateTime(2025, 1, 2);

        await database.createJournalEntryForPet(
          petIdList: [pet!.petId],
          entryText: 'Entry 1',
          entryDate: testDate1,
        );

        await database.createJournalEntryForPet(
          petIdList: [pet.petId],
          entryText: 'Entry 2',
          entryDate: testDate2,
        );

        final entries = await database
            .getAllJournalEntriesForPet(pet.petId)
            .first;
        expect(entries.length, equals(2));
        // Verify entries are present and dates are correct
        expect(
          entries.map((e) => e.entryDate).toList(),
          containsAll([testDate1, testDate2]),
        );
      },
    );

    test('updateJournalEntry should update all fields correctly', () async {
      final pet = await database.getPet(1);
      final originalDate = DateTime(2025, 1, 1);

      final entry = await database.createJournalEntryForPet(
        petIdList: [pet!.petId],
        entryText: 'Original Text',
        entryDate: originalDate,
      );
      expect(entry, match.isNotNull);

      final newDate = DateTime(2025, 2, 1);
      final updatedCount = await database.updateJournalEntry(
        id: entry!.journalEntryId,
        entryText: 'Updated Text',
        entryDate: newDate,
      );

      expect(updatedCount, equals(1));

      final updated = await database.getJournalEntry(entry.journalEntryId);
      expect(updated?.entryText, equals('Updated Text'));
      expect(updated?.entryDate, equals(newDate));
    });

    test('updateJournalEntry should handle partial updates', () async {
      final pet = await database.getPet(1);
      final originalDate = DateTime(2025, 1, 1);

      final entry = await database.createJournalEntryForPet(
        petIdList: [pet!.petId],
        entryText: 'Original Text',
        entryDate: originalDate,
      );

      // Update only the text
      await database.updateJournalEntry(
        id: entry!.journalEntryId,
        entryText: 'Updated Text',
      );

      final updated = await database.getJournalEntry(entry.journalEntryId);
      expect(updated?.entryText, equals('Updated Text'));
      expect(
        updated?.entryDate,
        equals(originalDate),
      ); // Date should remain unchanged
    });

    test('updateJournalEntry should return 0 for non-existent entry', () async {
      final updatedCount = await database.updateJournalEntry(
        id: 999,
        entryText: 'Test',
        entryDate: DateTime.now(),
      );

      expect(updatedCount, equals(0));
    });

    test('deleteJournalEntry should remove entry and link record', () async {
      final pet = await database.getPet(1);
      final entry = await database.createJournalEntryForPet(
        petIdList: [pet!.petId],
        entryText: 'Test Entry',
        entryDate: DateTime(2025, 1, 1),
      );

      final deletedCount = await database.deleteJournalEntry(
        entry!.journalEntryId,
      );
      expect(deletedCount, equals(1));

      // Verify entry is gone
      final deletedEntry = await database.getJournalEntry(entry.journalEntryId);
      expect(deletedEntry, match.isNull);

      // Verify it's not in the pet's entries anymore
      final entries = await database
          .getAllJournalEntriesForPet(pet.petId)
          .first;
      expect(entries, isEmpty);
    });

    test('deleteJournalEntry should return 0 for non-existent entry', () async {
      final deletedCount = await database.deleteJournalEntry(999);
      expect(deletedCount, equals(0));
    });

    test('watchJournalEntry should emit updates when entry changes', () async {
      final pet = await database.getPet(1);
      final entry = await database.createJournalEntryForPet(
        petIdList: [pet!.petId],
        entryText: 'Original Text',
        entryDate: DateTime(2025, 1, 1),
      );

      final stream = database.watchJournalEntry(entry!.journalEntryId);

      // Verify initial value
      final initialValue = await stream.first;
      expect(initialValue?.entryText, equals('Original Text'));

      // Update the entry
      await database.updateJournalEntry(
        id: entry.journalEntryId,
        entryText: 'Updated Text',
      );

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the update
      final updatedValue = await stream.first;
      expect(updatedValue?.entryText, equals('Updated Text'));
    });
  });
}
