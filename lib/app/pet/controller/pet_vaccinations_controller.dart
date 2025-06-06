import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/data/mapper/pet_vaccination_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_vaccinations_controller.g.dart';

@riverpod
class PetVaccinationController extends _$PetVaccinationController {
  late final DatabaseService _databaseService =
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  ref.read(DatabaseService.provider);

  @override
  Stream<List<PetVaccinationModel>> build(int petId) {
    return _databaseService
        .getAllPetVaccinationsForPet(petId)
        .map((p) => PetVaccinationMapper.mapToModelList(p));
  }
}
