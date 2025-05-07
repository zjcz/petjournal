import 'package:drift/drift.dart';
import 'package:petjournal/data/database/tables/pet.dart';

// Table definition for PetMicrochips table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('PetMicrochip')
class PetMicrochips extends Table {
  IntColumn get petMicrochipId => integer().autoIncrement()();
  IntColumn get pet =>
      integer().references(Pets, #petId, onDelete: KeyAction.cascade)();
  BoolColumn get isMicrochipped =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get microchipDate => dateTime().nullable()();
  TextColumn get microchipNotes => text().nullable()();
  TextColumn get microchipNumber => text().nullable()();
  TextColumn get microchipCompany => text().nullable()();
}
