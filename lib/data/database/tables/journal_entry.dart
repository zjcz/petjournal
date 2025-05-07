import 'package:drift/drift.dart';

// Table definition for journalEntry table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get journalEntryId => integer().autoIncrement()();
  TextColumn get entryText => text().nullable()();
  DateTimeColumn get entryDate => dateTime().withDefault(currentDateAndTime)();
}
