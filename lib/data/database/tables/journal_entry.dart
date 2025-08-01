import 'package:drift/drift.dart';
import 'package:petjournal/constants/linked_record_type.dart';

// Table definition for journalEntry table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get journalEntryId => integer().autoIncrement()();
  TextColumn get entryText => text()();
  DateTimeColumn get createdDateTime =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDateTime => dateTime().nullable()();
  IntColumn get linkedRecordId => integer().nullable()();
  TextColumn get linkedRecordType => textEnum<LinkedRecordType>().nullable()();
  TextColumn get linkedRecordTitle => text().nullable()();
}
