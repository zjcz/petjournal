import 'package:drift/drift.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/tables/pet.dart';

// Table definition for PetWeights table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('PetWeight')
class PetWeights extends Table {
  IntColumn get petWeightId => integer().autoIncrement()();
  IntColumn get pet =>
      integer().references(Pets, #petId, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real()();
  TextColumn get weightUnit =>
      textEnum<WeightUnits>().withDefault(Constant(WeightUnits.metric.name))();
  TextColumn get notes => text().nullable()();
}
