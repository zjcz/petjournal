import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/data/mapper/pet_weight_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_weights_controller.g.dart';

@riverpod
class PetWeightsController extends _$PetWeightsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);
  late final _settingsFuture = ref.watch(settingsControllerProvider.future);

  @override
  Stream<List<PetWeightModel>> build(int petId) {
    return _databaseService
        .getAllPetWeightsForPet(petId)
        .map((p) => PetWeightMapper.mapToModelList(p));
  }

  Future<PetWeightModel?> save(PetWeightModel petWeight) async {
    if (petWeight.petWeightId == null) {
      final newPetWeight = await _databaseService.createPetWeight(
        petWeight.petId,
        petWeight.date,
        petWeight.weight,
        petWeight.weightUnit,
        petWeight.notes,
      );

      // create linked journal entry if required
      if (newPetWeight == null) return null;
      final newPetWeightModel = PetWeightMapper.mapToModel(newPetWeight);
      await _createLinkedJournalEntry(newPetWeightModel);
      return newPetWeightModel;
    } else {
      await _databaseService.updatePetWeight(
        petWeight.petWeightId!,
        petWeight.date,
        petWeight.weight,
        petWeight.weightUnit,
        petWeight.notes,
      );

      await _createLinkedJournalEntry(petWeight, createNew: false);

      return petWeight;
    }
  }

  Future<int> deletePetWeight(int id) {
    return _databaseService.deletePetWeight(id);
  }

  /// If required, create / update the linked journal entry
  Future<void> _createLinkedJournalEntry(
    PetWeightModel petWeight, {
    bool createNew = true,
  }) async {
    final settings = await _settingsFuture;
    if (settings.createLinkedJournalEntries) {
      if (createNew) {
        await _databaseService.createJournalEntryForPet(
          entryText: petWeight.notes ?? '',
          petIdList: [petWeight.petId],
          tags: [],
          linkedRecordId: petWeight.petWeightId,
          linkedRecordType: LinkedRecordType.weight,
          linkedRecordTitle: 'Weight ${petWeight.niceName()} recorded',
        );
      } else {
        await _databaseService.updateLinkedJournalEntry(
          linkedRecordId: petWeight.petWeightId!,
          linkedRecordType: LinkedRecordType.weight,
          linkedRecordTitle:
              'Weight ${petWeight.niceName()} recorded (updated)',
        );
      }
    }
  }
}
