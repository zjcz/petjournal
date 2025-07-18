import 'package:drift/drift.dart';
import 'package:petjournal/data/database/tables/pet.dart';

// Table definition for petVaccinations table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('PetVaccination')
class PetVaccinations extends Table {
  IntColumn get petVaccinationId => integer().autoIncrement()();
  IntColumn get pet =>
      integer().references(Pets, #petId, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(max: 100)();  
  DateTimeColumn get administeredDate => dateTime()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  DateTimeColumn get reminderDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get vaccineBatchNumber => text().withLength(max: 100)();  
  TextColumn get vaccineManufacturer => text().withLength(max: 100)();  
  TextColumn get administeredBy => text().withLength(max: 100)();  
}
