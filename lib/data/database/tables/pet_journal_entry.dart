import 'package:drift/drift.dart';
import 'package:petjournal/data/database/tables/pet.dart';
import 'package:petjournal/data/database/tables/journal_entry.dart';

// Table definition for linking pets and journal entries
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('PetJournalEntry')
class PetJournalEntries extends Table {
  IntColumn get petId => 
      integer().references(Pets, #petId, onDelete: KeyAction.cascade)();
  IntColumn get journalEntryId => 
      integer().references(JournalEntries, #journalEntryId, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {petId, journalEntryId};
}