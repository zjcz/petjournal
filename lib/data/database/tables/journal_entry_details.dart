import 'package:petjournal/data/database/database_service.dart';

class JournalEntryDetails {
  final JournalEntry journalEntry;
  final List<JournalEntryTag> tags;
  final List<PetJournalEntry> pets;

  JournalEntryDetails({
    required this.journalEntry,
    required this.tags,
    required this.pets,
  });
}
