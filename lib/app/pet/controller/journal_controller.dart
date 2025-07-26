import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/data/database/tables/journal_entry_details.dart';
import 'package:petjournal/data/mapper/journal_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'journal_controller.g.dart';

@riverpod
class JournalController extends _$JournalController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<JournalModel>> build(int petId) {
    return _databaseService
        .getAllJournalEntryDetailsForPet(petId)
        .map((j) => JournalMapper.mapToModelList(j));
  }

  Future<JournalModel?> save(JournalModel journal) async {
    if (journal.journalEntryId == null) {
      final newJournalEntry = await _databaseService.createJournalEntryForPet(
        petIdList: journal.petIdList,
        entryText: journal.entryText,
        tags: journal.tags,
      );

      return newJournalEntry == null
          ? null
          : JournalMapper.mapToModel(
              JournalEntryDetails(
                journalEntry: newJournalEntry,
                pets: journal.petIdList
                    .map(
                      (petId) => PetJournalEntry(
                        journalEntryId: newJournalEntry.journalEntryId,
                        petId: petId,
                      ),
                    )
                    .toList(),
                tags: [],
              ),
            );
    } else {
      await _databaseService.updateJournalEntry(
        id: journal.journalEntryId!,
        entryText: journal.entryText,
        tags: journal.tags,
        petIdList: journal.petIdList,
      );
      return journal;
    }
  }

  Future<int> deleteJournalEntry(int id) {
    return _databaseService.deleteJournalEntry(id);
  }
}
