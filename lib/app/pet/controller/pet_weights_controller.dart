import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/data/mapper/pet_weight_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_weights_controller.g.dart';

@riverpod
class PetWeightsController
    extends _$PetWeightsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetWeightModel>> build(int petId) {
    return _databaseService
        .getAllPetWeightsForPet(petId)
        .map((p) => PetWeightMapper.mapToModelList(p));
  }
}
