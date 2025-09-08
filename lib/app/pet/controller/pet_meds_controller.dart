import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/data/mapper/pet_med_mapper.dart';
import 'package:petjournal/helpers/settings_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_meds_controller.g.dart';

@riverpod
class PetMedsController extends _$PetMedsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetMedModel>?> build(int petId) {
    return _databaseService
        .getAllPetMedsForPet(petId)
        .map((p) => PetMedMapper.mapToModelList(p));
  }

  Future<PetMedModel?> save(PetMedModel petMed) async {
    if (petMed.petMedId == null) {
      final newPetMed = await _databaseService.createPetMed(
        petMed.petId,
        petMed.name,
        petMed.dose,
        petMed.startDate,
        petMed.endDate,
        petMed.notes,
      );

      // create linked journal entry if required
      if (newPetMed == null) return null;
      final newPetMedModel = PetMedMapper.mapToModel(newPetMed);
      await _createLinkedJournalEntry(newPetMedModel);
      return newPetMedModel;
    } else {
      await _databaseService.updatePetMed(
        petMed.petMedId!,
        petMed.name,
        petMed.dose,
        petMed.startDate,
        petMed.endDate,
        petMed.notes,
      );

      await _createLinkedJournalEntry(petMed, createNew: false);

      return petMed;
    }
  }

  Future<int> deletePetMed(int id) {
    return _databaseService.deletePetMed(id);
  }

  /// If required, create / update the linked journal entry
  Future<void> _createLinkedJournalEntry(
    PetMedModel petMed, {
    bool createNew = true,
  }) async {
    if (SettingsHelper.createLinkedJournalEntries()) {
      if (createNew) {
        await _databaseService.createJournalEntryForPet(
          entryText: petMed.notes ?? '',
          petIdList: [petMed.petId],
          tags: [],
          linkedRecordId: petMed.petMedId,
          linkedRecordType: LinkedRecordType.medication,
          linkedRecordTitle: 'Medication ${petMed.name} prescribed',
        );
      } else {
        await _databaseService.updateLinkedJournalEntry(
          linkedRecordId: petMed.petMedId!,
          linkedRecordType: LinkedRecordType.medication,
          linkedRecordTitle: 'Medication ${petMed.name} prescribed (updated)',
        );
      }
    }
  }
}
