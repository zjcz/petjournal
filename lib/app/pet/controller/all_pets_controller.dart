import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/data/mapper/pet_mapper.dart';
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
        pet.species.speciesId!,
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
      );

      return newPet == null ? null : PetMapper.mapToModel(newPet);
    } else {
      await _databaseService.updatePet(
        pet.petId!,
        pet.name,
        pet.species.speciesId!,
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
      );
      return pet;
    }
  }

  Future<int> deletePet(int id) {
    return _databaseService.deletePet(id);
  }
}
