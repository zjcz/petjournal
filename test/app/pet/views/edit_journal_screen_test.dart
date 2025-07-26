import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/views/edit_journal_screen.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:go_router/go_router.dart';

import 'edit_pet_med_screen_test.mocks.dart';

@GenerateMocks([DatabaseService, GoRouter])
void main() {
  late MockDatabaseService mockDb;
  late MockGoRouter mockGoRouter;
  late Pet testPet;
  late JournalModel testJournal;

  Widget createScreen(MockDatabaseService db, {JournalModel? journal}) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: EditJournalScreen(petId: 1, journalEntry: journal),
        ),
      ),
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
    mockGoRouter = MockGoRouter();

    testPet = Pet(
      petId: 1,
      name: 'Fido',
      speciesId: 1,
      breed: 'Labrador',
      colour: 'Black',
      sex: PetSex.male.dataValue,
      dob: DateTime(2020, 1, 1),
      dobEstimate: false,
      diet: 'Kibble',
      notes: 'Friendly',
      history: 'Adopted',
      isNeutered: true,
      neuterDate: DateTime(2021, 1, 1),
      status: PetStatus.active.dataValue,
      statusDate: DateTime.now(),
      isMicrochipped: true,
      microchipDate: DateTime(2020, 2, 1),
      microchipNotes: 'No issues',
      microchipNumber: '123456',
      microchipCompany: 'PetChipCo',
    );

    testJournal = JournalModel(
      journalEntryId: 1,
      entryText: 'this is a new entry',
      createdDateTime: DateTime.now(),
      petIdList: [1],
      tags: ['tag1', 'tag2'],
    );

    when(mockDb.getPet(any)).thenAnswer((_) async => testPet);
  });

  group('EditJournalScreen', () {
    testWidgets('renders all required fields for new journal', (tester) async {
      // Arrange + Act
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Journal Entry*'), findsOneWidget);
      expect(find.text('Tags (Optional)'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('shows validation errors when required fields are empty', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(
        find.byKey(EditJournalScreen.journalEntryTextKey),
        '',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('An entry is required'), findsOneWidget);
      expect(
        find.text('Please correct the errors in the form.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'saves journal entry for existing journal and navigates back on valid input',
      (tester) async {
        // Arrange
        when(
          mockDb.updateJournalEntry(
            id: testJournal.journalEntryId,
            entryText: 'An updated entry',
            tags: ['tag100', 'tag200'],
            petIdList: [1],
          ),
        ).thenAnswer((_) async => 1);
        // Act
        await tester.pumpWidget(createScreen(mockDb, journal: testJournal));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditJournalScreen.journalEntryTextKey),
          'An updated entry',
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(EditJournalScreen.journalTagsKey),
          'tag100, tag200',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.updateJournalEntry(
            id: testJournal.journalEntryId,
            entryText: 'An updated entry',
            tags: ['tag100', 'tag200'],
            petIdList: [1],
          ),
        ).called(1);
        verifyNever(
          mockDb.createJournalEntryForPet(
            entryText: 'An updated entry',
            tags: ['tag100', 'tag200'],
            petIdList: [1],
          ),
        );
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets(
      'saves journal entry for new journal and navigates back on valid input',
      (tester) async {
        // Arrange
        when(
          mockDb.createJournalEntryForPet(
            entryText: 'A new entry',
            tags: ['tag1', 'tag2'],
            petIdList: [1],
          ),
        ).thenAnswer(
          (_) async => JournalEntry(
            journalEntryId: 1,
            entryText: 'A new entry',
            createdDateTime: DateTime.now(),
            lastUpdatedDateTime: null,
          ),
        );
        // Act
        await tester.pumpWidget(createScreen(mockDb));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(EditJournalScreen.journalEntryTextKey),
          'A new entry',
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(EditJournalScreen.journalTagsKey),
          'tag1, tag2',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        // Assert
        verify(
          mockDb.createJournalEntryForPet(
            entryText: 'A new entry',
            tags: ['tag1', 'tag2'],
            petIdList: [1],
          ),
        ).called(1);
        verify(mockGoRouter.go(any)).called(1);
      },
    );

    testWidgets('shows delete button and deletes journal when confirmed', (
      tester,
    ) async {
      // Arrange
      when(mockDb.deleteJournalEntry(any)).thenAnswer((_) async => 1);
      // Act
      await tester.pumpWidget(createScreen(mockDb, journal: testJournal));
      await tester.pumpAndSettle();
      final buttonFinder = find.widgetWithText(TextButton, "Delete");
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      // Confirm dialog
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();
      // Assert
      verify(mockDb.deleteJournalEntry(testJournal.journalEntryId)).called(1);
      expect(
        find.text('Journal entry was removed successfully!'),
        findsOneWidget,
      );
      verify(mockGoRouter.go(any)).called(1);
    });

    testWidgets('does not show delete button for add new journal', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(createScreen(mockDb, journal: null));
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('shows save changes dialog on pop with unsaved changes', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createScreen(mockDb));
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(
        find.byKey(EditJournalScreen.journalEntryTextKey),
        'A new entry',
      );
      await tester.pumpAndSettle();
      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      await widgetsAppState.didPopRoute();
      await tester.pumpAndSettle();
      // Assert
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Any unsaved changes will be lost!'), findsOneWidget);
    });
  });
}
