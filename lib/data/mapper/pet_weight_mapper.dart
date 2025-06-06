import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';

class PetWeightMapper {
  static PetWeightModel mapToModel(PetWeight petWeight) {
    return PetWeightModel(
      petWeightId: petWeight.petWeightId,
      petId: petWeight.pet,
      date: petWeight.date,
      weight: petWeight.weight,      
      weightUnit: WeightUnits.fromDataValue(petWeight.weightUnit),
      notes: petWeight.notes,
    );
  }

  static List<PetWeightModel> mapToModelList(List<PetWeight> petWeights) {
    return petWeights.map((petWeight) => mapToModel(petWeight)).toList();
  }
}
