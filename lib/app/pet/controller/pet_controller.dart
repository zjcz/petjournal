import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/data/mapper/pet_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'pet_controller.g.dart';

@riverpod
class PetController
    extends _$PetController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<PetModel?> build(int petId) {
    return _databaseService
        .watchPet(petId)
        .map((p) => p == null ? null : PetMapper.mapToModel(p));
  }
}
