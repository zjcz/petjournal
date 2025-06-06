import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petjournal/constants/defaults.dart';
import 'package:petjournal/constants/pet_sex.dart';
import 'package:petjournal/constants/pet_status.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/tables/journal_entry.dart';
import 'package:petjournal/data/database/tables/journal_entry_tag.dart';
import 'package:petjournal/data/database/tables/pet_journal_entry.dart';
import 'package:petjournal/data/database/tables/pet_microchip.dart';
import 'package:petjournal/data/database/tables/pet_vaccination.dart';
import 'package:petjournal/data/database/tables/pet_weight.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/data/database/tables/setting.dart';
import 'package:petjournal/data/database/tables/species_type.dart';
import 'package:petjournal/helpers/date_helper.dart';

import 'tables/pet.dart';
import 'tables/pet_med.dart';

part 'database_service.g.dart';

@DriftDatabase(
  tables: [
    Pets,
    PetMicrochips,
    PetMeds,
    PetVaccinations,
    PetWeights,
    JournalEntries,
    JournalEntryTags,
    PetJournalEntries,
    SpeciesTypes,
    Settings,
  ],
)
class DatabaseService extends _$DatabaseService {
  DatabaseService([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'app-datastore',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  DatabaseService.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          // Create default records here
          await createDefaultSettings();
        }
      },
    );
  }

  // List all the pets in the database
  Stream<List<Pet>> getAllPets() {
    return (select(pets)..orderBy([(p) => OrderingTerm.asc(p.name)])).watch();
  }

  // Get a single pet by its id
  Future<Pet?> getPet(int id) {
    return (select(pets)..where((p) => p.petId.equals(id))).getSingleOrNull();
  }

  // Watch a single pet by its id
  Stream<Pet?> watchPet(int id) {
    return (select(pets)..where((p) => p.petId.equals(id))).watchSingleOrNull();
  }

  // Create a new pet record
  Future<Pet?> createPet(
    String name,
    int speciesId,
    String breed,
    String colour,
    PetSex sex,
    int? age,
    DateTime? dob,
    bool? dobEstimate,
    bool? dobCalculated,
    String diet,
    String notes,
    String history,
    bool? isNeutered,
    DateTime? neuterDate,
    PetStatus status,
  ) {
    return into(pets).insertReturningOrNull(
      PetsCompanion.insert(
        name: name,
        speciesId: speciesId,
        breed: breed,
        colour: colour,
        sex: Value(sex.dataValue),
        age: age == null ? Value.absent() : Value(age),
        dob: dob == null ? Value.absent() : Value(DateHelper.removeTime(dob)),
        dobEstimate: Value(dobEstimate ?? false),
        dobCalculated: Value(dobCalculated ?? false),
        diet: Value(diet),
        notes: Value(notes),
        history: Value(history),
        isNeutered: Value(isNeutered ?? false),
        neuterDate:
            neuterDate == null
                ? Value.absent()
                : Value(DateHelper.removeTime(neuterDate)),
        status: Value(status.dataValue),
        statusDate: Value(DateTime.now()),
      ),
    );
  }

  // Update an existing pet record, return the number of records updated
  Future<int> updatePet(
    int id,
    String name,
    int speciesId,
    String breed,
    String colour,
    PetSex sex,
    int? age,
    DateTime? dob,
    bool? dobEstimate,
    bool? dobCalculated,
    String diet,
    String notes,
    String history,
    bool? isNeutered,
    DateTime? neuterDate,
    PetStatus status,
    DateTime statusDate,
  ) {
    return (update(pets)..where((p) => p.petId.equals(id))).write(
      PetsCompanion.insert(
        name: name,
        speciesId: speciesId,
        breed: breed,
        colour: colour,
        sex: Value(sex.dataValue),
        age: age == null ? Value.absent() : Value(age),
        dob: dob == null ? Value.absent() : Value(DateHelper.removeTime(dob)),
        dobEstimate: Value(dobEstimate ?? false),
        dobCalculated: Value(dobCalculated ?? false),
        diet: Value(diet),
        notes: Value(notes),
        history: Value(history),
        isNeutered: Value(isNeutered ?? false),
        neuterDate:
            neuterDate == null
                ? Value.absent()
                : Value(DateHelper.removeTime(neuterDate)),
        status: Value(status.dataValue),
        statusDate: Value(statusDate),
      ),
    );
  }

  // Delete a pet record by its id and return the number of records deleted
  Future<int> deletePet(int id) {
    return (delete(pets)..where((p) => p.petId.equals(id))).go();
  }

  // List all the pet medications in the database
  Stream<List<PetMed>> getAllPetMedsForPet(int petId) {
    return (select(petMeds)
          ..where((m) => m.pet.equals(petId))
          ..orderBy([(m) => OrderingTerm.asc(m.name)]))
        .watch();
  }

  // Get a single pet medication by its id
  Future<PetMed?> getPetMed(int id) {
    return (select(petMeds)
      ..where((m) => m.petMedId.equals(id))).getSingleOrNull();
  }

  // Watch a single pet medication by its id
  Stream<PetMed?> watchPetMed(int id) {
    return (select(petMeds)
      ..where((m) => m.petMedId.equals(id))).watchSingleOrNull();
  }

  // Create a new pet medication record
  Future<PetMed?> createPetMed(
    int petId,
    String name,
    String dose,
    DateTime startDate,
    DateTime? endDate,
    String notes,
  ) {
    return into(petMeds).insertReturningOrNull(
      PetMedsCompanion.insert(
        pet: petId,
        name: name,
        dose: dose,
        startDate: startDate,
        endDate: endDate == null ? Value.absent() : Value(endDate),
        notes: Value(notes),
      ),
    );
  }

  // Update an existing pet medication record, return the number of records updated
  Future<int> updatePetMed(
    int id,
    String name,
    String dose,
    DateTime startDate,
    DateTime? endDate,
    String notes,
  ) {
    return (update(petMeds)..where((m) => m.petMedId.equals(id))).write(
      PetMedsCompanion(
        name: Value(name),
        dose: Value(dose),
        startDate: Value(startDate),
        endDate: endDate == null ? Value.absent() : Value(endDate),
        notes: Value(notes),
      ),
    );
  }

  // Delete a pet medication record by its id and return the number of records deleted
  Future<int> deletePetMed(int id) {
    return (delete(petMeds)..where((m) => m.petMedId.equals(id))).go();
  }

  // List all the pet weights for a specific pet
  Stream<List<PetWeight>> getAllPetWeightsForPet(int petId) {
    return (select(petWeights)
          ..where((w) => w.pet.equals(petId))
          ..orderBy([(w) => OrderingTerm.desc(w.date)]))
        .watch();
  }

  // Get a single pet weight by its id
  Future<PetWeight?> getPetWeight(int id) {
    return (select(petWeights)
      ..where((w) => w.petWeightId.equals(id))).getSingleOrNull();
  }

  // Watch a single pet weight by its id
  Stream<PetWeight?> watchPetWeight(int id) {
    return (select(petWeights)
      ..where((w) => w.petWeightId.equals(id))).watchSingleOrNull();
  }

  // Create a new pet weight record
  Future<PetWeight?> createPetWeight(
    int petId,
    DateTime date,
    double weight,
    WeightUnits weightUnit,
    String? notes,
  ) {
    return into(petWeights).insertReturningOrNull(
      PetWeightsCompanion.insert(
        pet: petId,
        date: date,
        weight: weight,
        weightUnit: Value(weightUnit.dataValue),
        notes: Value(notes),
      ),
    );
  }

  // Update an existing pet weight record, return the number of records updated
  Future<int> updatePetWeight(
    int id,
    DateTime date,
    double weight,
    WeightUnits weightUnit,
    String? notes,
  ) {
    return (update(petWeights)..where((w) => w.petWeightId.equals(id))).write(
      PetWeightsCompanion(
        date: Value(date),
        weight: Value(weight),
        weightUnit: Value(weightUnit.dataValue),
        notes: Value(notes),
      ),
    );
  }

  // Delete a pet weight record by its id and return the number of records deleted
  Future<int> deletePetWeight(int id) {
    return (delete(petWeights)..where((w) => w.petWeightId.equals(id))).go();
  }

  // List all the pet vaccinations for a specific pet
  Stream<List<PetVaccination>> getAllPetVaccinationsForPet(int petId) {
    return (select(petVaccinations)
          ..where((v) => v.pet.equals(petId))
          ..orderBy([(v) => OrderingTerm.asc(v.name)]))
        .watch();
  }

  // Get a single pet vaccination by its id
  Future<PetVaccination?> getPetVaccination(int id) async {
    try {
      return await (select(petVaccinations)
        ..where((v) => v.petVaccinationId.equals(id))).getSingleOrNull();
    } catch (e) {
      throw Exception('Error retrieving pet vaccination: $e');
    }
  }

  // Watch a single pet vaccination by its id
  Stream<PetVaccination?> watchPetVaccination(int id) {
    return (select(petVaccinations)
      ..where((w) => w.petVaccinationId.equals(id))).watchSingleOrNull();
  }

  // Create a new pet vaccination record
  Future<PetVaccination?> createPetVaccination({
    required int petId,
    required String name,
    required DateTime administeredDate,
    required DateTime expiryDate,
    DateTime? reminderDate,
    String? notes,
    required String vaccineBatchNumber,
    required String vaccineManufacturer,
    required String administeredBy,
  }) async {
    try {
      return await into(petVaccinations).insertReturningOrNull(
        PetVaccinationsCompanion.insert(
          pet: petId,
          name: name,
          administeredDate: administeredDate,
          expiryDate: expiryDate,
          reminderDate: Value(reminderDate),
          notes: Value(notes),
          vaccineBatchNumber: vaccineBatchNumber,
          vaccineManufacturer: vaccineManufacturer,
          administeredBy: administeredBy,
        ),
      );
    } catch (e) {
      throw Exception('Error creating pet vaccination: $e');
    }
  }

  // Update an existing pet vaccination record
  Future<int> updatePetVaccination({
    required int id,
    required String name,
    required DateTime administeredDate,
    required DateTime expiryDate,
    required DateTime reminderDate,
    String? notes,
    required String vaccineBatchNumber,
    required String vaccineManufacturer,
    required String administeredBy,
  }) async {
    try {
      return await (update(petVaccinations)
        ..where((v) => v.petVaccinationId.equals(id))).write(
        PetVaccinationsCompanion(
          name: Value(name),
          administeredDate: Value(administeredDate),
          expiryDate: Value(expiryDate),
          reminderDate: Value(reminderDate),
          notes: Value(notes),
          vaccineBatchNumber: Value(vaccineBatchNumber),
          vaccineManufacturer: Value(vaccineManufacturer),
          administeredBy: Value(administeredBy),
        ),
      );
    } catch (e) {
      throw Exception('Error updating pet vaccination: $e');
    }
  }

  // Delete a pet vaccination record by its id
  Future<int> deletePetVaccination(int id) async {
    try {
      return await (delete(petVaccinations)
        ..where((v) => v.petVaccinationId.equals(id))).go();
    } catch (e) {
      throw Exception('Error deleting pet vaccination: $e');
    }
  }

  // List all the pet microchips for a specific pet
  Stream<List<PetMicrochip>> getAllPetMicrochipsForPet(int petId) {
    return (select(petMicrochips)
          ..where((m) => m.pet.equals(petId))
          ..orderBy([(m) => OrderingTerm.asc(m.microchipDate)]))
        .watch();
  }

  // Get a single pet microchip by its id
  Future<PetMicrochip?> getPetMicrochip(int id) async {
    try {
      return await (select(petMicrochips)
        ..where((m) => m.petMicrochipId.equals(id))).getSingleOrNull();
    } catch (e) {
      throw Exception('Error retrieving pet microchip: $e');
    }
  }

  // Watch a single pet microchip by its id
  Stream<PetMicrochip?> watchPetMicrochip(int id) {
    return (select(petMicrochips)
      ..where((w) => w.petMicrochipId.equals(id))).watchSingleOrNull();
  }

  // Create a new pet microchip record
  Future<PetMicrochip?> createPetMicrochip({
    required int petId,
    bool? isMicrochipped,
    DateTime? microchipDate,
    String? microchipNotes,
    String? microchipNumber,
    String? microchipCompany,
  }) async {
    try {
      return await into(petMicrochips).insertReturningOrNull(
        PetMicrochipsCompanion.insert(
          pet: petId,
          isMicrochipped: Value(isMicrochipped ?? true),
          microchipDate: Value(microchipDate),
          microchipNotes: Value(microchipNotes),
          microchipNumber: Value(microchipNumber),
          microchipCompany: Value(microchipCompany),
        ),
      );
    } catch (e) {
      throw Exception('Error creating pet microchip: $e');
    }
  }

  // Update an existing pet microchip record
  Future<int> updatePetMicrochip({
    required int id,
    bool? isMicrochipped,
    DateTime? microchipDate,
    String? microchipNotes,
    String? microchipNumber,
    String? microchipCompany,
  }) async {
    try {
      return await (update(petMicrochips)
        ..where((m) => m.petMicrochipId.equals(id))).write(
        PetMicrochipsCompanion(
          isMicrochipped:
              isMicrochipped != null
                  ? Value(isMicrochipped)
                  : const Value.absent(),
          microchipDate:
              microchipDate != null
                  ? Value(microchipDate)
                  : const Value.absent(),
          microchipNotes:
              microchipNotes != null
                  ? Value(microchipNotes)
                  : const Value.absent(),
          microchipNumber:
              microchipNumber != null
                  ? Value(microchipNumber)
                  : const Value.absent(),
          microchipCompany:
              microchipCompany != null
                  ? Value(microchipCompany)
                  : const Value.absent(),
        ),
      );
    } catch (e) {
      throw Exception('Error updating pet microchip: $e');
    }
  }

  // Delete a pet microchip record by its id
  Future<int> deletePetMicrochip(int id) async {
    try {
      return await (delete(petMicrochips)
        ..where((m) => m.petMicrochipId.equals(id))).go();
    } catch (e) {
      throw Exception('Error deleting pet microchip: $e');
    }
  }

  /// Create a new journal entry record
  Future<JournalEntry?> createJournalEntryForPet({
    required int petId,
    required String? entryText,
    required DateTime entryDate,
  }) async {
    return transaction(() async {
      try {
        // Create the journal entry
        final journalEntry = await into(journalEntries).insertReturningOrNull(
          JournalEntriesCompanion.insert(
            entryText: Value(entryText),
            entryDate: Value(entryDate),
          ),
        );

        // If the journal entry creation failed, return null
        if (journalEntry == null) {
          return null;
        }

        // Create the PetJournalEntry record
        final petJournalEntry = await into(petJournalEntries).insert(
          PetJournalEntriesCompanion.insert(
            petId: petId,
            journalEntryId: journalEntry.journalEntryId,
          ),
        );

        // If the PetJournalEntry creation failed, rollback the transaction
        if (petJournalEntry == 0) {
          throw Exception('Failed to create PetJournalEntry');
        }

        return journalEntry;
      } catch (e) {
        throw Exception('Error creating journal entry for pet: $e');
      }
    });
  }

  /// Retrieve a single journal entry by its ID
  Future<JournalEntry?> getJournalEntry(int id) async {
    try {
      return await (select(journalEntries)
        ..where((entry) => entry.journalEntryId.equals(id))).getSingleOrNull();
    } catch (e) {
      throw Exception('Error retrieving journal entry: $e');
    }
  }

  /// Watch a single journal entry by its ID
  /// This is useful for real-time updates in the UI
  Stream<JournalEntry?> watchJournalEntry(int id) {
    return (select(journalEntries)
      ..where((entry) => entry.journalEntryId.equals(id))).watchSingleOrNull();
  }

  /// Retrieve all journal entries for a specific pet ID via the PetJournalEntry table
  Stream<List<JournalEntry>> getAllJournalEntriesForPet(int petId) {
    final query = select(journalEntries).join([
      innerJoin(
        petJournalEntries,
        petJournalEntries.journalEntryId.equalsExp(
          journalEntries.journalEntryId,
        ),
      ),
    ])..where(petJournalEntries.petId.equals(petId));

    return query.watch().map((rows) {
      return rows.map((row) => row.readTable(journalEntries)).toList();
    });
  }

  /// Update an existing journal entry record
  Future<int> updateJournalEntry({
    required int id,
    String? entryText,
    DateTime? entryDate,
  }) async {
    try {
      return await (update(journalEntries)
        ..where((entry) => entry.journalEntryId.equals(id))).write(
        JournalEntriesCompanion(
          entryText:
              entryText != null ? Value(entryText) : const Value.absent(),
          entryDate:
              entryDate != null ? Value(entryDate) : const Value.absent(),
        ),
      );
    } catch (e) {
      throw Exception('Error updating journal entry: $e');
    }
  }

  /// Delete a journal entry record by its ID
  Future<int> deleteJournalEntry(int id) async {
    try {
      return await (delete(journalEntries)
        ..where((entry) => entry.journalEntryId.equals(id))).go();
    } catch (e) {
      throw Exception('Error deleting journal entry: $e');
    }
  }

  /// Create a new journal entry tag record
  Future<JournalEntryTag?> createJournalEntryTag({
    required int journalEntryId,
    required String tag,
  }) async {
    try {
      return await into(journalEntryTags).insertReturningOrNull(
        JournalEntryTagsCompanion.insert(
          journalEntryId: journalEntryId,
          tag: tag,
        ),
      );
    } catch (e) {
      throw Exception('Error creating journal entry tag: $e');
    }
  }

  /// Retrieve all journal entry tags for a specific journal entry ID
  Stream<List<JournalEntryTag>> getAllJournalEntryTagsForEntry(
    int journalEntryId,
  ) {
    try {
      return (select(journalEntryTags)
        ..where((tag) => tag.journalEntryId.equals(journalEntryId))).watch();
    } catch (e) {
      throw Exception('Error retrieving journal entry tags: $e');
    }
  }

  /// Delete a journal entry tag record by its ID
  Future<int> deleteJournalEntryTag(int journalEntryTagId) async {
    try {
      return await (delete(journalEntryTags)
        ..where((tag) => tag.journalEntryTagId.equals(journalEntryTagId))).go();
    } catch (e) {
      throw Exception('Error deleting journal entry tag: $e');
    }
  }

  // List all the species types
  Stream<List<SpeciesType>> getAllSpeciesTypes() {
    return (select(speciesTypes)
      ..orderBy([(v) => OrderingTerm.asc(v.name)])).watch();
  }

  // Get a single species type by its id
  Future<SpeciesType?> getSpeciesType(int id) async {
    try {
      return await (select(speciesTypes)
        ..where((s) => s.speciesId.equals(id))).getSingleOrNull();
    } catch (e) {
      throw Exception('Error retrieving species type: $e');
    }
  }

  // Watch a single species type by its id
  Stream<SpeciesType?> watchSpeciesType(int id) {
    return (select(speciesTypes)
      ..where((s) => s.speciesId.equals(id))).watchSingleOrNull();
  }

  // Create a new species type record
  Future<SpeciesType?> createSpeciesType({
    required String name,
    required bool userAdded,
    int? speciesId,
  }) async {
    try {
      return await into(speciesTypes).insertReturningOrNull(
        SpeciesTypesCompanion.insert(
          name: name,
          userAdded: Value(userAdded),
          speciesId: Value.absentIfNull(speciesId),
        ),
      );
    } catch (e) {
      throw Exception('Error creating species type: $e');
    }
  }

  // Update an existing species type record
  Future<int> updateSpeciesType({
    required int id,
    required String name,
    required bool userAdded,
  }) async {
    try {
      return await (update(speciesTypes)
        ..where((s) => s.speciesId.equals(id))).write(
        SpeciesTypesCompanion(name: Value(name), userAdded: Value(userAdded)),
      );
    } catch (e) {
      throw Exception('Error updating pet vaccination: $e');
    }
  }

  // Delete a species type record by its id
  Future<int> deleteSpeciesType(int id) async {
    try {
      return await (delete(speciesTypes)
        ..where((s) => s.speciesId.equals(id))).go();
    } catch (e) {
      throw Exception('Error deleting species type: $e');
    }
  }

  // Get the settings
  Future<Setting?> getSettings() async {
    try {
      return await (select(settings)..where(
        (s) => s.settingsId.equals(defaultSettingsId),
      )).getSingleOrNull();
    } catch (e) {
      throw Exception('Error retrieving settings: $e');
    }
  }

  // Watch the settings
  Stream<Setting?> watchSettings() {
    return (select(settings)..where(
      (s) => s.settingsId.equals(defaultSettingsId),
    )).watchSingleOrNull();
  }

  // Creae the default settings record.  If the record already exists it resets it
  Future<Setting> createDefaultSettings() async {
    Setting newSettings = Setting(
      settingsId: defaultSettingsId,
      acceptedTermsAndConditions: false,
      onBoardingComplete: false,
      optIntoAnalyticsWarning: false,
      lastUsedVersion: null,
      defaultWeightUnit: null,
    );

    try {
      bool success = await update(settings).replace(newSettings);
      if (!success) {
        return await into(settings).insertReturning(newSettings);
      }
    } catch (e) {
      throw Exception('Error creating default settings: $e');
    }
    return newSettings;
  }

  // Save the onboarding settings data.
  Future<int> saveSettingsOnboarding(
    bool acceptedTermsAndConditions,
    bool optIntoAnalyticsWarning,
    bool onBoardingComplete,
  ) async {
    try {
      return await (update(settings)
        ..where((s) => s.settingsId.equals(defaultSettingsId))).write(
        SettingsCompanion(
          acceptedTermsAndConditions: Value(acceptedTermsAndConditions),
          onBoardingComplete: Value(onBoardingComplete),
          optIntoAnalyticsWarning: Value(optIntoAnalyticsWarning),
        ),
      );
    } catch (e) {
      throw Exception('Error updating onboarding settings: $e');
    }
  }

  // Save the user settings data.
  Future<int> saveSettingsUser(
    WeightUnits? defaultWeightUnit,
    bool? optIntoAnalyticsWarning,
  ) async {
    try {
      return await (update(settings)
        ..where((s) => s.settingsId.equals(defaultSettingsId))).write(
        SettingsCompanion(
          defaultWeightUnit: Value(defaultWeightUnit?.dataValue),
          optIntoAnalyticsWarning: Value.absentIfNull(optIntoAnalyticsWarning),
        ),
      );
    } catch (e) {
      throw Exception('Error updating user settings: $e');
    }
  }

  Future<int> resetSettingsUser() async {
    return saveSettingsUser(null, false);
  }

  Future<bool> testConnection() async {
    try {
      await customStatement("SELECT count(*) FROM sqlite_master");
    } catch (e) {
      return false;
    }

    return true;
  }

  // Clear all the data from the database
  Future<void> clearAllData() async {
    await (delete(journalEntries)).go();
    await (delete(pets)).go();
    await (delete(speciesTypes)).go();
    await resetSettingsUser();
  }

  Future<void> populateSpeciesTypes() async {
    createSpeciesType(speciesId: 1, name: 'Dog', userAdded: false);
    createSpeciesType(speciesId: 2, name: 'Cat', userAdded: false);
    createSpeciesType(speciesId: 3, name: 'Rabbit', userAdded: false);
    createSpeciesType(speciesId: 4, name: 'Guinea Pig', userAdded: false);
    createSpeciesType(speciesId: 5, name: 'Tortoise', userAdded: false);
    createSpeciesType(speciesId: 6, name: 'Turtle', userAdded: false);
    createSpeciesType(speciesId: 7, name: 'Lizard', userAdded: false);
    createSpeciesType(speciesId: 8, name: 'Snake', userAdded: false);
    createSpeciesType(speciesId: 9, name: 'Horse', userAdded: false);
    createSpeciesType(speciesId: 10, name: 'Donkey', userAdded: false);
    createSpeciesType(speciesId: 11, name: 'Ferret', userAdded: false);
    createSpeciesType(speciesId: 12, name: 'Hedgehog', userAdded: false);
    createSpeciesType(speciesId: 13, name: 'Chinchilla', userAdded: false);
    createSpeciesType(speciesId: 14, name: 'Gecko', userAdded: false);
    createSpeciesType(speciesId: 15, name: 'Iguana', userAdded: false);
    createSpeciesType(speciesId: 16, name: 'Chameleon', userAdded: false);
    createSpeciesType(speciesId: 17, name: 'Reptile', userAdded: false);
    createSpeciesType(speciesId: 18, name: 'Rodent', userAdded: false);
    createSpeciesType(speciesId: 19, name: 'Amphibian', userAdded: false);
    createSpeciesType(speciesId: 20, name: 'Farm Animal', userAdded: false);
    createSpeciesType(speciesId: 21, name: 'Other', userAdded: false);
  }

  // Populate the database with some test data
  Future<void> populateTestData() async {
    await clearAllData();
    await populateSpeciesTypes();

    await createPet(
      'Dog 1',
      1,
      'breed',
      'black',
      PetSex.male,
      1,
      DateTime(2025, 1, 1),
      false,
      true,
      'new diet',
      'new notes',
      'new history',
      false,
      null,
      PetStatus.active,
    );

    await createPet(
      'Cat 1',
      2,
      'breed',
      'brown',
      PetSex.female,
      3,
      DateTime(2022, 1, 1),
      false,
      true,
      'new diet',
      'new notes',
      'new history',
      true,
      DateTime(2023, 6, 6),
      PetStatus.active,
    );

    await createPet(
      'passed away',
      3,
      'breed',
      'brown',
      PetSex.unknown,
      2,
      DateTime(2023, 1, 1),
      false,
      true,
      'new diet',
      'new notes',
      'new history',
      false,
      null,
      PetStatus.deceased,
    );
  }

  // Provider for the database service
  // Note: Declared here as Provider.  If the database connection was to change
  // at some point (for example the database connection is reset and
  // reinitialised after a backup / restore) we would need to declare this as a
  // StateProvider instead.
  static final Provider<DatabaseService> provider = Provider((ref) {
    final database = DatabaseService();
    ref.onDispose(database.close);

    return database;
  });
}
