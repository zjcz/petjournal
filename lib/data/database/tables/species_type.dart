import 'package:drift/drift.dart';

// Table definition for species table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('SpeciesType')
class SpeciesTypes extends Table {
  IntColumn get speciesId => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(max: 100)();
  BoolColumn get userAdded => boolean().withDefault(const Constant(false))();
}
