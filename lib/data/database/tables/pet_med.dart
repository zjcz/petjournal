import 'package:drift/drift.dart';
import 'package:petjournal/data/database/tables/pet.dart';

// Table definition for petMeds table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('PetMed')
class PetMeds extends Table {
  IntColumn get petMedId => integer().autoIncrement()();
  IntColumn get pet =>
      integer().references(Pets, #petId, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(max: 100)();
  TextColumn get dose => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
}
