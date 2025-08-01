import 'package:drift/drift.dart';

// Table definition for Settings table
// Need to run 'dart run build_runner build' after making changes to this file
@DataClassName('Setting')
class Settings extends Table {
  IntColumn get settingsId => integer()();
  BoolColumn get acceptedTermsAndConditions =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onBoardingComplete =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get optIntoAnalyticsWarning =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastUsedVersion => text().nullable().withLength(max: 10)();
  IntColumn get defaultWeightUnit => integer().nullable()();
  BoolColumn get createLinkedJournalEntries =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {settingsId};
}
