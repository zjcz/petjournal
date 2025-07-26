import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/database/tables/journal_entry_details.dart';
import 'package:petjournal/data/mapper/journal_mapper.dart';

/// Unit tests for [JournalMapper].
void main() {
  group('JournalMapper', () {
    /// Tests for mapToModel
    group('mapToModel', () {
      test(
        'mapToModel should return correct JournalModel when journalEntryDetails is valid',
        () {
          // Arrange
          final jed = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              createdDateTime: DateTime(2025, 1, 1, 12, 30, 45),
              lastUpdatedDateTime: DateTime(2025, 1, 2, 21, 25, 59),
              entryText: 'New Entry',
            ),
            tags: [
              JournalEntryTag(
                journalEntryTagId: 1,
                journalEntryId: 1,
                tag: 'Tag1',
              ),
              JournalEntryTag(
                journalEntryTagId: 2,
                journalEntryId: 1,
                tag: 'Tag2',
              ),
            ],
            pets: [
              PetJournalEntry(journalEntryId: 1, petId: 1),
              PetJournalEntry(journalEntryId: 1, petId: 2),
            ],
          );

          // Act
          final result = JournalMapper.mapToModel(jed);

          // Assert
          expect(result.journalEntryId, 1);
          expect(result.createdDateTime, DateTime(2025, 1, 1, 12, 30, 45));
          expect(result.lastUpdatedDateTime, DateTime(2025, 1, 2, 21, 25, 59));
          expect(result.entryText, 'New Entry');
          expect(result.petIdList, [1, 2]);
          expect(result.tags, ['Tag1', 'Tag2']);
        },
      );

      test(
        'mapToModel should return correct JournalModel when last updated is null',
        () {
          // Arrange
          final jed = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              createdDateTime: DateTime(2025, 1, 1, 12, 30, 45),
              lastUpdatedDateTime: null,
              entryText: 'New Entry',
            ),
            tags: [
              JournalEntryTag(
                journalEntryTagId: 1,
                journalEntryId: 1,
                tag: 'Tag1',
              ),
              JournalEntryTag(
                journalEntryTagId: 2,
                journalEntryId: 1,
                tag: 'Tag2',
              ),
            ],
            pets: [
              PetJournalEntry(journalEntryId: 1, petId: 1),
              PetJournalEntry(journalEntryId: 1, petId: 2),
            ],
          );

          // Act
          final result = JournalMapper.mapToModel(jed);

          // Assert
          expect(result.journalEntryId, 1);
          expect(result.createdDateTime, DateTime(2025, 1, 1, 12, 30, 45));
          expect(result.lastUpdatedDateTime, null);
          expect(result.entryText, 'New Entry');
          expect(result.petIdList, [1, 2]);
          expect(result.tags, ['Tag1', 'Tag2']);
        },
      );

      test(
        'mapToModel should return correct JournalModel when pet is missing',
        () {
          // Arrange
          final jed = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              createdDateTime: DateTime(2025, 1, 1),
              entryText: 'New Entry',
            ),
            tags: [
              JournalEntryTag(
                journalEntryTagId: 1,
                journalEntryId: 1,
                tag: 'Tag1',
              ),
              JournalEntryTag(
                journalEntryTagId: 2,
                journalEntryId: 1,
                tag: 'Tag2',
              ),
            ],
            pets: [],
          );

          // Act
          final result = JournalMapper.mapToModel(jed);

          // Assert
          expect(result.journalEntryId, 1);
          expect(result.createdDateTime, DateTime(2025, 1, 1));
          expect(result.entryText, 'New Entry');
          expect(result.petIdList, []);
          expect(result.tags, ['Tag1', 'Tag2']);
        },
      );

      test(
        'mapToModel should return correct JournalModel when tag is missing',
        () {
          // Arrange
          final jed = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              createdDateTime: DateTime(2025, 1, 1),
              entryText: 'New Entry',
            ),
            tags: [],
            pets: [
              PetJournalEntry(journalEntryId: 1, petId: 1),
              PetJournalEntry(journalEntryId: 1, petId: 2),
            ],
          );

          // Act
          final result = JournalMapper.mapToModel(jed);

          // Assert
          expect(result.journalEntryId, 1);
          expect(result.createdDateTime, DateTime(2025, 1, 1));
          expect(result.entryText, 'New Entry');
          expect(result.petIdList, [1, 2]);
          expect(result.tags, []);
        },
      );

      /// Tests for mapToModelList
      group('mapToModelList', () {
        test('mapToModelList should return empty list when input is empty', () {
          // Arrange
          final details = <JournalEntryDetails>[];

          // Act
          final result = JournalMapper.mapToModelList(details);

          // Assert
          expect(result, isA<List<JournalModel>>());
          expect(result, isEmpty);
        });

        test(
          'mapToModelList should return correct list when input has multiple JournalEntryDetails objects',
          () {
            // Arrange
            final details = [
              JournalEntryDetails(
                journalEntry: JournalEntry(
                  journalEntryId: 1,
                  createdDateTime: DateTime(2025, 1, 1),
                  entryText: 'New Entry 1',
                ),
                tags: [
                  JournalEntryTag(
                    journalEntryTagId: 1,
                    journalEntryId: 1,
                    tag: 'Tag1',
                  ),
                  JournalEntryTag(
                    journalEntryTagId: 2,
                    journalEntryId: 1,
                    tag: 'Tag2',
                  ),
                ],
                pets: [],
              ),

              JournalEntryDetails(
                journalEntry: JournalEntry(
                  journalEntryId: 2,
                  createdDateTime: DateTime(2025, 1, 1),
                  entryText: 'New Entry 2',
                ),
                tags: [
                  JournalEntryTag(
                    journalEntryTagId: 3,
                    journalEntryId: 2,
                    tag: 'Tag3',
                  ),
                ],
                pets: [],
              ),
            ];

            // Act
            final result = JournalMapper.mapToModelList(details);

            // Assert
            expect(result.length, 2);
            expect(result[0].journalEntryId, 1);
            expect(result[1].journalEntryId, 2);
            expect(result[0].entryText, 'New Entry 1');
            expect(result[1].entryText, 'New Entry 2');
            expect(result[0].tags, ['Tag1', 'Tag2']);
            expect(result[1].tags, ['Tag3']);
          },
        );
      });
    });
  });
}
