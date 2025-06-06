import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/data/mapper/pet_med_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_meds_controller.g.dart';

@riverpod
class PetMedsController
    extends _$PetMedsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetMedModel>?> build(int petId) {
    return _databaseService
        .getAllPetMedsForPet(petId)
        .map((p) => PetMedMapper.mapToModelList(p));
  }
}
