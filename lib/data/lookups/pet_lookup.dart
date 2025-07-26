import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/all_pets_controller.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_lookup.g.dart';

/// Class to lookup PetModel objects based on their id
class PetLookup {
  Map<int, PetModel> _petLookup = {};

  static final PetLookup _instance = PetLookup._internal();

  factory PetLookup() {
    return _instance;
  }

  PetLookup._internal();

  /// Refresh the pet list
  void refreshList(List<PetModel> pets) {
    _petLookup = {};
    for (PetModel pet in pets) {
      if (pet.petId != null) {
        _petLookup[pet.petId!] = pet;
      }
    }
  }

  /// Get a PetModel object by its id
  /// Return null if not found
  PetModel? getPet(int id) {
    return _petLookup[id];
  }
}

@Riverpod(keepAlive: true)
Future<void> populatePetLookup(Ref ref) async {
  final petList = await ref.watch(allPetsControllerProvider.future);
  PetLookup().refreshList(petList);
}
