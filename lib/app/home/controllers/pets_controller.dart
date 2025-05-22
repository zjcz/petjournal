import 'package:petjournal/app/home/models/pet_model.dart';
import 'package:petjournal/data/mapper/pet_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pets_controller.g.dart';

@riverpod
class PetsController
    extends _$PetsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<List<PetModel>> build() {
    return _databaseService
        .getAllPets()
        .map((p) => PetMapper.mapToModelList(p));
  }
}
