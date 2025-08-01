import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/data/database/tables/journal_entry_details.dart';

class JournalMapper {
  static JournalModel mapToModel(JournalEntryDetails journalEntryDetail) {
    return JournalModel(
      journalEntryId: journalEntryDetail.journalEntry.journalEntryId,
      createdDateTime: journalEntryDetail.journalEntry.createdDateTime,
      lastUpdatedDateTime: journalEntryDetail.journalEntry.lastUpdatedDateTime,
      entryText: journalEntryDetail.journalEntry.entryText,
      petIdList: journalEntryDetail.pets.map((pet) => pet.petId).toList(),
      tags: journalEntryDetail.tags.map((tag) => tag.tag).toList(),
      linkedRecordId: journalEntryDetail.journalEntry.linkedRecordId,
      linkedRecordType: journalEntryDetail.journalEntry.linkedRecordType,
      linkedRecordTitle: journalEntryDetail.journalEntry.linkedRecordTitle,
    );
  }

  static List<JournalModel> mapToModelList(
    List<JournalEntryDetails> journalEntryDetails,
  ) {
    return journalEntryDetails
        .map((journalEntryDetail) => mapToModel(journalEntryDetail))
        .toList();
  }
}
