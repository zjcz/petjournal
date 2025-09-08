import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/data/mapper/pet_mapper.dart';
import 'package:petjournal/helpers/settings_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'all_pets_controller.g.dart';

@riverpod
class AllPetsController extends _$AllPetsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetModel>> build() {
    return _databaseService.getAllPets().map(
      (p) => PetMapper.mapToModelList(p),
    );
  }

  Future<PetModel?> save(PetModel pet) async {
    if (pet.petId == null) {
      final newPet = await _databaseService.createPet(
        pet.name,
        pet.speciesId,
        pet.breed,
        pet.colour,
        pet.petSex,
        pet.dob,
        pet.dobEstimate,
        pet.diet ?? '',
        pet.notes ?? '',
        pet.history ?? '',
        pet.isNeutered,
        pet.neuterDate,
        pet.status,
        pet.isMicrochipped,
        pet.microchipDate,
        pet.microchipNumber,
        pet.microchipCompany,
        pet.microchipNotes,
        pet.imageUrl,
      );

      // create linked journal entry if required
      if (newPet == null) return null;
      final newPetModel = PetMapper.mapToModel(newPet);
      await _createLinkedJournalEntry(newPetModel);
      return newPetModel;
    } else {
      await _databaseService.updatePet(
        pet.petId!,
        pet.name,
        pet.speciesId,
        pet.breed,
        pet.colour,
        pet.petSex,
        pet.dob,
        pet.dobEstimate,
        pet.diet ?? '',
        pet.notes ?? '',
        pet.history ?? '',
        pet.isNeutered,
        pet.neuterDate,
        pet.status,
        pet.statusDate,
        pet.isMicrochipped,
        pet.microchipDate,
        pet.microchipNumber,
        pet.microchipCompany,
        pet.microchipNotes,
        pet.imageUrl,
      );
      return pet;
    }
  }

  Future<int> deletePet(int id) {
    return _databaseService.deletePet(id);
  }

  /// If required, create / update the linked journal entry
  Future<void> _createLinkedJournalEntry(
    PetModel pet, {
    bool createNew = true,
  }) async {
    if (SettingsHelper.createLinkedJournalEntries()) {
      if (createNew) {
        await _databaseService.createJournalEntryForPet(
          entryText: pet.notes ?? '',
          petIdList: [pet.petId!],
          tags: [],
          linkedRecordId: pet.petId,
          linkedRecordType: LinkedRecordType.pet,
          linkedRecordTitle: 'Pet ${pet.name} created',
        );
      } else {
        await _databaseService.updateLinkedJournalEntry(
          linkedRecordId: pet.petId!,
          linkedRecordType: LinkedRecordType.pet,
          linkedRecordTitle: 'Pet ${pet.name} created (updated)',
        );
      }
    }
  }
}
