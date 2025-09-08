import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/data/mapper/pet_vaccination_mapper.dart';
import 'package:petjournal/helpers/settings_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_vaccinations_controller.g.dart';

@riverpod
class PetVaccinationsController extends _$PetVaccinationsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetVaccinationModel>> build(int petId) {
    return _databaseService
        .getAllPetVaccinationsForPet(petId)
        .map((p) => PetVaccinationMapper.mapToModelList(p));
  }

  Future<PetVaccinationModel?> save(PetVaccinationModel petVaccination) async {
    if (petVaccination.petVaccinationId == null) {
      final newPetVaccination = await _databaseService.createPetVaccination(
        petVaccination.petId,
        petVaccination.name,
        petVaccination.administeredDate,
        petVaccination.expiryDate,
        petVaccination.reminderDate,
        petVaccination.notes,
        petVaccination.vaccineBatchNumber,
        petVaccination.vaccineManufacturer,
        petVaccination.administeredBy,
      );

      // create linked journal entry if required
      if (newPetVaccination == null) return null;
      final newPetVaccinationModel = PetVaccinationMapper.mapToModel(
        newPetVaccination,
      );
      await _createLinkedJournalEntry(newPetVaccinationModel);
      return newPetVaccinationModel;
    } else {
      await _databaseService.updatePetVaccination(
        petVaccination.petVaccinationId!,
        petVaccination.name,
        petVaccination.administeredDate,
        petVaccination.expiryDate,
        petVaccination.reminderDate,
        petVaccination.notes,
        petVaccination.vaccineBatchNumber,
        petVaccination.vaccineManufacturer,
        petVaccination.administeredBy,
      );

      await _createLinkedJournalEntry(petVaccination, createNew: false);

      return petVaccination;
    }
  }

  Future<int> deletePetVaccination(int id) {
    return _databaseService.deletePetVaccination(id);
  }

  /// If required, create / update the linked journal entry
  Future<void> _createLinkedJournalEntry(
    PetVaccinationModel petVaccination, {
    bool createNew = true,
  }) async {
    if (SettingsHelper.createLinkedJournalEntries()) {
      if (createNew) {
        await _databaseService.createJournalEntryForPet(
          entryText: petVaccination.notes ?? '',
          petIdList: [petVaccination.petId],
          tags: [],
          linkedRecordId: petVaccination.petVaccinationId,
          linkedRecordType: LinkedRecordType.vaccination,
          linkedRecordTitle: 'Vaccination ${petVaccination.name} administered',
        );
      } else {
        await _databaseService.updateLinkedJournalEntry(
          linkedRecordId: petVaccination.petVaccinationId!,
          linkedRecordType: LinkedRecordType.vaccination,
          linkedRecordTitle:
              'Vaccination ${petVaccination.name} administered (updated)',
        );
      }
    }
  }
}
