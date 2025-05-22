import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/app/species/models/species_model.dart';

class SpeciesMapper {
  static SpeciesModel mapToModel(SpeciesType speciesType) {
    return SpeciesModel(
      speciesId: speciesType.speciesId,
      name: speciesType.name,
      userAdded: speciesType.userAdded,
    );
  }

  static List<SpeciesModel> mapToModelList(List<SpeciesType> speciesTypes) {
    return speciesTypes.map((speciesType) => mapToModel(speciesType)).toList();
  }
}
