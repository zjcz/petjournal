import 'package:petjournal/app/pet/models/pet_microchip_model.dart';
import 'package:petjournal/data/database/database_service.dart';

class PetMicrochipMapper {
  static PetMicrochipModel mapToModel(PetMicrochip petMicrochip) {
    return PetMicrochipModel(
      petMicrochipId: petMicrochip.petMicrochipId,
      petId: petMicrochip.pet,
      isMicrochipped: petMicrochip.isMicrochipped ?? false,
      microchipDate: petMicrochip.microchipDate,
      microchipNotes: petMicrochip.microchipNotes,
      microchipNumber: petMicrochip.microchipNumber,
      microchipCompany: petMicrochip.microchipCompany,
    );
  }

  static List<PetMicrochipModel> mapToModelList(
    List<PetMicrochip> petMicrochips,
  ) {
    return petMicrochips
        .map((petMicrochip) => mapToModel(petMicrochip))
        .toList();
  }
}
