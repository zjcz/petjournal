import 'package:drift/drift.dart';
import 'package:petjournal/data/database/tables/journal_entry.dart';

class JournalEntryTags extends Table {
  IntColumn get journalEntryTagId => integer().autoIncrement()();
  IntColumn get journalEntryId =>
      integer().references(
        JournalEntries,
        #journalEntryId,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get tag => text().withLength(min: 1, max: 255)();
}
