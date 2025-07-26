import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/species/controllers/species_controller.dart';
import 'package:petjournal/app/species/models/species_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'species_lookup.g.dart';

/// Class to lookup SpeciesModel objects based on their id
class SpeciesLookup {
  Map<int, SpeciesModel> _speciesLookup = {};

  static final SpeciesLookup _instance = SpeciesLookup._internal();

  factory SpeciesLookup() {
    return _instance;
  }

  SpeciesLookup._internal();

  /// Refresh the species list
  void refreshList(List<SpeciesModel> speciesList) {
    _speciesLookup = {};
    for (SpeciesModel species in speciesList) {
      if (species.speciesId != null) {
        _speciesLookup[species.speciesId!] = species;
      }
    }
  }

  /// Get a SpeciesModel object by its id
  /// Return null if not found
  SpeciesModel? getSpecies(int id) {
    return _speciesLookup[id];
  }
}

@Riverpod(keepAlive: true)
Future<void> populateSpeciesLookup(Ref ref) async {
  final speciesList = await ref.watch(speciesControllerProvider.future);
  SpeciesLookup().refreshList(speciesList);
}
