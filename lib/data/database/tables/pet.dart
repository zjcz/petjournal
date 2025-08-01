import 'package:drift/drift.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/data/database/tables/species_type.dart';

// Table definition for pet table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('Pet')
class Pets extends Table {
  IntColumn get petId => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 100)();
  IntColumn get speciesId =>
      integer().references(
        SpeciesTypes,
        #speciesId,
        onDelete: KeyAction.restrict,
      )();
  TextColumn get breed => text().withLength(max: 100)();
  TextColumn get colour => text().withLength(max: 100)();
  TextColumn get sex =>
      textEnum<PetSex>().withDefault(Constant(PetSex.unknown.name))();      
  DateTimeColumn get dob => dateTime().nullable()();
  BoolColumn get dobEstimate => boolean().withDefault(const Constant(false))();
  TextColumn get diet => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get history => text().nullable()();

  BoolColumn get isNeutered => boolean().withDefault(const Constant(false))();
  DateTimeColumn get neuterDate => dateTime().nullable()();

  TextColumn get status =>
      textEnum<PetStatus>().withDefault(Constant(PetStatus.active.name))();      
  DateTimeColumn get statusDate => dateTime().withDefault(currentDateAndTime)();

  BoolColumn get isMicrochipped =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get microchipDate => dateTime().nullable()();
  TextColumn get microchipNotes => text().nullable()();
  TextColumn get microchipNumber => text().nullable()();
  TextColumn get microchipCompany => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
}
