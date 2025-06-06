import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/data/database/database_service.dart';

class PetMedMapper {
  static PetMedModel mapToModel(PetMed petMed) {
    return PetMedModel(
      petMedId: petMed.petMedId,
      petId: petMed.pet,
      name: petMed.name,
      dose: petMed.dose,
      startDate: petMed.startDate,
      endDate: petMed.endDate,
      notes: petMed.notes,
    );
  }

  static List<PetMedModel> mapToModelList(List<PetMed> petMeds) {
    return petMeds.map((petMed) => mapToModel(petMed)).toList();
  }
}
