import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';

class PetMapper {
  static PetModel mapToModel(Pet pet) {
    return PetModel(
      petId: pet.petId,
      name: pet.name,
      breed: pet.breed,
      colour: pet.colour,
      petSex: pet.sex,
      dob: pet.dob,
      dobEstimate: pet.dobEstimate,
      diet: pet.diet,
      notes: pet.notes,
      history: pet.history,
      isNeutered: pet.isNeutered,
      neuterDate: pet.neuterDate,
      status: pet.status,
      statusDate: pet.statusDate,
      speciesId: pet.speciesId,
      isMicrochipped: pet.isMicrochipped ?? false,
      microchipDate: pet.microchipDate,
      microchipNotes: pet.microchipNotes,
      microchipNumber: pet.microchipNumber,
      microchipCompany: pet.microchipCompany,
      imageUrl: pet.imageUrl,
    );
  }

  static List<PetModel> mapToModelList(List<Pet> pets) {
    return pets.map((pet) => mapToModel(pet)).toList();
  }
}
