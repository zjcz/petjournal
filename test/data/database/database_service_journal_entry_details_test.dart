import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart' as match;

void main() {
  late DatabaseService database;
  late JournalEntry journalEntry;
  late Pet? pet1;
  late Pet? pet2;

  setUp(() async {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    database = DatabaseService(inMemory);
    // Create a species type that will be used by all tests
    await database
        .into(database.speciesTypes)
        .insert(SpeciesTypesCompanion.insert(name: 'Dog'));

    pet1 = await database.createPet(
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

    pet2 = await database.createPet(
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
  });

  tearDown(() => database.close());

  group('JournalEntryDetails Operations with Pets only', () {
    test(
      'getAllJournalEntryDetailsForPet should return one header and one detail when one pet added',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId],
          entryText: 'Test Entry',
          tags: [],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(1));
        expect(
          records[0].journalEntry.journalEntryId,
          journalEntry.journalEntryId,
        );
        expect(records[0].pets.length, equals(1));
      },
    );

    test(
      'getAllJournalEntryDetailsForPet should return nothing when requesting an invalid petId',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId],
          entryText: 'Test Entry',
          tags: [],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(666)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(0));
      },
    );

    test(
      'getAllJournalEntryDetailsForPet should return same details when two pets added',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId, pet2!.petId],
          entryText: 'Test Entry',
          tags: [],
        ))!;

        // ACT
        final recordForPet1 = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;
        final recordForPet2 = await database
            .getAllJournalEntryDetailsForPet(pet2!.petId)
            .first;

        // ASSERT
        expect(recordForPet1, match.isNotNull);
        expect(recordForPet2, match.isNotNull);
        expect(recordForPet1.length, equals(1));
        expect(recordForPet2.length, equals(1));
        expect(
          recordForPet1[0].journalEntry.journalEntryId,
          journalEntry.journalEntryId,
        );
        expect(
          recordForPet2[0].journalEntry.journalEntryId,
          journalEntry.journalEntryId,
        );
        expect(recordForPet1[0].pets.length, equals(2));
        expect(recordForPet2[0].pets.length, equals(2));
      },
    );

    test(
      'getAllJournalEntryDetailsForPet should return one header and two details when two pets added',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId, pet2!.petId],
          entryText: 'Test Entry',
          tags: [],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(1));
        expect(
          records[0].journalEntry.journalEntryId,
          journalEntry.journalEntryId,
        );
        expect(records[0].pets.length, equals(2));
      },
    );

    test(
      'getAllJournalEntryDetailsForPet should return one header and one details when two header records added',
      () async {
        // ARRANGE
        final journalEntry1 = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId],
          entryText: 'Test Entry 1',
          tags: [],
        ))!;
        final journalEntry2 = (await database.createJournalEntryForPet(
          petIdList: [pet2!.petId],
          entryText: 'Test Entry 2',
          tags: [],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(1));
        expect(records[0].pets.length, equals(1));
        expect(
          records[0].journalEntry.journalEntryId,
          journalEntry1.journalEntryId,
        );
        expect(records[0].journalEntry.entryText, equals('Test Entry 1'));
      },
    );
  });

  group('JournalEntryDetails Operations with Pets and Tags', () {
    test(
      'getAllJournalEntryDetailsForPet should return one header and one detail when one pet and tag added',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId],
          entryText: 'Test Entry',
          tags: ['new tag'],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(1));
        expect(records[0].pets.length, equals(1));
        expect(records[0].tags.length, equals(1));
      },
    );

    test(
      'getAllJournalEntryDetailsForPet should return one pet and two tags when one pet and two tags added',
      () async {
        // ARRANGE
        journalEntry = (await database.createJournalEntryForPet(
          petIdList: [pet1!.petId],
          entryText: 'Test Entry',
          tags: ['new tag 1', 'new tag 2'],
        ))!;

        // ACT
        final records = await database
            .getAllJournalEntryDetailsForPet(pet1!.petId)
            .first;

        // ASSERT
        expect(records, match.isNotNull);
        expect(records.length, equals(1));
        expect(records[0].pets.length, equals(1));
        expect(records[0].tags.length, equals(2));
        expect(records[0].tags[0].tag, equals('new tag 1'));
        expect(records[0].tags[1].tag, equals('new tag 2'));
      },
    );
  });
}
