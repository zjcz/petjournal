import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/controller/journal_controller.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/data/database/tables/journal_entry_details.dart';

import '../../../testhelpers/stream_helper.dart';
import 'journal_controller_test.mocks.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
/// Taken from https://riverpod.dev/docs/essentials/testing
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);
  return container;
}

@GenerateMocks([DatabaseService])
void main() {
  group('JournalController Tests', () {
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
    });

    group('build', () {
      testWidgets('Should emit empty list When journals do not exist', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).thenAnswer((_) => Stream.value([]));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final journalList = await container.read(
          journalControllerProvider(1).future,
        );

        // ASSERT
        expect(journalList, isNotNull);
        expect(journalList.length, 0);

        verify(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should emit mapped journal When journals exist', (
        tester,
      ) async {
        // ARRANGE
        final databaseEntry = JournalEntryDetails(
          journalEntry: JournalEntry(
            journalEntryId: 1,
            entryDate: DateTime(2025, 1, 1),
            entryText: 'New Entry',
          ),
          tags: [
            JournalEntryTag(
              journalEntryTagId: 1,
              journalEntryId: 1,
              tag: 'Tag1',
            ),
          ],
          pets: [PetJournalEntry(journalEntryId: 1, petId: 1)],
        );

        when(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).thenAnswer((_) => Stream.value([databaseEntry]));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final journalList = await container.read(
          journalControllerProvider(1).future,
        );

        // ASSERT
        expect(journalList, isNotNull);

        // Verify first journal
        expect(journalList.length, 1);
        expect(journalList[0].journalEntryId, 1);
        expect(journalList[0].entryDate, DateTime(2025, 1, 1));
        expect(journalList[0].entryText, 'New Entry');
        expect(journalList[0].tags, ['Tag1']);
        expect(journalList[0].petIdList, [1]);

        verify(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should handle error When database stream fails', (
        tester,
      ) async {
        // ARRANGE
        when(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).thenAnswer((_) => Stream.error('Database error'));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT & ASSERT
        expect(
          () => container.read(journalControllerProvider(1).future),
          throwsA(isA<String>()),
        );

        verify(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).called(1);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets(
        'Should emit updated journal When database stream emits new values',
        (tester) async {
          // ARRANGE
          final initialJournal = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              entryDate: DateTime(2025, 1, 1),
              entryText: 'New Entry',
            ),
            tags: [],
            pets: [PetJournalEntry(journalEntryId: 1, petId: 1)],
          );

          final updatedJournal = JournalEntryDetails(
            journalEntry: JournalEntry(
              journalEntryId: 1,
              entryDate: DateTime(2025, 1, 1),
              entryText: 'Updated Entry',
            ),
            tags: [],
            pets: [PetJournalEntry(journalEntryId: 1, petId: 1)],
          );

          when(
            mockDatabaseService.getAllJournalEntryDetailsForPet(1),
          ).thenAnswer(
            (_) => streamWithUpdate(
              [initialJournal],
              [updatedJournal],
              const Duration(milliseconds: 100),
            ),
          );

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(mockDatabaseService),
            ],
          );

          // ACT & ASSERT
          final journalSubscription = container.listen(
            journalControllerProvider(1).future,
            (_, __) {},
          );
          var journalList = await journalSubscription.read();
          expect(journalList.length, 1);
          expect(journalList[0].journalEntryId, 1);
          expect(journalList[0].entryText, 'New Entry');

          // wait 100 milliseconds
          await tester.pump(const Duration(milliseconds: 100));

          journalList = await journalSubscription.read();
          expect(journalList.length, 1);
          expect(journalList[0].journalEntryId, 1);
          expect(journalList[0].entryText, 'Updated Entry');

          verify(
            mockDatabaseService.getAllJournalEntryDetailsForPet(1),
          ).called(1);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });

    group('save', () {
      testWidgets('Should call createJournalEntry When journalId is null', (
        tester,
      ) async {
        // ARRANGE
        final initialJournal = JournalEntryDetails(
          journalEntry: JournalEntry(
            journalEntryId: 1,
            entryDate: DateTime(2025, 1, 1),
            entryText: 'New Entry',
          ),
          tags: [
            JournalEntryTag(
              journalEntryTagId: 1,
              journalEntryId: 1,
              tag: 'Tag1',
            ),
          ],
          pets: [PetJournalEntry(journalEntryId: 1, petId: 1)],
        );

        final initialJournalModel = JournalModel(
          journalEntryId: null,
          entryDate: initialJournal.journalEntry.entryDate,
          entryText: initialJournal.journalEntry.entryText,
          tags: [initialJournal.tags[0].tag],
          petIdList: [1],
        );

        when(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).thenAnswer((_) => Stream.empty());
        when(
          mockDatabaseService.createJournalEntryForPet(
            entryText: initialJournalModel.entryText,
            entryDate: initialJournalModel.entryDate,
            petIdList: [1],
          ),
        ).thenAnswer((_) => Future.value(initialJournal.journalEntry));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final provider = container.read(journalControllerProvider(1).notifier);
        JournalModel? savedJournal = await provider.save(initialJournalModel);

        // ASSERT
        expect(savedJournal, isNotNull);
        expect(
          savedJournal!.journalEntryId,
          initialJournal.journalEntry.journalEntryId,
        );
        expect(savedJournal.petIdList, initialJournalModel.petIdList);

        verify(
          mockDatabaseService.createJournalEntryForPet(
            entryText: initialJournalModel.entryText,
            entryDate: initialJournalModel.entryDate,
            petIdList: [1],
          ),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('Should call updateJournalEntry When journalId is not null', (
        tester,
      ) async {
        final initialJournal = JournalEntryDetails(
          journalEntry: JournalEntry(
            journalEntryId: 1,
            entryDate: DateTime(2025, 1, 1),
            entryText: 'New Entry',
          ),
          tags: [
            JournalEntryTag(
              journalEntryTagId: 1,
              journalEntryId: 1,
              tag: 'Tag1',
            ),
          ],
          pets: [PetJournalEntry(journalEntryId: 1, petId: 1)],
        );

        final initialJournalModel = JournalModel(
          journalEntryId: initialJournal.journalEntry.journalEntryId,
          entryDate: initialJournal.journalEntry.entryDate,
          entryText: initialJournal.journalEntry.entryText,
          tags: [initialJournal.tags[0].tag],
          petIdList: [1],
        );

        when(
          mockDatabaseService.getAllJournalEntryDetailsForPet(1),
        ).thenAnswer((_) => Stream.empty());
        when(
          mockDatabaseService.updateJournalEntry(
            id: initialJournalModel.journalEntryId,
            entryText: initialJournalModel.entryText,
            entryDate: initialJournalModel.entryDate,
          ),
        ).thenAnswer((_) => Future.value(1));

        final container = createContainer(
          overrides: [
            DatabaseService.provider.overrideWithValue(mockDatabaseService),
          ],
        );

        // ACT
        final provider = container.read(journalControllerProvider(1).notifier);
        JournalModel? savedJournal = await provider.save(initialJournalModel);

        // ASSERT
        expect(savedJournal, isNotNull);
        expect(
          savedJournal!.journalEntryId,
          initialJournal.journalEntry.journalEntryId,
        );

        verify(
          mockDatabaseService.updateJournalEntry(
            id: initialJournalModel.journalEntryId,
            entryText: initialJournalModel.entryText,
            entryDate: initialJournalModel.entryDate,
          ),
        ).called(1);

        // Workaround for FakeTimer error
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('delete', () {
      testWidgets(
        'Should call deleteJournalEntry When deleteJournalEntry is valid',
        (tester) async {
          int journalEntryId = 123;
          final databaseService = MockDatabaseService();
          when(
            databaseService.deleteJournalEntry(journalEntryId),
          ).thenAnswer((_) async => 1);

          final container = createContainer(
            overrides: [
              DatabaseService.provider.overrideWithValue(databaseService),
            ],
          );
          final provider = container.read(
            journalControllerProvider(1).notifier,
          );
          int result = await provider.deleteJournalEntry(journalEntryId);

          expect(result, 1);
          verify(databaseService.deleteJournalEntry(journalEntryId)).called(1);

          // Workaround for FakeTimer error
          await tester.pumpWidget(Container());
          await tester.pumpAndSettle();
        },
      );
    });
  });
}
