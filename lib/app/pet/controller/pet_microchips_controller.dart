import 'package:petjournal/app/pet/models/pet_microchip_model.dart';
import 'package:petjournal/data/mapper/pet_microchip_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_microchips_controller.g.dart';

@riverpod
class PetMicrochipsController extends _$PetMicrochipsController {
  late final DatabaseService _databaseService =
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  ref.read(DatabaseService.provider);

  @override
  Stream<List<PetMicrochipModel>?> build(int petId) {
    return _databaseService
        .getAllPetMicrochipsForPet(petId)
        .map((p) => PetMicrochipMapper.mapToModelList(p));
  }
}
