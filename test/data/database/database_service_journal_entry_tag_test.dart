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

    // Create a journal entry that will be used by all tests
    journalEntry =
        (await database.createJournalEntryForPet(
          petIdList: [1],
          entryText: 'Test Entry',
          entryDate: DateTime(2025, 1, 1),
        ))!;
  });

  tearDown(() => database.close());

  group('JournalEntryTag CRUD Operations', () {
    test('createJournalEntryTag should create tag successfully', () async {
      final tag = await database.createJournalEntryTag(
        journalEntryId: journalEntry.journalEntryId,
        tag: 'TestTag',
      );

      expect(tag, match.isNotNull);
      expect(tag?.tag, equals('TestTag'));
      expect(tag?.journalEntryId, equals(journalEntry.journalEntryId));
    });

    test(
      'createJournalEntryTag should throw when journalEntryId does not exist',
      () async {
        expect(
          () => database.createJournalEntryTag(
            journalEntryId: 999,
            tag: 'TestTag',
          ),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'getAllJournalEntryTagsForEntry should return empty list when no tags exist',
      () async {
        final tags =
            await database
                .getAllJournalEntryTagsForEntry(journalEntry.journalEntryId)
                .first;
        expect(tags, isEmpty);
      },
    );

    test(
      'getAllJournalEntryTagsForEntry should return all tags for an entry',
      () async {
        // Create multiple tags
        await database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'Tag1',
        );
        await database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'Tag2',
        );

        final tags =
            await database
                .getAllJournalEntryTagsForEntry(journalEntry.journalEntryId)
                .first;

        expect(tags.length, equals(2));
        expect(tags.map((t) => t.tag).toList(), containsAll(['Tag1', 'Tag2']));
      },
    );

    test(
      'getAllJournalEntryTagsForEntry should return empty list for non-existent entry',
      () async {
        final tags = await database.getAllJournalEntryTagsForEntry(999).first;
        expect(tags, isEmpty);
      },
    );

    test('deleteJournalEntryTag should remove tag successfully', () async {
      final tag = await database.createJournalEntryTag(
        journalEntryId: journalEntry.journalEntryId,
        tag: 'TestTag',
      );

      final deletedCount = await database.deleteJournalEntryTag(
        tag!.journalEntryTagId,
      );
      expect(deletedCount, equals(1));

      // Verify tag is gone
      final tags =
          await database
              .getAllJournalEntryTagsForEntry(journalEntry.journalEntryId)
              .first;
      expect(tags, isEmpty);
    });

    test(
      'deleteJournalEntryTag should return 0 for non-existent tag',
      () async {
        final deletedCount = await database.deleteJournalEntryTag(999);
        expect(deletedCount, equals(0));
      },
    );

    test(
      'journal entry deletion should cascade delete associated tags',
      () async {
        // Create a tag
        await database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'TestTag',
        );

        // Delete the journal entry
        await database.deleteJournalEntry(journalEntry.journalEntryId);

        // Verify tags are gone
        final tags =
            await database
                .getAllJournalEntryTagsForEntry(journalEntry.journalEntryId)
                .first;
        expect(tags, isEmpty);
      },
    );

    test('should handle creating multiple tags simultaneously', () async {
      // Create multiple tags concurrently
      final futures = Future.wait([
        database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'Tag1',
        ),
        database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'Tag2',
        ),
        database.createJournalEntryTag(
          journalEntryId: journalEntry.journalEntryId,
          tag: 'Tag3',
        ),
      ]);

      final tags = await futures;
      expect(tags.length, equals(3));
      expect(tags.every((tag) => tag != null), isTrue);
    });

    test('should handle creating tag with maximum allowed length', () async {
      // Create a tag with a long string (adjust length based on your DB constraints)
      final longTag = 'A' * 255; // Assuming 255 is the max length
      final tag = await database.createJournalEntryTag(
        journalEntryId: journalEntry.journalEntryId,
        tag: longTag,
      );

      expect(tag, match.isNotNull);
      expect(tag?.tag, equals(longTag));
    });

    test('watch stream should emit updates when tags change', () async {
      final stream = database.getAllJournalEntryTagsForEntry(
        journalEntry.journalEntryId,
      );

      // Create a tag
      final tag = await database.createJournalEntryTag(
        journalEntryId: journalEntry.journalEntryId,
        tag: 'TestTag',
      );

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the stream emits the new tag
      final tags = await stream.first;
      expect(tags.length, equals(1));
      expect(tags.first.tag, equals('TestTag'));

      // Delete the tag
      await database.deleteJournalEntryTag(tag!.journalEntryTagId);

      // Wait for the update to propagate
      await pumpEventQueue();

      // Verify the stream emits empty list
      final updatedTags = await stream.first;
      expect(updatedTags, isEmpty);
    });
  });
}
