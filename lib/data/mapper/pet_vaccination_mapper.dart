import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/data/database/database_service.dart';

class PetVaccinationMapper {
  static PetVaccinationModel mapToModel(PetVaccination petVaccination) {
    return PetVaccinationModel(
      petVaccinationId: petVaccination.petVaccinationId,
      petId: petVaccination.pet,
      name: petVaccination.name,
      administeredDate: petVaccination.administeredDate,
      expiryDate: petVaccination.expiryDate,
      reminderDate: petVaccination.reminderDate,
      notes: petVaccination.notes,
      vaccineBatchNumber: petVaccination.vaccineBatchNumber,
      vaccineManufacturer: petVaccination.vaccineManufacturer,
      administeredBy: petVaccination.administeredBy,
    );
  }

  static List<PetVaccinationModel> mapToModelList(
    List<PetVaccination> petVaccinations,
  ) {
    return petVaccinations
        .map((petVaccination) => mapToModel(petVaccination))
        .toList();
  }
}
