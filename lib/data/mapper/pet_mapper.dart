import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/constants/pet_sex.dart';

class PetMapper {
  static PetModel mapToModel(Pet pet) {
    return PetModel(
      petId: pet.petId,
      name: pet.name,
      breed: pet.breed,
      colour: pet.colour,
      petSex: PetSex.fromDataValue(pet.sex),
      age: pet.age,
      dob: pet.dob,
      dobEstimate: pet.dobEstimate,
      dobCalculated: pet.dobCalculated,
      diet: pet.diet,
      notes: pet.notes,
      history: pet.history,
      isNeutered: pet.isNeutered,
      neuterDate: pet.neuterDate,
      status: PetStatus.fromDataValue(pet.status),
      statusDate: pet.statusDate,
      species: SpeciesModel(
        speciesId: pet.speciesId,
        name: 'Test Species',
        userAdded: false,
      ),
      isMicrochipped: pet.isMicrochipped ?? false,
      microchipDate: pet.microchipDate,
      microchipNotes: pet.microchipNotes,
      microchipNumber: pet.microchipNumber,
      microchipCompany: pet.microchipCompany,
    );
  }

  static List<PetModel> mapToModelList(List<Pet> pets) {
    return pets.map((pet) => mapToModel(pet)).toList();
  }
}
