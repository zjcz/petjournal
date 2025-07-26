// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $SpeciesTypesTable extends SpeciesTypes
    with TableInfo<$SpeciesTypesTable, SpeciesType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _userAddedMeta = const VerificationMeta(
    'userAdded',
  );
  @override
  late final GeneratedColumn<bool> userAdded = GeneratedColumn<bool>(
    'user_added',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("user_added" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [speciesId, name, userAdded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('user_added')) {
      context.handle(
        _userAddedMeta,
        userAdded.isAcceptableOrUnknown(data['user_added']!, _userAddedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {speciesId};
  @override
  SpeciesType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesType(
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      userAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}user_added'],
      )!,
    );
  }

  @override
  $SpeciesTypesTable createAlias(String alias) {
    return $SpeciesTypesTable(attachedDatabase, alias);
  }
}

class SpeciesType extends DataClass implements Insertable<SpeciesType> {
  final int speciesId;
  final String name;
  final bool userAdded;
  const SpeciesType({
    required this.speciesId,
    required this.name,
    required this.userAdded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['species_id'] = Variable<int>(speciesId);
    map['name'] = Variable<String>(name);
    map['user_added'] = Variable<bool>(userAdded);
    return map;
  }

  SpeciesTypesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesTypesCompanion(
      speciesId: Value(speciesId),
      name: Value(name),
      userAdded: Value(userAdded),
    );
  }

  factory SpeciesType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesType(
      speciesId: serializer.fromJson<int>(json['speciesId']),
      name: serializer.fromJson<String>(json['name']),
      userAdded: serializer.fromJson<bool>(json['userAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'speciesId': serializer.toJson<int>(speciesId),
      'name': serializer.toJson<String>(name),
      'userAdded': serializer.toJson<bool>(userAdded),
    };
  }

  SpeciesType copyWith({int? speciesId, String? name, bool? userAdded}) =>
      SpeciesType(
        speciesId: speciesId ?? this.speciesId,
        name: name ?? this.name,
        userAdded: userAdded ?? this.userAdded,
      );
  SpeciesType copyWithCompanion(SpeciesTypesCompanion data) {
    return SpeciesType(
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      name: data.name.present ? data.name.value : this.name,
      userAdded: data.userAdded.present ? data.userAdded.value : this.userAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesType(')
          ..write('speciesId: $speciesId, ')
          ..write('name: $name, ')
          ..write('userAdded: $userAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(speciesId, name, userAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesType &&
          other.speciesId == this.speciesId &&
          other.name == this.name &&
          other.userAdded == this.userAdded);
}

class SpeciesTypesCompanion extends UpdateCompanion<SpeciesType> {
  final Value<int> speciesId;
  final Value<String> name;
  final Value<bool> userAdded;
  const SpeciesTypesCompanion({
    this.speciesId = const Value.absent(),
    this.name = const Value.absent(),
    this.userAdded = const Value.absent(),
  });
  SpeciesTypesCompanion.insert({
    this.speciesId = const Value.absent(),
    required String name,
    this.userAdded = const Value.absent(),
  }) : name = Value(name);
  static Insertable<SpeciesType> custom({
    Expression<int>? speciesId,
    Expression<String>? name,
    Expression<bool>? userAdded,
  }) {
    return RawValuesInsertable({
      if (speciesId != null) 'species_id': speciesId,
      if (name != null) 'name': name,
      if (userAdded != null) 'user_added': userAdded,
    });
  }

  SpeciesTypesCompanion copyWith({
    Value<int>? speciesId,
    Value<String>? name,
    Value<bool>? userAdded,
  }) {
    return SpeciesTypesCompanion(
      speciesId: speciesId ?? this.speciesId,
      name: name ?? this.name,
      userAdded: userAdded ?? this.userAdded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (userAdded.present) {
      map['user_added'] = Variable<bool>(userAdded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesTypesCompanion(')
          ..write('speciesId: $speciesId, ')
          ..write('name: $name, ')
          ..write('userAdded: $userAdded')
          ..write(')'))
        .toString();
  }
}

class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES species_types (species_id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colourMeta = const VerificationMeta('colour');
  @override
  late final GeneratedColumn<String> colour = GeneratedColumn<String>(
    'colour',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<int> sex = GeneratedColumn<int>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(PetSex.unknown.dataValue),
  );
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dobEstimateMeta = const VerificationMeta(
    'dobEstimate',
  );
  @override
  late final GeneratedColumn<bool> dobEstimate = GeneratedColumn<bool>(
    'dob_estimate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dob_estimate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dietMeta = const VerificationMeta('diet');
  @override
  late final GeneratedColumn<String> diet = GeneratedColumn<String>(
    'diet',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _historyMeta = const VerificationMeta(
    'history',
  );
  @override
  late final GeneratedColumn<String> history = GeneratedColumn<String>(
    'history',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNeuteredMeta = const VerificationMeta(
    'isNeutered',
  );
  @override
  late final GeneratedColumn<bool> isNeutered = GeneratedColumn<bool>(
    'is_neutered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_neutered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _neuterDateMeta = const VerificationMeta(
    'neuterDate',
  );
  @override
  late final GeneratedColumn<DateTime> neuterDate = GeneratedColumn<DateTime>(
    'neuter_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(PetStatus.active.dataValue),
  );
  static const VerificationMeta _statusDateMeta = const VerificationMeta(
    'statusDate',
  );
  @override
  late final GeneratedColumn<DateTime> statusDate = GeneratedColumn<DateTime>(
    'status_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isMicrochippedMeta = const VerificationMeta(
    'isMicrochipped',
  );
  @override
  late final GeneratedColumn<bool> isMicrochipped = GeneratedColumn<bool>(
    'is_microchipped',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_microchipped" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _microchipDateMeta = const VerificationMeta(
    'microchipDate',
  );
  @override
  late final GeneratedColumn<DateTime> microchipDate =
      GeneratedColumn<DateTime>(
        'microchip_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _microchipNotesMeta = const VerificationMeta(
    'microchipNotes',
  );
  @override
  late final GeneratedColumn<String> microchipNotes = GeneratedColumn<String>(
    'microchip_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _microchipNumberMeta = const VerificationMeta(
    'microchipNumber',
  );
  @override
  late final GeneratedColumn<String> microchipNumber = GeneratedColumn<String>(
    'microchip_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _microchipCompanyMeta = const VerificationMeta(
    'microchipCompany',
  );
  @override
  late final GeneratedColumn<String> microchipCompany = GeneratedColumn<String>(
    'microchip_company',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    petId,
    name,
    speciesId,
    breed,
    colour,
    sex,
    dob,
    dobEstimate,
    diet,
    notes,
    history,
    isNeutered,
    neuterDate,
    status,
    statusDate,
    isMicrochipped,
    microchipDate,
    microchipNotes,
    microchipNumber,
    microchipCompany,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('colour')) {
      context.handle(
        _colourMeta,
        colour.isAcceptableOrUnknown(data['colour']!, _colourMeta),
      );
    } else if (isInserting) {
      context.missing(_colourMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    }
    if (data.containsKey('dob_estimate')) {
      context.handle(
        _dobEstimateMeta,
        dobEstimate.isAcceptableOrUnknown(
          data['dob_estimate']!,
          _dobEstimateMeta,
        ),
      );
    }
    if (data.containsKey('diet')) {
      context.handle(
        _dietMeta,
        diet.isAcceptableOrUnknown(data['diet']!, _dietMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('history')) {
      context.handle(
        _historyMeta,
        history.isAcceptableOrUnknown(data['history']!, _historyMeta),
      );
    }
    if (data.containsKey('is_neutered')) {
      context.handle(
        _isNeuteredMeta,
        isNeutered.isAcceptableOrUnknown(data['is_neutered']!, _isNeuteredMeta),
      );
    }
    if (data.containsKey('neuter_date')) {
      context.handle(
        _neuterDateMeta,
        neuterDate.isAcceptableOrUnknown(data['neuter_date']!, _neuterDateMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('status_date')) {
      context.handle(
        _statusDateMeta,
        statusDate.isAcceptableOrUnknown(data['status_date']!, _statusDateMeta),
      );
    }
    if (data.containsKey('is_microchipped')) {
      context.handle(
        _isMicrochippedMeta,
        isMicrochipped.isAcceptableOrUnknown(
          data['is_microchipped']!,
          _isMicrochippedMeta,
        ),
      );
    }
    if (data.containsKey('microchip_date')) {
      context.handle(
        _microchipDateMeta,
        microchipDate.isAcceptableOrUnknown(
          data['microchip_date']!,
          _microchipDateMeta,
        ),
      );
    }
    if (data.containsKey('microchip_notes')) {
      context.handle(
        _microchipNotesMeta,
        microchipNotes.isAcceptableOrUnknown(
          data['microchip_notes']!,
          _microchipNotesMeta,
        ),
      );
    }
    if (data.containsKey('microchip_number')) {
      context.handle(
        _microchipNumberMeta,
        microchipNumber.isAcceptableOrUnknown(
          data['microchip_number']!,
          _microchipNumberMeta,
        ),
      );
    }
    if (data.containsKey('microchip_company')) {
      context.handle(
        _microchipCompanyMeta,
        microchipCompany.isAcceptableOrUnknown(
          data['microchip_company']!,
          _microchipCompanyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {petId};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      )!,
      colour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colour'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sex'],
      )!,
      dob: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dob'],
      ),
      dobEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dob_estimate'],
      )!,
      diet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diet'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      history: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}history'],
      ),
      isNeutered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_neutered'],
      )!,
      neuterDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}neuter_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      statusDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}status_date'],
      )!,
      isMicrochipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_microchipped'],
      ),
      microchipDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}microchip_date'],
      ),
      microchipNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}microchip_notes'],
      ),
      microchipNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}microchip_number'],
      ),
      microchipCompany: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}microchip_company'],
      ),
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final int petId;
  final String name;
  final int speciesId;
  final String breed;
  final String colour;
  final int sex;
  final DateTime? dob;
  final bool dobEstimate;
  final String? diet;
  final String? notes;
  final String? history;
  final bool isNeutered;
  final DateTime? neuterDate;
  final int status;
  final DateTime statusDate;
  final bool? isMicrochipped;
  final DateTime? microchipDate;
  final String? microchipNotes;
  final String? microchipNumber;
  final String? microchipCompany;
  const Pet({
    required this.petId,
    required this.name,
    required this.speciesId,
    required this.breed,
    required this.colour,
    required this.sex,
    this.dob,
    required this.dobEstimate,
    this.diet,
    this.notes,
    this.history,
    required this.isNeutered,
    this.neuterDate,
    required this.status,
    required this.statusDate,
    this.isMicrochipped,
    this.microchipDate,
    this.microchipNotes,
    this.microchipNumber,
    this.microchipCompany,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pet_id'] = Variable<int>(petId);
    map['name'] = Variable<String>(name);
    map['species_id'] = Variable<int>(speciesId);
    map['breed'] = Variable<String>(breed);
    map['colour'] = Variable<String>(colour);
    map['sex'] = Variable<int>(sex);
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    map['dob_estimate'] = Variable<bool>(dobEstimate);
    if (!nullToAbsent || diet != null) {
      map['diet'] = Variable<String>(diet);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || history != null) {
      map['history'] = Variable<String>(history);
    }
    map['is_neutered'] = Variable<bool>(isNeutered);
    if (!nullToAbsent || neuterDate != null) {
      map['neuter_date'] = Variable<DateTime>(neuterDate);
    }
    map['status'] = Variable<int>(status);
    map['status_date'] = Variable<DateTime>(statusDate);
    if (!nullToAbsent || isMicrochipped != null) {
      map['is_microchipped'] = Variable<bool>(isMicrochipped);
    }
    if (!nullToAbsent || microchipDate != null) {
      map['microchip_date'] = Variable<DateTime>(microchipDate);
    }
    if (!nullToAbsent || microchipNotes != null) {
      map['microchip_notes'] = Variable<String>(microchipNotes);
    }
    if (!nullToAbsent || microchipNumber != null) {
      map['microchip_number'] = Variable<String>(microchipNumber);
    }
    if (!nullToAbsent || microchipCompany != null) {
      map['microchip_company'] = Variable<String>(microchipCompany);
    }
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      petId: Value(petId),
      name: Value(name),
      speciesId: Value(speciesId),
      breed: Value(breed),
      colour: Value(colour),
      sex: Value(sex),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      dobEstimate: Value(dobEstimate),
      diet: diet == null && nullToAbsent ? const Value.absent() : Value(diet),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      history: history == null && nullToAbsent
          ? const Value.absent()
          : Value(history),
      isNeutered: Value(isNeutered),
      neuterDate: neuterDate == null && nullToAbsent
          ? const Value.absent()
          : Value(neuterDate),
      status: Value(status),
      statusDate: Value(statusDate),
      isMicrochipped: isMicrochipped == null && nullToAbsent
          ? const Value.absent()
          : Value(isMicrochipped),
      microchipDate: microchipDate == null && nullToAbsent
          ? const Value.absent()
          : Value(microchipDate),
      microchipNotes: microchipNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(microchipNotes),
      microchipNumber: microchipNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(microchipNumber),
      microchipCompany: microchipCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(microchipCompany),
    );
  }

  factory Pet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      petId: serializer.fromJson<int>(json['petId']),
      name: serializer.fromJson<String>(json['name']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      breed: serializer.fromJson<String>(json['breed']),
      colour: serializer.fromJson<String>(json['colour']),
      sex: serializer.fromJson<int>(json['sex']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      dobEstimate: serializer.fromJson<bool>(json['dobEstimate']),
      diet: serializer.fromJson<String?>(json['diet']),
      notes: serializer.fromJson<String?>(json['notes']),
      history: serializer.fromJson<String?>(json['history']),
      isNeutered: serializer.fromJson<bool>(json['isNeutered']),
      neuterDate: serializer.fromJson<DateTime?>(json['neuterDate']),
      status: serializer.fromJson<int>(json['status']),
      statusDate: serializer.fromJson<DateTime>(json['statusDate']),
      isMicrochipped: serializer.fromJson<bool?>(json['isMicrochipped']),
      microchipDate: serializer.fromJson<DateTime?>(json['microchipDate']),
      microchipNotes: serializer.fromJson<String?>(json['microchipNotes']),
      microchipNumber: serializer.fromJson<String?>(json['microchipNumber']),
      microchipCompany: serializer.fromJson<String?>(json['microchipCompany']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'petId': serializer.toJson<int>(petId),
      'name': serializer.toJson<String>(name),
      'speciesId': serializer.toJson<int>(speciesId),
      'breed': serializer.toJson<String>(breed),
      'colour': serializer.toJson<String>(colour),
      'sex': serializer.toJson<int>(sex),
      'dob': serializer.toJson<DateTime?>(dob),
      'dobEstimate': serializer.toJson<bool>(dobEstimate),
      'diet': serializer.toJson<String?>(diet),
      'notes': serializer.toJson<String?>(notes),
      'history': serializer.toJson<String?>(history),
      'isNeutered': serializer.toJson<bool>(isNeutered),
      'neuterDate': serializer.toJson<DateTime?>(neuterDate),
      'status': serializer.toJson<int>(status),
      'statusDate': serializer.toJson<DateTime>(statusDate),
      'isMicrochipped': serializer.toJson<bool?>(isMicrochipped),
      'microchipDate': serializer.toJson<DateTime?>(microchipDate),
      'microchipNotes': serializer.toJson<String?>(microchipNotes),
      'microchipNumber': serializer.toJson<String?>(microchipNumber),
      'microchipCompany': serializer.toJson<String?>(microchipCompany),
    };
  }

  Pet copyWith({
    int? petId,
    String? name,
    int? speciesId,
    String? breed,
    String? colour,
    int? sex,
    Value<DateTime?> dob = const Value.absent(),
    bool? dobEstimate,
    Value<String?> diet = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> history = const Value.absent(),
    bool? isNeutered,
    Value<DateTime?> neuterDate = const Value.absent(),
    int? status,
    DateTime? statusDate,
    Value<bool?> isMicrochipped = const Value.absent(),
    Value<DateTime?> microchipDate = const Value.absent(),
    Value<String?> microchipNotes = const Value.absent(),
    Value<String?> microchipNumber = const Value.absent(),
    Value<String?> microchipCompany = const Value.absent(),
  }) => Pet(
    petId: petId ?? this.petId,
    name: name ?? this.name,
    speciesId: speciesId ?? this.speciesId,
    breed: breed ?? this.breed,
    colour: colour ?? this.colour,
    sex: sex ?? this.sex,
    dob: dob.present ? dob.value : this.dob,
    dobEstimate: dobEstimate ?? this.dobEstimate,
    diet: diet.present ? diet.value : this.diet,
    notes: notes.present ? notes.value : this.notes,
    history: history.present ? history.value : this.history,
    isNeutered: isNeutered ?? this.isNeutered,
    neuterDate: neuterDate.present ? neuterDate.value : this.neuterDate,
    status: status ?? this.status,
    statusDate: statusDate ?? this.statusDate,
    isMicrochipped: isMicrochipped.present
        ? isMicrochipped.value
        : this.isMicrochipped,
    microchipDate: microchipDate.present
        ? microchipDate.value
        : this.microchipDate,
    microchipNotes: microchipNotes.present
        ? microchipNotes.value
        : this.microchipNotes,
    microchipNumber: microchipNumber.present
        ? microchipNumber.value
        : this.microchipNumber,
    microchipCompany: microchipCompany.present
        ? microchipCompany.value
        : this.microchipCompany,
  );
  Pet copyWithCompanion(PetsCompanion data) {
    return Pet(
      petId: data.petId.present ? data.petId.value : this.petId,
      name: data.name.present ? data.name.value : this.name,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      breed: data.breed.present ? data.breed.value : this.breed,
      colour: data.colour.present ? data.colour.value : this.colour,
      sex: data.sex.present ? data.sex.value : this.sex,
      dob: data.dob.present ? data.dob.value : this.dob,
      dobEstimate: data.dobEstimate.present
          ? data.dobEstimate.value
          : this.dobEstimate,
      diet: data.diet.present ? data.diet.value : this.diet,
      notes: data.notes.present ? data.notes.value : this.notes,
      history: data.history.present ? data.history.value : this.history,
      isNeutered: data.isNeutered.present
          ? data.isNeutered.value
          : this.isNeutered,
      neuterDate: data.neuterDate.present
          ? data.neuterDate.value
          : this.neuterDate,
      status: data.status.present ? data.status.value : this.status,
      statusDate: data.statusDate.present
          ? data.statusDate.value
          : this.statusDate,
      isMicrochipped: data.isMicrochipped.present
          ? data.isMicrochipped.value
          : this.isMicrochipped,
      microchipDate: data.microchipDate.present
          ? data.microchipDate.value
          : this.microchipDate,
      microchipNotes: data.microchipNotes.present
          ? data.microchipNotes.value
          : this.microchipNotes,
      microchipNumber: data.microchipNumber.present
          ? data.microchipNumber.value
          : this.microchipNumber,
      microchipCompany: data.microchipCompany.present
          ? data.microchipCompany.value
          : this.microchipCompany,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('speciesId: $speciesId, ')
          ..write('breed: $breed, ')
          ..write('colour: $colour, ')
          ..write('sex: $sex, ')
          ..write('dob: $dob, ')
          ..write('dobEstimate: $dobEstimate, ')
          ..write('diet: $diet, ')
          ..write('notes: $notes, ')
          ..write('history: $history, ')
          ..write('isNeutered: $isNeutered, ')
          ..write('neuterDate: $neuterDate, ')
          ..write('status: $status, ')
          ..write('statusDate: $statusDate, ')
          ..write('isMicrochipped: $isMicrochipped, ')
          ..write('microchipDate: $microchipDate, ')
          ..write('microchipNotes: $microchipNotes, ')
          ..write('microchipNumber: $microchipNumber, ')
          ..write('microchipCompany: $microchipCompany')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    petId,
    name,
    speciesId,
    breed,
    colour,
    sex,
    dob,
    dobEstimate,
    diet,
    notes,
    history,
    isNeutered,
    neuterDate,
    status,
    statusDate,
    isMicrochipped,
    microchipDate,
    microchipNotes,
    microchipNumber,
    microchipCompany,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.petId == this.petId &&
          other.name == this.name &&
          other.speciesId == this.speciesId &&
          other.breed == this.breed &&
          other.colour == this.colour &&
          other.sex == this.sex &&
          other.dob == this.dob &&
          other.dobEstimate == this.dobEstimate &&
          other.diet == this.diet &&
          other.notes == this.notes &&
          other.history == this.history &&
          other.isNeutered == this.isNeutered &&
          other.neuterDate == this.neuterDate &&
          other.status == this.status &&
          other.statusDate == this.statusDate &&
          other.isMicrochipped == this.isMicrochipped &&
          other.microchipDate == this.microchipDate &&
          other.microchipNotes == this.microchipNotes &&
          other.microchipNumber == this.microchipNumber &&
          other.microchipCompany == this.microchipCompany);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<int> petId;
  final Value<String> name;
  final Value<int> speciesId;
  final Value<String> breed;
  final Value<String> colour;
  final Value<int> sex;
  final Value<DateTime?> dob;
  final Value<bool> dobEstimate;
  final Value<String?> diet;
  final Value<String?> notes;
  final Value<String?> history;
  final Value<bool> isNeutered;
  final Value<DateTime?> neuterDate;
  final Value<int> status;
  final Value<DateTime> statusDate;
  final Value<bool?> isMicrochipped;
  final Value<DateTime?> microchipDate;
  final Value<String?> microchipNotes;
  final Value<String?> microchipNumber;
  final Value<String?> microchipCompany;
  const PetsCompanion({
    this.petId = const Value.absent(),
    this.name = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.breed = const Value.absent(),
    this.colour = const Value.absent(),
    this.sex = const Value.absent(),
    this.dob = const Value.absent(),
    this.dobEstimate = const Value.absent(),
    this.diet = const Value.absent(),
    this.notes = const Value.absent(),
    this.history = const Value.absent(),
    this.isNeutered = const Value.absent(),
    this.neuterDate = const Value.absent(),
    this.status = const Value.absent(),
    this.statusDate = const Value.absent(),
    this.isMicrochipped = const Value.absent(),
    this.microchipDate = const Value.absent(),
    this.microchipNotes = const Value.absent(),
    this.microchipNumber = const Value.absent(),
    this.microchipCompany = const Value.absent(),
  });
  PetsCompanion.insert({
    this.petId = const Value.absent(),
    required String name,
    required int speciesId,
    required String breed,
    required String colour,
    this.sex = const Value.absent(),
    this.dob = const Value.absent(),
    this.dobEstimate = const Value.absent(),
    this.diet = const Value.absent(),
    this.notes = const Value.absent(),
    this.history = const Value.absent(),
    this.isNeutered = const Value.absent(),
    this.neuterDate = const Value.absent(),
    this.status = const Value.absent(),
    this.statusDate = const Value.absent(),
    this.isMicrochipped = const Value.absent(),
    this.microchipDate = const Value.absent(),
    this.microchipNotes = const Value.absent(),
    this.microchipNumber = const Value.absent(),
    this.microchipCompany = const Value.absent(),
  }) : name = Value(name),
       speciesId = Value(speciesId),
       breed = Value(breed),
       colour = Value(colour);
  static Insertable<Pet> custom({
    Expression<int>? petId,
    Expression<String>? name,
    Expression<int>? speciesId,
    Expression<String>? breed,
    Expression<String>? colour,
    Expression<int>? sex,
    Expression<DateTime>? dob,
    Expression<bool>? dobEstimate,
    Expression<String>? diet,
    Expression<String>? notes,
    Expression<String>? history,
    Expression<bool>? isNeutered,
    Expression<DateTime>? neuterDate,
    Expression<int>? status,
    Expression<DateTime>? statusDate,
    Expression<bool>? isMicrochipped,
    Expression<DateTime>? microchipDate,
    Expression<String>? microchipNotes,
    Expression<String>? microchipNumber,
    Expression<String>? microchipCompany,
  }) {
    return RawValuesInsertable({
      if (petId != null) 'pet_id': petId,
      if (name != null) 'name': name,
      if (speciesId != null) 'species_id': speciesId,
      if (breed != null) 'breed': breed,
      if (colour != null) 'colour': colour,
      if (sex != null) 'sex': sex,
      if (dob != null) 'dob': dob,
      if (dobEstimate != null) 'dob_estimate': dobEstimate,
      if (diet != null) 'diet': diet,
      if (notes != null) 'notes': notes,
      if (history != null) 'history': history,
      if (isNeutered != null) 'is_neutered': isNeutered,
      if (neuterDate != null) 'neuter_date': neuterDate,
      if (status != null) 'status': status,
      if (statusDate != null) 'status_date': statusDate,
      if (isMicrochipped != null) 'is_microchipped': isMicrochipped,
      if (microchipDate != null) 'microchip_date': microchipDate,
      if (microchipNotes != null) 'microchip_notes': microchipNotes,
      if (microchipNumber != null) 'microchip_number': microchipNumber,
      if (microchipCompany != null) 'microchip_company': microchipCompany,
    });
  }

  PetsCompanion copyWith({
    Value<int>? petId,
    Value<String>? name,
    Value<int>? speciesId,
    Value<String>? breed,
    Value<String>? colour,
    Value<int>? sex,
    Value<DateTime?>? dob,
    Value<bool>? dobEstimate,
    Value<String?>? diet,
    Value<String?>? notes,
    Value<String?>? history,
    Value<bool>? isNeutered,
    Value<DateTime?>? neuterDate,
    Value<int>? status,
    Value<DateTime>? statusDate,
    Value<bool?>? isMicrochipped,
    Value<DateTime?>? microchipDate,
    Value<String?>? microchipNotes,
    Value<String?>? microchipNumber,
    Value<String?>? microchipCompany,
  }) {
    return PetsCompanion(
      petId: petId ?? this.petId,
      name: name ?? this.name,
      speciesId: speciesId ?? this.speciesId,
      breed: breed ?? this.breed,
      colour: colour ?? this.colour,
      sex: sex ?? this.sex,
      dob: dob ?? this.dob,
      dobEstimate: dobEstimate ?? this.dobEstimate,
      diet: diet ?? this.diet,
      notes: notes ?? this.notes,
      history: history ?? this.history,
      isNeutered: isNeutered ?? this.isNeutered,
      neuterDate: neuterDate ?? this.neuterDate,
      status: status ?? this.status,
      statusDate: statusDate ?? this.statusDate,
      isMicrochipped: isMicrochipped ?? this.isMicrochipped,
      microchipDate: microchipDate ?? this.microchipDate,
      microchipNotes: microchipNotes ?? this.microchipNotes,
      microchipNumber: microchipNumber ?? this.microchipNumber,
      microchipCompany: microchipCompany ?? this.microchipCompany,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (colour.present) {
      map['colour'] = Variable<String>(colour.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>(sex.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (dobEstimate.present) {
      map['dob_estimate'] = Variable<bool>(dobEstimate.value);
    }
    if (diet.present) {
      map['diet'] = Variable<String>(diet.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (history.present) {
      map['history'] = Variable<String>(history.value);
    }
    if (isNeutered.present) {
      map['is_neutered'] = Variable<bool>(isNeutered.value);
    }
    if (neuterDate.present) {
      map['neuter_date'] = Variable<DateTime>(neuterDate.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (statusDate.present) {
      map['status_date'] = Variable<DateTime>(statusDate.value);
    }
    if (isMicrochipped.present) {
      map['is_microchipped'] = Variable<bool>(isMicrochipped.value);
    }
    if (microchipDate.present) {
      map['microchip_date'] = Variable<DateTime>(microchipDate.value);
    }
    if (microchipNotes.present) {
      map['microchip_notes'] = Variable<String>(microchipNotes.value);
    }
    if (microchipNumber.present) {
      map['microchip_number'] = Variable<String>(microchipNumber.value);
    }
    if (microchipCompany.present) {
      map['microchip_company'] = Variable<String>(microchipCompany.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('speciesId: $speciesId, ')
          ..write('breed: $breed, ')
          ..write('colour: $colour, ')
          ..write('sex: $sex, ')
          ..write('dob: $dob, ')
          ..write('dobEstimate: $dobEstimate, ')
          ..write('diet: $diet, ')
          ..write('notes: $notes, ')
          ..write('history: $history, ')
          ..write('isNeutered: $isNeutered, ')
          ..write('neuterDate: $neuterDate, ')
          ..write('status: $status, ')
          ..write('statusDate: $statusDate, ')
          ..write('isMicrochipped: $isMicrochipped, ')
          ..write('microchipDate: $microchipDate, ')
          ..write('microchipNotes: $microchipNotes, ')
          ..write('microchipNumber: $microchipNumber, ')
          ..write('microchipCompany: $microchipCompany')
          ..write(')'))
        .toString();
  }
}

class $PetMedsTable extends PetMeds with TableInfo<$PetMedsTable, PetMed> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetMedsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _petMedIdMeta = const VerificationMeta(
    'petMedId',
  );
  @override
  late final GeneratedColumn<int> petMedId = GeneratedColumn<int>(
    'pet_med_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petMeta = const VerificationMeta('pet');
  @override
  late final GeneratedColumn<int> pet = GeneratedColumn<int>(
    'pet',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (pet_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<String> dose = GeneratedColumn<String>(
    'dose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    petMedId,
    pet,
    name,
    dose,
    startDate,
    endDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_meds';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetMed> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pet_med_id')) {
      context.handle(
        _petMedIdMeta,
        petMedId.isAcceptableOrUnknown(data['pet_med_id']!, _petMedIdMeta),
      );
    }
    if (data.containsKey('pet')) {
      context.handle(
        _petMeta,
        pet.isAcceptableOrUnknown(data['pet']!, _petMeta),
      );
    } else if (isInserting) {
      context.missing(_petMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    } else if (isInserting) {
      context.missing(_doseMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {petMedId};
  @override
  PetMed map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetMed(
      petMedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_med_id'],
      )!,
      pet: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PetMedsTable createAlias(String alias) {
    return $PetMedsTable(attachedDatabase, alias);
  }
}

class PetMed extends DataClass implements Insertable<PetMed> {
  final int petMedId;
  final int pet;
  final String name;
  final String dose;
  final DateTime startDate;
  final DateTime? endDate;
  final String? notes;
  const PetMed({
    required this.petMedId,
    required this.pet,
    required this.name,
    required this.dose,
    required this.startDate,
    this.endDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pet_med_id'] = Variable<int>(petMedId);
    map['pet'] = Variable<int>(pet);
    map['name'] = Variable<String>(name);
    map['dose'] = Variable<String>(dose);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PetMedsCompanion toCompanion(bool nullToAbsent) {
    return PetMedsCompanion(
      petMedId: Value(petMedId),
      pet: Value(pet),
      name: Value(name),
      dose: Value(dose),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PetMed.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetMed(
      petMedId: serializer.fromJson<int>(json['petMedId']),
      pet: serializer.fromJson<int>(json['pet']),
      name: serializer.fromJson<String>(json['name']),
      dose: serializer.fromJson<String>(json['dose']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'petMedId': serializer.toJson<int>(petMedId),
      'pet': serializer.toJson<int>(pet),
      'name': serializer.toJson<String>(name),
      'dose': serializer.toJson<String>(dose),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PetMed copyWith({
    int? petMedId,
    int? pet,
    String? name,
    String? dose,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => PetMed(
    petMedId: petMedId ?? this.petMedId,
    pet: pet ?? this.pet,
    name: name ?? this.name,
    dose: dose ?? this.dose,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    notes: notes.present ? notes.value : this.notes,
  );
  PetMed copyWithCompanion(PetMedsCompanion data) {
    return PetMed(
      petMedId: data.petMedId.present ? data.petMedId.value : this.petMedId,
      pet: data.pet.present ? data.pet.value : this.pet,
      name: data.name.present ? data.name.value : this.name,
      dose: data.dose.present ? data.dose.value : this.dose,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetMed(')
          ..write('petMedId: $petMedId, ')
          ..write('pet: $pet, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(petMedId, pet, name, dose, startDate, endDate, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetMed &&
          other.petMedId == this.petMedId &&
          other.pet == this.pet &&
          other.name == this.name &&
          other.dose == this.dose &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.notes == this.notes);
}

class PetMedsCompanion extends UpdateCompanion<PetMed> {
  final Value<int> petMedId;
  final Value<int> pet;
  final Value<String> name;
  final Value<String> dose;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> notes;
  const PetMedsCompanion({
    this.petMedId = const Value.absent(),
    this.pet = const Value.absent(),
    this.name = const Value.absent(),
    this.dose = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PetMedsCompanion.insert({
    this.petMedId = const Value.absent(),
    required int pet,
    required String name,
    required String dose,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.notes = const Value.absent(),
  }) : pet = Value(pet),
       name = Value(name),
       dose = Value(dose),
       startDate = Value(startDate);
  static Insertable<PetMed> custom({
    Expression<int>? petMedId,
    Expression<int>? pet,
    Expression<String>? name,
    Expression<String>? dose,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (petMedId != null) 'pet_med_id': petMedId,
      if (pet != null) 'pet': pet,
      if (name != null) 'name': name,
      if (dose != null) 'dose': dose,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (notes != null) 'notes': notes,
    });
  }

  PetMedsCompanion copyWith({
    Value<int>? petMedId,
    Value<int>? pet,
    Value<String>? name,
    Value<String>? dose,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<String?>? notes,
  }) {
    return PetMedsCompanion(
      petMedId: petMedId ?? this.petMedId,
      pet: pet ?? this.pet,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (petMedId.present) {
      map['pet_med_id'] = Variable<int>(petMedId.value);
    }
    if (pet.present) {
      map['pet'] = Variable<int>(pet.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dose.present) {
      map['dose'] = Variable<String>(dose.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetMedsCompanion(')
          ..write('petMedId: $petMedId, ')
          ..write('pet: $pet, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PetVaccinationsTable extends PetVaccinations
    with TableInfo<$PetVaccinationsTable, PetVaccination> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetVaccinationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _petVaccinationIdMeta = const VerificationMeta(
    'petVaccinationId',
  );
  @override
  late final GeneratedColumn<int> petVaccinationId = GeneratedColumn<int>(
    'pet_vaccination_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petMeta = const VerificationMeta('pet');
  @override
  late final GeneratedColumn<int> pet = GeneratedColumn<int>(
    'pet',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (pet_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _administeredDateMeta = const VerificationMeta(
    'administeredDate',
  );
  @override
  late final GeneratedColumn<DateTime> administeredDate =
      GeneratedColumn<DateTime>(
        'administered_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDateMeta = const VerificationMeta(
    'reminderDate',
  );
  @override
  late final GeneratedColumn<DateTime> reminderDate = GeneratedColumn<DateTime>(
    'reminder_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vaccineBatchNumberMeta =
      const VerificationMeta('vaccineBatchNumber');
  @override
  late final GeneratedColumn<String> vaccineBatchNumber =
      GeneratedColumn<String>(
        'vaccine_batch_number',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _vaccineManufacturerMeta =
      const VerificationMeta('vaccineManufacturer');
  @override
  late final GeneratedColumn<String> vaccineManufacturer =
      GeneratedColumn<String>(
        'vaccine_manufacturer',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _administeredByMeta = const VerificationMeta(
    'administeredBy',
  );
  @override
  late final GeneratedColumn<String> administeredBy = GeneratedColumn<String>(
    'administered_by',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    petVaccinationId,
    pet,
    name,
    administeredDate,
    expiryDate,
    reminderDate,
    notes,
    vaccineBatchNumber,
    vaccineManufacturer,
    administeredBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_vaccinations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetVaccination> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pet_vaccination_id')) {
      context.handle(
        _petVaccinationIdMeta,
        petVaccinationId.isAcceptableOrUnknown(
          data['pet_vaccination_id']!,
          _petVaccinationIdMeta,
        ),
      );
    }
    if (data.containsKey('pet')) {
      context.handle(
        _petMeta,
        pet.isAcceptableOrUnknown(data['pet']!, _petMeta),
      );
    } else if (isInserting) {
      context.missing(_petMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('administered_date')) {
      context.handle(
        _administeredDateMeta,
        administeredDate.isAcceptableOrUnknown(
          data['administered_date']!,
          _administeredDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_administeredDateMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('reminder_date')) {
      context.handle(
        _reminderDateMeta,
        reminderDate.isAcceptableOrUnknown(
          data['reminder_date']!,
          _reminderDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('vaccine_batch_number')) {
      context.handle(
        _vaccineBatchNumberMeta,
        vaccineBatchNumber.isAcceptableOrUnknown(
          data['vaccine_batch_number']!,
          _vaccineBatchNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vaccineBatchNumberMeta);
    }
    if (data.containsKey('vaccine_manufacturer')) {
      context.handle(
        _vaccineManufacturerMeta,
        vaccineManufacturer.isAcceptableOrUnknown(
          data['vaccine_manufacturer']!,
          _vaccineManufacturerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vaccineManufacturerMeta);
    }
    if (data.containsKey('administered_by')) {
      context.handle(
        _administeredByMeta,
        administeredBy.isAcceptableOrUnknown(
          data['administered_by']!,
          _administeredByMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_administeredByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {petVaccinationId};
  @override
  PetVaccination map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetVaccination(
      petVaccinationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_vaccination_id'],
      )!,
      pet: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      administeredDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}administered_date'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
      reminderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      vaccineBatchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vaccine_batch_number'],
      )!,
      vaccineManufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vaccine_manufacturer'],
      )!,
      administeredBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}administered_by'],
      )!,
    );
  }

  @override
  $PetVaccinationsTable createAlias(String alias) {
    return $PetVaccinationsTable(attachedDatabase, alias);
  }
}

class PetVaccination extends DataClass implements Insertable<PetVaccination> {
  final int petVaccinationId;
  final int pet;
  final String name;
  final DateTime administeredDate;
  final DateTime? expiryDate;
  final DateTime? reminderDate;
  final String? notes;
  final String vaccineBatchNumber;
  final String vaccineManufacturer;
  final String administeredBy;
  const PetVaccination({
    required this.petVaccinationId,
    required this.pet,
    required this.name,
    required this.administeredDate,
    this.expiryDate,
    this.reminderDate,
    this.notes,
    required this.vaccineBatchNumber,
    required this.vaccineManufacturer,
    required this.administeredBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pet_vaccination_id'] = Variable<int>(petVaccinationId);
    map['pet'] = Variable<int>(pet);
    map['name'] = Variable<String>(name);
    map['administered_date'] = Variable<DateTime>(administeredDate);
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    if (!nullToAbsent || reminderDate != null) {
      map['reminder_date'] = Variable<DateTime>(reminderDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['vaccine_batch_number'] = Variable<String>(vaccineBatchNumber);
    map['vaccine_manufacturer'] = Variable<String>(vaccineManufacturer);
    map['administered_by'] = Variable<String>(administeredBy);
    return map;
  }

  PetVaccinationsCompanion toCompanion(bool nullToAbsent) {
    return PetVaccinationsCompanion(
      petVaccinationId: Value(petVaccinationId),
      pet: Value(pet),
      name: Value(name),
      administeredDate: Value(administeredDate),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      reminderDate: reminderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      vaccineBatchNumber: Value(vaccineBatchNumber),
      vaccineManufacturer: Value(vaccineManufacturer),
      administeredBy: Value(administeredBy),
    );
  }

  factory PetVaccination.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetVaccination(
      petVaccinationId: serializer.fromJson<int>(json['petVaccinationId']),
      pet: serializer.fromJson<int>(json['pet']),
      name: serializer.fromJson<String>(json['name']),
      administeredDate: serializer.fromJson<DateTime>(json['administeredDate']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      reminderDate: serializer.fromJson<DateTime?>(json['reminderDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      vaccineBatchNumber: serializer.fromJson<String>(
        json['vaccineBatchNumber'],
      ),
      vaccineManufacturer: serializer.fromJson<String>(
        json['vaccineManufacturer'],
      ),
      administeredBy: serializer.fromJson<String>(json['administeredBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'petVaccinationId': serializer.toJson<int>(petVaccinationId),
      'pet': serializer.toJson<int>(pet),
      'name': serializer.toJson<String>(name),
      'administeredDate': serializer.toJson<DateTime>(administeredDate),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'reminderDate': serializer.toJson<DateTime?>(reminderDate),
      'notes': serializer.toJson<String?>(notes),
      'vaccineBatchNumber': serializer.toJson<String>(vaccineBatchNumber),
      'vaccineManufacturer': serializer.toJson<String>(vaccineManufacturer),
      'administeredBy': serializer.toJson<String>(administeredBy),
    };
  }

  PetVaccination copyWith({
    int? petVaccinationId,
    int? pet,
    String? name,
    DateTime? administeredDate,
    Value<DateTime?> expiryDate = const Value.absent(),
    Value<DateTime?> reminderDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? vaccineBatchNumber,
    String? vaccineManufacturer,
    String? administeredBy,
  }) => PetVaccination(
    petVaccinationId: petVaccinationId ?? this.petVaccinationId,
    pet: pet ?? this.pet,
    name: name ?? this.name,
    administeredDate: administeredDate ?? this.administeredDate,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    reminderDate: reminderDate.present ? reminderDate.value : this.reminderDate,
    notes: notes.present ? notes.value : this.notes,
    vaccineBatchNumber: vaccineBatchNumber ?? this.vaccineBatchNumber,
    vaccineManufacturer: vaccineManufacturer ?? this.vaccineManufacturer,
    administeredBy: administeredBy ?? this.administeredBy,
  );
  PetVaccination copyWithCompanion(PetVaccinationsCompanion data) {
    return PetVaccination(
      petVaccinationId: data.petVaccinationId.present
          ? data.petVaccinationId.value
          : this.petVaccinationId,
      pet: data.pet.present ? data.pet.value : this.pet,
      name: data.name.present ? data.name.value : this.name,
      administeredDate: data.administeredDate.present
          ? data.administeredDate.value
          : this.administeredDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      reminderDate: data.reminderDate.present
          ? data.reminderDate.value
          : this.reminderDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      vaccineBatchNumber: data.vaccineBatchNumber.present
          ? data.vaccineBatchNumber.value
          : this.vaccineBatchNumber,
      vaccineManufacturer: data.vaccineManufacturer.present
          ? data.vaccineManufacturer.value
          : this.vaccineManufacturer,
      administeredBy: data.administeredBy.present
          ? data.administeredBy.value
          : this.administeredBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetVaccination(')
          ..write('petVaccinationId: $petVaccinationId, ')
          ..write('pet: $pet, ')
          ..write('name: $name, ')
          ..write('administeredDate: $administeredDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('notes: $notes, ')
          ..write('vaccineBatchNumber: $vaccineBatchNumber, ')
          ..write('vaccineManufacturer: $vaccineManufacturer, ')
          ..write('administeredBy: $administeredBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    petVaccinationId,
    pet,
    name,
    administeredDate,
    expiryDate,
    reminderDate,
    notes,
    vaccineBatchNumber,
    vaccineManufacturer,
    administeredBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetVaccination &&
          other.petVaccinationId == this.petVaccinationId &&
          other.pet == this.pet &&
          other.name == this.name &&
          other.administeredDate == this.administeredDate &&
          other.expiryDate == this.expiryDate &&
          other.reminderDate == this.reminderDate &&
          other.notes == this.notes &&
          other.vaccineBatchNumber == this.vaccineBatchNumber &&
          other.vaccineManufacturer == this.vaccineManufacturer &&
          other.administeredBy == this.administeredBy);
}

class PetVaccinationsCompanion extends UpdateCompanion<PetVaccination> {
  final Value<int> petVaccinationId;
  final Value<int> pet;
  final Value<String> name;
  final Value<DateTime> administeredDate;
  final Value<DateTime?> expiryDate;
  final Value<DateTime?> reminderDate;
  final Value<String?> notes;
  final Value<String> vaccineBatchNumber;
  final Value<String> vaccineManufacturer;
  final Value<String> administeredBy;
  const PetVaccinationsCompanion({
    this.petVaccinationId = const Value.absent(),
    this.pet = const Value.absent(),
    this.name = const Value.absent(),
    this.administeredDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.vaccineBatchNumber = const Value.absent(),
    this.vaccineManufacturer = const Value.absent(),
    this.administeredBy = const Value.absent(),
  });
  PetVaccinationsCompanion.insert({
    this.petVaccinationId = const Value.absent(),
    required int pet,
    required String name,
    required DateTime administeredDate,
    this.expiryDate = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.notes = const Value.absent(),
    required String vaccineBatchNumber,
    required String vaccineManufacturer,
    required String administeredBy,
  }) : pet = Value(pet),
       name = Value(name),
       administeredDate = Value(administeredDate),
       vaccineBatchNumber = Value(vaccineBatchNumber),
       vaccineManufacturer = Value(vaccineManufacturer),
       administeredBy = Value(administeredBy);
  static Insertable<PetVaccination> custom({
    Expression<int>? petVaccinationId,
    Expression<int>? pet,
    Expression<String>? name,
    Expression<DateTime>? administeredDate,
    Expression<DateTime>? expiryDate,
    Expression<DateTime>? reminderDate,
    Expression<String>? notes,
    Expression<String>? vaccineBatchNumber,
    Expression<String>? vaccineManufacturer,
    Expression<String>? administeredBy,
  }) {
    return RawValuesInsertable({
      if (petVaccinationId != null) 'pet_vaccination_id': petVaccinationId,
      if (pet != null) 'pet': pet,
      if (name != null) 'name': name,
      if (administeredDate != null) 'administered_date': administeredDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (reminderDate != null) 'reminder_date': reminderDate,
      if (notes != null) 'notes': notes,
      if (vaccineBatchNumber != null)
        'vaccine_batch_number': vaccineBatchNumber,
      if (vaccineManufacturer != null)
        'vaccine_manufacturer': vaccineManufacturer,
      if (administeredBy != null) 'administered_by': administeredBy,
    });
  }

  PetVaccinationsCompanion copyWith({
    Value<int>? petVaccinationId,
    Value<int>? pet,
    Value<String>? name,
    Value<DateTime>? administeredDate,
    Value<DateTime?>? expiryDate,
    Value<DateTime?>? reminderDate,
    Value<String?>? notes,
    Value<String>? vaccineBatchNumber,
    Value<String>? vaccineManufacturer,
    Value<String>? administeredBy,
  }) {
    return PetVaccinationsCompanion(
      petVaccinationId: petVaccinationId ?? this.petVaccinationId,
      pet: pet ?? this.pet,
      name: name ?? this.name,
      administeredDate: administeredDate ?? this.administeredDate,
      expiryDate: expiryDate ?? this.expiryDate,
      reminderDate: reminderDate ?? this.reminderDate,
      notes: notes ?? this.notes,
      vaccineBatchNumber: vaccineBatchNumber ?? this.vaccineBatchNumber,
      vaccineManufacturer: vaccineManufacturer ?? this.vaccineManufacturer,
      administeredBy: administeredBy ?? this.administeredBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (petVaccinationId.present) {
      map['pet_vaccination_id'] = Variable<int>(petVaccinationId.value);
    }
    if (pet.present) {
      map['pet'] = Variable<int>(pet.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (administeredDate.present) {
      map['administered_date'] = Variable<DateTime>(administeredDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (reminderDate.present) {
      map['reminder_date'] = Variable<DateTime>(reminderDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (vaccineBatchNumber.present) {
      map['vaccine_batch_number'] = Variable<String>(vaccineBatchNumber.value);
    }
    if (vaccineManufacturer.present) {
      map['vaccine_manufacturer'] = Variable<String>(vaccineManufacturer.value);
    }
    if (administeredBy.present) {
      map['administered_by'] = Variable<String>(administeredBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetVaccinationsCompanion(')
          ..write('petVaccinationId: $petVaccinationId, ')
          ..write('pet: $pet, ')
          ..write('name: $name, ')
          ..write('administeredDate: $administeredDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('notes: $notes, ')
          ..write('vaccineBatchNumber: $vaccineBatchNumber, ')
          ..write('vaccineManufacturer: $vaccineManufacturer, ')
          ..write('administeredBy: $administeredBy')
          ..write(')'))
        .toString();
  }
}

class $PetWeightsTable extends PetWeights
    with TableInfo<$PetWeightsTable, PetWeight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetWeightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _petWeightIdMeta = const VerificationMeta(
    'petWeightId',
  );
  @override
  late final GeneratedColumn<int> petWeightId = GeneratedColumn<int>(
    'pet_weight_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petMeta = const VerificationMeta('pet');
  @override
  late final GeneratedColumn<int> pet = GeneratedColumn<int>(
    'pet',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (pet_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightUnitMeta = const VerificationMeta(
    'weightUnit',
  );
  @override
  late final GeneratedColumn<int> weightUnit = GeneratedColumn<int>(
    'weight_unit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(WeightUnits.metric.dataValue),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    petWeightId,
    pet,
    date,
    weight,
    weightUnit,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_weights';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetWeight> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pet_weight_id')) {
      context.handle(
        _petWeightIdMeta,
        petWeightId.isAcceptableOrUnknown(
          data['pet_weight_id']!,
          _petWeightIdMeta,
        ),
      );
    }
    if (data.containsKey('pet')) {
      context.handle(
        _petMeta,
        pet.isAcceptableOrUnknown(data['pet']!, _petMeta),
      );
    } else if (isInserting) {
      context.missing(_petMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('weight_unit')) {
      context.handle(
        _weightUnitMeta,
        weightUnit.isAcceptableOrUnknown(data['weight_unit']!, _weightUnitMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {petWeightId};
  @override
  PetWeight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetWeight(
      petWeightId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_weight_id'],
      )!,
      pet: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      weightUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight_unit'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PetWeightsTable createAlias(String alias) {
    return $PetWeightsTable(attachedDatabase, alias);
  }
}

class PetWeight extends DataClass implements Insertable<PetWeight> {
  final int petWeightId;
  final int pet;
  final DateTime date;
  final double weight;
  final int weightUnit;
  final String? notes;
  const PetWeight({
    required this.petWeightId,
    required this.pet,
    required this.date,
    required this.weight,
    required this.weightUnit,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pet_weight_id'] = Variable<int>(petWeightId);
    map['pet'] = Variable<int>(pet);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    map['weight_unit'] = Variable<int>(weightUnit);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PetWeightsCompanion toCompanion(bool nullToAbsent) {
    return PetWeightsCompanion(
      petWeightId: Value(petWeightId),
      pet: Value(pet),
      date: Value(date),
      weight: Value(weight),
      weightUnit: Value(weightUnit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PetWeight.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetWeight(
      petWeightId: serializer.fromJson<int>(json['petWeightId']),
      pet: serializer.fromJson<int>(json['pet']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      weightUnit: serializer.fromJson<int>(json['weightUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'petWeightId': serializer.toJson<int>(petWeightId),
      'pet': serializer.toJson<int>(pet),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'weightUnit': serializer.toJson<int>(weightUnit),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PetWeight copyWith({
    int? petWeightId,
    int? pet,
    DateTime? date,
    double? weight,
    int? weightUnit,
    Value<String?> notes = const Value.absent(),
  }) => PetWeight(
    petWeightId: petWeightId ?? this.petWeightId,
    pet: pet ?? this.pet,
    date: date ?? this.date,
    weight: weight ?? this.weight,
    weightUnit: weightUnit ?? this.weightUnit,
    notes: notes.present ? notes.value : this.notes,
  );
  PetWeight copyWithCompanion(PetWeightsCompanion data) {
    return PetWeight(
      petWeightId: data.petWeightId.present
          ? data.petWeightId.value
          : this.petWeightId,
      pet: data.pet.present ? data.pet.value : this.pet,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      weightUnit: data.weightUnit.present
          ? data.weightUnit.value
          : this.weightUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetWeight(')
          ..write('petWeightId: $petWeightId, ')
          ..write('pet: $pet, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(petWeightId, pet, date, weight, weightUnit, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetWeight &&
          other.petWeightId == this.petWeightId &&
          other.pet == this.pet &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.weightUnit == this.weightUnit &&
          other.notes == this.notes);
}

class PetWeightsCompanion extends UpdateCompanion<PetWeight> {
  final Value<int> petWeightId;
  final Value<int> pet;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<int> weightUnit;
  final Value<String?> notes;
  const PetWeightsCompanion({
    this.petWeightId = const Value.absent(),
    this.pet = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.weightUnit = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PetWeightsCompanion.insert({
    this.petWeightId = const Value.absent(),
    required int pet,
    required DateTime date,
    required double weight,
    this.weightUnit = const Value.absent(),
    this.notes = const Value.absent(),
  }) : pet = Value(pet),
       date = Value(date),
       weight = Value(weight);
  static Insertable<PetWeight> custom({
    Expression<int>? petWeightId,
    Expression<int>? pet,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<int>? weightUnit,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (petWeightId != null) 'pet_weight_id': petWeightId,
      if (pet != null) 'pet': pet,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (weightUnit != null) 'weight_unit': weightUnit,
      if (notes != null) 'notes': notes,
    });
  }

  PetWeightsCompanion copyWith({
    Value<int>? petWeightId,
    Value<int>? pet,
    Value<DateTime>? date,
    Value<double>? weight,
    Value<int>? weightUnit,
    Value<String?>? notes,
  }) {
    return PetWeightsCompanion(
      petWeightId: petWeightId ?? this.petWeightId,
      pet: pet ?? this.pet,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (petWeightId.present) {
      map['pet_weight_id'] = Variable<int>(petWeightId.value);
    }
    if (pet.present) {
      map['pet'] = Variable<int>(pet.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (weightUnit.present) {
      map['weight_unit'] = Variable<int>(weightUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetWeightsCompanion(')
          ..write('petWeightId: $petWeightId, ')
          ..write('pet: $pet, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _journalEntryIdMeta = const VerificationMeta(
    'journalEntryId',
  );
  @override
  late final GeneratedColumn<int> journalEntryId = GeneratedColumn<int>(
    'journal_entry_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entryTextMeta = const VerificationMeta(
    'entryText',
  );
  @override
  late final GeneratedColumn<String> entryText = GeneratedColumn<String>(
    'entry_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdDateTimeMeta = const VerificationMeta(
    'createdDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> createdDateTime =
      GeneratedColumn<DateTime>(
        'created_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _lastUpdatedDateTimeMeta =
      const VerificationMeta('lastUpdatedDateTime');
  @override
  late final GeneratedColumn<DateTime> lastUpdatedDateTime =
      GeneratedColumn<DateTime>(
        'last_updated_date_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    journalEntryId,
    entryText,
    createdDateTime,
    lastUpdatedDateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('journal_entry_id')) {
      context.handle(
        _journalEntryIdMeta,
        journalEntryId.isAcceptableOrUnknown(
          data['journal_entry_id']!,
          _journalEntryIdMeta,
        ),
      );
    }
    if (data.containsKey('entry_text')) {
      context.handle(
        _entryTextMeta,
        entryText.isAcceptableOrUnknown(data['entry_text']!, _entryTextMeta),
      );
    } else if (isInserting) {
      context.missing(_entryTextMeta);
    }
    if (data.containsKey('created_date_time')) {
      context.handle(
        _createdDateTimeMeta,
        createdDateTime.isAcceptableOrUnknown(
          data['created_date_time']!,
          _createdDateTimeMeta,
        ),
      );
    }
    if (data.containsKey('last_updated_date_time')) {
      context.handle(
        _lastUpdatedDateTimeMeta,
        lastUpdatedDateTime.isAcceptableOrUnknown(
          data['last_updated_date_time']!,
          _lastUpdatedDateTimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {journalEntryId};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      journalEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entry_id'],
      )!,
      entryText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_text'],
      )!,
      createdDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date_time'],
      )!,
      lastUpdatedDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date_time'],
      ),
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int journalEntryId;
  final String entryText;
  final DateTime createdDateTime;
  final DateTime? lastUpdatedDateTime;
  const JournalEntry({
    required this.journalEntryId,
    required this.entryText,
    required this.createdDateTime,
    this.lastUpdatedDateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['journal_entry_id'] = Variable<int>(journalEntryId);
    map['entry_text'] = Variable<String>(entryText);
    map['created_date_time'] = Variable<DateTime>(createdDateTime);
    if (!nullToAbsent || lastUpdatedDateTime != null) {
      map['last_updated_date_time'] = Variable<DateTime>(lastUpdatedDateTime);
    }
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      journalEntryId: Value(journalEntryId),
      entryText: Value(entryText),
      createdDateTime: Value(createdDateTime),
      lastUpdatedDateTime: lastUpdatedDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDateTime),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      journalEntryId: serializer.fromJson<int>(json['journalEntryId']),
      entryText: serializer.fromJson<String>(json['entryText']),
      createdDateTime: serializer.fromJson<DateTime>(json['createdDateTime']),
      lastUpdatedDateTime: serializer.fromJson<DateTime?>(
        json['lastUpdatedDateTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'journalEntryId': serializer.toJson<int>(journalEntryId),
      'entryText': serializer.toJson<String>(entryText),
      'createdDateTime': serializer.toJson<DateTime>(createdDateTime),
      'lastUpdatedDateTime': serializer.toJson<DateTime?>(lastUpdatedDateTime),
    };
  }

  JournalEntry copyWith({
    int? journalEntryId,
    String? entryText,
    DateTime? createdDateTime,
    Value<DateTime?> lastUpdatedDateTime = const Value.absent(),
  }) => JournalEntry(
    journalEntryId: journalEntryId ?? this.journalEntryId,
    entryText: entryText ?? this.entryText,
    createdDateTime: createdDateTime ?? this.createdDateTime,
    lastUpdatedDateTime: lastUpdatedDateTime.present
        ? lastUpdatedDateTime.value
        : this.lastUpdatedDateTime,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      journalEntryId: data.journalEntryId.present
          ? data.journalEntryId.value
          : this.journalEntryId,
      entryText: data.entryText.present ? data.entryText.value : this.entryText,
      createdDateTime: data.createdDateTime.present
          ? data.createdDateTime.value
          : this.createdDateTime,
      lastUpdatedDateTime: data.lastUpdatedDateTime.present
          ? data.lastUpdatedDateTime.value
          : this.lastUpdatedDateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('entryText: $entryText, ')
          ..write('createdDateTime: $createdDateTime, ')
          ..write('lastUpdatedDateTime: $lastUpdatedDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    journalEntryId,
    entryText,
    createdDateTime,
    lastUpdatedDateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.journalEntryId == this.journalEntryId &&
          other.entryText == this.entryText &&
          other.createdDateTime == this.createdDateTime &&
          other.lastUpdatedDateTime == this.lastUpdatedDateTime);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> journalEntryId;
  final Value<String> entryText;
  final Value<DateTime> createdDateTime;
  final Value<DateTime?> lastUpdatedDateTime;
  const JournalEntriesCompanion({
    this.journalEntryId = const Value.absent(),
    this.entryText = const Value.absent(),
    this.createdDateTime = const Value.absent(),
    this.lastUpdatedDateTime = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.journalEntryId = const Value.absent(),
    required String entryText,
    this.createdDateTime = const Value.absent(),
    this.lastUpdatedDateTime = const Value.absent(),
  }) : entryText = Value(entryText);
  static Insertable<JournalEntry> custom({
    Expression<int>? journalEntryId,
    Expression<String>? entryText,
    Expression<DateTime>? createdDateTime,
    Expression<DateTime>? lastUpdatedDateTime,
  }) {
    return RawValuesInsertable({
      if (journalEntryId != null) 'journal_entry_id': journalEntryId,
      if (entryText != null) 'entry_text': entryText,
      if (createdDateTime != null) 'created_date_time': createdDateTime,
      if (lastUpdatedDateTime != null)
        'last_updated_date_time': lastUpdatedDateTime,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? journalEntryId,
    Value<String>? entryText,
    Value<DateTime>? createdDateTime,
    Value<DateTime?>? lastUpdatedDateTime,
  }) {
    return JournalEntriesCompanion(
      journalEntryId: journalEntryId ?? this.journalEntryId,
      entryText: entryText ?? this.entryText,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      lastUpdatedDateTime: lastUpdatedDateTime ?? this.lastUpdatedDateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (journalEntryId.present) {
      map['journal_entry_id'] = Variable<int>(journalEntryId.value);
    }
    if (entryText.present) {
      map['entry_text'] = Variable<String>(entryText.value);
    }
    if (createdDateTime.present) {
      map['created_date_time'] = Variable<DateTime>(createdDateTime.value);
    }
    if (lastUpdatedDateTime.present) {
      map['last_updated_date_time'] = Variable<DateTime>(
        lastUpdatedDateTime.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('entryText: $entryText, ')
          ..write('createdDateTime: $createdDateTime, ')
          ..write('lastUpdatedDateTime: $lastUpdatedDateTime')
          ..write(')'))
        .toString();
  }
}

class $JournalEntryTagsTable extends JournalEntryTags
    with TableInfo<$JournalEntryTagsTable, JournalEntryTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntryTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _journalEntryTagIdMeta = const VerificationMeta(
    'journalEntryTagId',
  );
  @override
  late final GeneratedColumn<int> journalEntryTagId = GeneratedColumn<int>(
    'journal_entry_tag_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _journalEntryIdMeta = const VerificationMeta(
    'journalEntryId',
  );
  @override
  late final GeneratedColumn<int> journalEntryId = GeneratedColumn<int>(
    'journal_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES journal_entries (journal_entry_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    journalEntryTagId,
    journalEntryId,
    tag,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entry_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntryTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('journal_entry_tag_id')) {
      context.handle(
        _journalEntryTagIdMeta,
        journalEntryTagId.isAcceptableOrUnknown(
          data['journal_entry_tag_id']!,
          _journalEntryTagIdMeta,
        ),
      );
    }
    if (data.containsKey('journal_entry_id')) {
      context.handle(
        _journalEntryIdMeta,
        journalEntryId.isAcceptableOrUnknown(
          data['journal_entry_id']!,
          _journalEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_journalEntryIdMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {journalEntryTagId};
  @override
  JournalEntryTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntryTag(
      journalEntryTagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entry_tag_id'],
      )!,
      journalEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entry_id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
    );
  }

  @override
  $JournalEntryTagsTable createAlias(String alias) {
    return $JournalEntryTagsTable(attachedDatabase, alias);
  }
}

class JournalEntryTag extends DataClass implements Insertable<JournalEntryTag> {
  final int journalEntryTagId;
  final int journalEntryId;
  final String tag;
  const JournalEntryTag({
    required this.journalEntryTagId,
    required this.journalEntryId,
    required this.tag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['journal_entry_tag_id'] = Variable<int>(journalEntryTagId);
    map['journal_entry_id'] = Variable<int>(journalEntryId);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  JournalEntryTagsCompanion toCompanion(bool nullToAbsent) {
    return JournalEntryTagsCompanion(
      journalEntryTagId: Value(journalEntryTagId),
      journalEntryId: Value(journalEntryId),
      tag: Value(tag),
    );
  }

  factory JournalEntryTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntryTag(
      journalEntryTagId: serializer.fromJson<int>(json['journalEntryTagId']),
      journalEntryId: serializer.fromJson<int>(json['journalEntryId']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'journalEntryTagId': serializer.toJson<int>(journalEntryTagId),
      'journalEntryId': serializer.toJson<int>(journalEntryId),
      'tag': serializer.toJson<String>(tag),
    };
  }

  JournalEntryTag copyWith({
    int? journalEntryTagId,
    int? journalEntryId,
    String? tag,
  }) => JournalEntryTag(
    journalEntryTagId: journalEntryTagId ?? this.journalEntryTagId,
    journalEntryId: journalEntryId ?? this.journalEntryId,
    tag: tag ?? this.tag,
  );
  JournalEntryTag copyWithCompanion(JournalEntryTagsCompanion data) {
    return JournalEntryTag(
      journalEntryTagId: data.journalEntryTagId.present
          ? data.journalEntryTagId.value
          : this.journalEntryTagId,
      journalEntryId: data.journalEntryId.present
          ? data.journalEntryId.value
          : this.journalEntryId,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntryTag(')
          ..write('journalEntryTagId: $journalEntryTagId, ')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(journalEntryTagId, journalEntryId, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntryTag &&
          other.journalEntryTagId == this.journalEntryTagId &&
          other.journalEntryId == this.journalEntryId &&
          other.tag == this.tag);
}

class JournalEntryTagsCompanion extends UpdateCompanion<JournalEntryTag> {
  final Value<int> journalEntryTagId;
  final Value<int> journalEntryId;
  final Value<String> tag;
  const JournalEntryTagsCompanion({
    this.journalEntryTagId = const Value.absent(),
    this.journalEntryId = const Value.absent(),
    this.tag = const Value.absent(),
  });
  JournalEntryTagsCompanion.insert({
    this.journalEntryTagId = const Value.absent(),
    required int journalEntryId,
    required String tag,
  }) : journalEntryId = Value(journalEntryId),
       tag = Value(tag);
  static Insertable<JournalEntryTag> custom({
    Expression<int>? journalEntryTagId,
    Expression<int>? journalEntryId,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (journalEntryTagId != null) 'journal_entry_tag_id': journalEntryTagId,
      if (journalEntryId != null) 'journal_entry_id': journalEntryId,
      if (tag != null) 'tag': tag,
    });
  }

  JournalEntryTagsCompanion copyWith({
    Value<int>? journalEntryTagId,
    Value<int>? journalEntryId,
    Value<String>? tag,
  }) {
    return JournalEntryTagsCompanion(
      journalEntryTagId: journalEntryTagId ?? this.journalEntryTagId,
      journalEntryId: journalEntryId ?? this.journalEntryId,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (journalEntryTagId.present) {
      map['journal_entry_tag_id'] = Variable<int>(journalEntryTagId.value);
    }
    if (journalEntryId.present) {
      map['journal_entry_id'] = Variable<int>(journalEntryId.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntryTagsCompanion(')
          ..write('journalEntryTagId: $journalEntryTagId, ')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

class $PetJournalEntriesTable extends PetJournalEntries
    with TableInfo<$PetJournalEntriesTable, PetJournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetJournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pets (pet_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _journalEntryIdMeta = const VerificationMeta(
    'journalEntryId',
  );
  @override
  late final GeneratedColumn<int> journalEntryId = GeneratedColumn<int>(
    'journal_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES journal_entries (journal_entry_id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [petId, journalEntryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetJournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('journal_entry_id')) {
      context.handle(
        _journalEntryIdMeta,
        journalEntryId.isAcceptableOrUnknown(
          data['journal_entry_id']!,
          _journalEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_journalEntryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {petId, journalEntryId};
  @override
  PetJournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetJournalEntry(
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      journalEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entry_id'],
      )!,
    );
  }

  @override
  $PetJournalEntriesTable createAlias(String alias) {
    return $PetJournalEntriesTable(attachedDatabase, alias);
  }
}

class PetJournalEntry extends DataClass implements Insertable<PetJournalEntry> {
  final int petId;
  final int journalEntryId;
  const PetJournalEntry({required this.petId, required this.journalEntryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pet_id'] = Variable<int>(petId);
    map['journal_entry_id'] = Variable<int>(journalEntryId);
    return map;
  }

  PetJournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return PetJournalEntriesCompanion(
      petId: Value(petId),
      journalEntryId: Value(journalEntryId),
    );
  }

  factory PetJournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetJournalEntry(
      petId: serializer.fromJson<int>(json['petId']),
      journalEntryId: serializer.fromJson<int>(json['journalEntryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'petId': serializer.toJson<int>(petId),
      'journalEntryId': serializer.toJson<int>(journalEntryId),
    };
  }

  PetJournalEntry copyWith({int? petId, int? journalEntryId}) =>
      PetJournalEntry(
        petId: petId ?? this.petId,
        journalEntryId: journalEntryId ?? this.journalEntryId,
      );
  PetJournalEntry copyWithCompanion(PetJournalEntriesCompanion data) {
    return PetJournalEntry(
      petId: data.petId.present ? data.petId.value : this.petId,
      journalEntryId: data.journalEntryId.present
          ? data.journalEntryId.value
          : this.journalEntryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetJournalEntry(')
          ..write('petId: $petId, ')
          ..write('journalEntryId: $journalEntryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(petId, journalEntryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetJournalEntry &&
          other.petId == this.petId &&
          other.journalEntryId == this.journalEntryId);
}

class PetJournalEntriesCompanion extends UpdateCompanion<PetJournalEntry> {
  final Value<int> petId;
  final Value<int> journalEntryId;
  final Value<int> rowid;
  const PetJournalEntriesCompanion({
    this.petId = const Value.absent(),
    this.journalEntryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PetJournalEntriesCompanion.insert({
    required int petId,
    required int journalEntryId,
    this.rowid = const Value.absent(),
  }) : petId = Value(petId),
       journalEntryId = Value(journalEntryId);
  static Insertable<PetJournalEntry> custom({
    Expression<int>? petId,
    Expression<int>? journalEntryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (petId != null) 'pet_id': petId,
      if (journalEntryId != null) 'journal_entry_id': journalEntryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PetJournalEntriesCompanion copyWith({
    Value<int>? petId,
    Value<int>? journalEntryId,
    Value<int>? rowid,
  }) {
    return PetJournalEntriesCompanion(
      petId: petId ?? this.petId,
      journalEntryId: journalEntryId ?? this.journalEntryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (journalEntryId.present) {
      map['journal_entry_id'] = Variable<int>(journalEntryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetJournalEntriesCompanion(')
          ..write('petId: $petId, ')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _settingsIdMeta = const VerificationMeta(
    'settingsId',
  );
  @override
  late final GeneratedColumn<int> settingsId = GeneratedColumn<int>(
    'settings_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _acceptedTermsAndConditionsMeta =
      const VerificationMeta('acceptedTermsAndConditions');
  @override
  late final GeneratedColumn<bool> acceptedTermsAndConditions =
      GeneratedColumn<bool>(
        'accepted_terms_and_conditions',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("accepted_terms_and_conditions" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _onBoardingCompleteMeta =
      const VerificationMeta('onBoardingComplete');
  @override
  late final GeneratedColumn<bool> onBoardingComplete = GeneratedColumn<bool>(
    'on_boarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("on_boarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _optIntoAnalyticsWarningMeta =
      const VerificationMeta('optIntoAnalyticsWarning');
  @override
  late final GeneratedColumn<bool> optIntoAnalyticsWarning =
      GeneratedColumn<bool>(
        'opt_into_analytics_warning',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("opt_into_analytics_warning" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _lastUsedVersionMeta = const VerificationMeta(
    'lastUsedVersion',
  );
  @override
  late final GeneratedColumn<String> lastUsedVersion = GeneratedColumn<String>(
    'last_used_version',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultWeightUnitMeta = const VerificationMeta(
    'defaultWeightUnit',
  );
  @override
  late final GeneratedColumn<int> defaultWeightUnit = GeneratedColumn<int>(
    'default_weight_unit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    settingsId,
    acceptedTermsAndConditions,
    onBoardingComplete,
    optIntoAnalyticsWarning,
    lastUsedVersion,
    defaultWeightUnit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('settings_id')) {
      context.handle(
        _settingsIdMeta,
        settingsId.isAcceptableOrUnknown(data['settings_id']!, _settingsIdMeta),
      );
    }
    if (data.containsKey('accepted_terms_and_conditions')) {
      context.handle(
        _acceptedTermsAndConditionsMeta,
        acceptedTermsAndConditions.isAcceptableOrUnknown(
          data['accepted_terms_and_conditions']!,
          _acceptedTermsAndConditionsMeta,
        ),
      );
    }
    if (data.containsKey('on_boarding_complete')) {
      context.handle(
        _onBoardingCompleteMeta,
        onBoardingComplete.isAcceptableOrUnknown(
          data['on_boarding_complete']!,
          _onBoardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('opt_into_analytics_warning')) {
      context.handle(
        _optIntoAnalyticsWarningMeta,
        optIntoAnalyticsWarning.isAcceptableOrUnknown(
          data['opt_into_analytics_warning']!,
          _optIntoAnalyticsWarningMeta,
        ),
      );
    }
    if (data.containsKey('last_used_version')) {
      context.handle(
        _lastUsedVersionMeta,
        lastUsedVersion.isAcceptableOrUnknown(
          data['last_used_version']!,
          _lastUsedVersionMeta,
        ),
      );
    }
    if (data.containsKey('default_weight_unit')) {
      context.handle(
        _defaultWeightUnitMeta,
        defaultWeightUnit.isAcceptableOrUnknown(
          data['default_weight_unit']!,
          _defaultWeightUnitMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {settingsId};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      settingsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}settings_id'],
      )!,
      acceptedTermsAndConditions: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}accepted_terms_and_conditions'],
      )!,
      onBoardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}on_boarding_complete'],
      )!,
      optIntoAnalyticsWarning: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}opt_into_analytics_warning'],
      )!,
      lastUsedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_used_version'],
      ),
      defaultWeightUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_weight_unit'],
      ),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int settingsId;
  final bool acceptedTermsAndConditions;
  final bool onBoardingComplete;
  final bool optIntoAnalyticsWarning;
  final String? lastUsedVersion;
  final int? defaultWeightUnit;
  const Setting({
    required this.settingsId,
    required this.acceptedTermsAndConditions,
    required this.onBoardingComplete,
    required this.optIntoAnalyticsWarning,
    this.lastUsedVersion,
    this.defaultWeightUnit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['settings_id'] = Variable<int>(settingsId);
    map['accepted_terms_and_conditions'] = Variable<bool>(
      acceptedTermsAndConditions,
    );
    map['on_boarding_complete'] = Variable<bool>(onBoardingComplete);
    map['opt_into_analytics_warning'] = Variable<bool>(optIntoAnalyticsWarning);
    if (!nullToAbsent || lastUsedVersion != null) {
      map['last_used_version'] = Variable<String>(lastUsedVersion);
    }
    if (!nullToAbsent || defaultWeightUnit != null) {
      map['default_weight_unit'] = Variable<int>(defaultWeightUnit);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      settingsId: Value(settingsId),
      acceptedTermsAndConditions: Value(acceptedTermsAndConditions),
      onBoardingComplete: Value(onBoardingComplete),
      optIntoAnalyticsWarning: Value(optIntoAnalyticsWarning),
      lastUsedVersion: lastUsedVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedVersion),
      defaultWeightUnit: defaultWeightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultWeightUnit),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      settingsId: serializer.fromJson<int>(json['settingsId']),
      acceptedTermsAndConditions: serializer.fromJson<bool>(
        json['acceptedTermsAndConditions'],
      ),
      onBoardingComplete: serializer.fromJson<bool>(json['onBoardingComplete']),
      optIntoAnalyticsWarning: serializer.fromJson<bool>(
        json['optIntoAnalyticsWarning'],
      ),
      lastUsedVersion: serializer.fromJson<String?>(json['lastUsedVersion']),
      defaultWeightUnit: serializer.fromJson<int?>(json['defaultWeightUnit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'settingsId': serializer.toJson<int>(settingsId),
      'acceptedTermsAndConditions': serializer.toJson<bool>(
        acceptedTermsAndConditions,
      ),
      'onBoardingComplete': serializer.toJson<bool>(onBoardingComplete),
      'optIntoAnalyticsWarning': serializer.toJson<bool>(
        optIntoAnalyticsWarning,
      ),
      'lastUsedVersion': serializer.toJson<String?>(lastUsedVersion),
      'defaultWeightUnit': serializer.toJson<int?>(defaultWeightUnit),
    };
  }

  Setting copyWith({
    int? settingsId,
    bool? acceptedTermsAndConditions,
    bool? onBoardingComplete,
    bool? optIntoAnalyticsWarning,
    Value<String?> lastUsedVersion = const Value.absent(),
    Value<int?> defaultWeightUnit = const Value.absent(),
  }) => Setting(
    settingsId: settingsId ?? this.settingsId,
    acceptedTermsAndConditions:
        acceptedTermsAndConditions ?? this.acceptedTermsAndConditions,
    onBoardingComplete: onBoardingComplete ?? this.onBoardingComplete,
    optIntoAnalyticsWarning:
        optIntoAnalyticsWarning ?? this.optIntoAnalyticsWarning,
    lastUsedVersion: lastUsedVersion.present
        ? lastUsedVersion.value
        : this.lastUsedVersion,
    defaultWeightUnit: defaultWeightUnit.present
        ? defaultWeightUnit.value
        : this.defaultWeightUnit,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      settingsId: data.settingsId.present
          ? data.settingsId.value
          : this.settingsId,
      acceptedTermsAndConditions: data.acceptedTermsAndConditions.present
          ? data.acceptedTermsAndConditions.value
          : this.acceptedTermsAndConditions,
      onBoardingComplete: data.onBoardingComplete.present
          ? data.onBoardingComplete.value
          : this.onBoardingComplete,
      optIntoAnalyticsWarning: data.optIntoAnalyticsWarning.present
          ? data.optIntoAnalyticsWarning.value
          : this.optIntoAnalyticsWarning,
      lastUsedVersion: data.lastUsedVersion.present
          ? data.lastUsedVersion.value
          : this.lastUsedVersion,
      defaultWeightUnit: data.defaultWeightUnit.present
          ? data.defaultWeightUnit.value
          : this.defaultWeightUnit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('settingsId: $settingsId, ')
          ..write('acceptedTermsAndConditions: $acceptedTermsAndConditions, ')
          ..write('onBoardingComplete: $onBoardingComplete, ')
          ..write('optIntoAnalyticsWarning: $optIntoAnalyticsWarning, ')
          ..write('lastUsedVersion: $lastUsedVersion, ')
          ..write('defaultWeightUnit: $defaultWeightUnit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    settingsId,
    acceptedTermsAndConditions,
    onBoardingComplete,
    optIntoAnalyticsWarning,
    lastUsedVersion,
    defaultWeightUnit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.settingsId == this.settingsId &&
          other.acceptedTermsAndConditions == this.acceptedTermsAndConditions &&
          other.onBoardingComplete == this.onBoardingComplete &&
          other.optIntoAnalyticsWarning == this.optIntoAnalyticsWarning &&
          other.lastUsedVersion == this.lastUsedVersion &&
          other.defaultWeightUnit == this.defaultWeightUnit);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> settingsId;
  final Value<bool> acceptedTermsAndConditions;
  final Value<bool> onBoardingComplete;
  final Value<bool> optIntoAnalyticsWarning;
  final Value<String?> lastUsedVersion;
  final Value<int?> defaultWeightUnit;
  const SettingsCompanion({
    this.settingsId = const Value.absent(),
    this.acceptedTermsAndConditions = const Value.absent(),
    this.onBoardingComplete = const Value.absent(),
    this.optIntoAnalyticsWarning = const Value.absent(),
    this.lastUsedVersion = const Value.absent(),
    this.defaultWeightUnit = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.settingsId = const Value.absent(),
    this.acceptedTermsAndConditions = const Value.absent(),
    this.onBoardingComplete = const Value.absent(),
    this.optIntoAnalyticsWarning = const Value.absent(),
    this.lastUsedVersion = const Value.absent(),
    this.defaultWeightUnit = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? settingsId,
    Expression<bool>? acceptedTermsAndConditions,
    Expression<bool>? onBoardingComplete,
    Expression<bool>? optIntoAnalyticsWarning,
    Expression<String>? lastUsedVersion,
    Expression<int>? defaultWeightUnit,
  }) {
    return RawValuesInsertable({
      if (settingsId != null) 'settings_id': settingsId,
      if (acceptedTermsAndConditions != null)
        'accepted_terms_and_conditions': acceptedTermsAndConditions,
      if (onBoardingComplete != null)
        'on_boarding_complete': onBoardingComplete,
      if (optIntoAnalyticsWarning != null)
        'opt_into_analytics_warning': optIntoAnalyticsWarning,
      if (lastUsedVersion != null) 'last_used_version': lastUsedVersion,
      if (defaultWeightUnit != null) 'default_weight_unit': defaultWeightUnit,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? settingsId,
    Value<bool>? acceptedTermsAndConditions,
    Value<bool>? onBoardingComplete,
    Value<bool>? optIntoAnalyticsWarning,
    Value<String?>? lastUsedVersion,
    Value<int?>? defaultWeightUnit,
  }) {
    return SettingsCompanion(
      settingsId: settingsId ?? this.settingsId,
      acceptedTermsAndConditions:
          acceptedTermsAndConditions ?? this.acceptedTermsAndConditions,
      onBoardingComplete: onBoardingComplete ?? this.onBoardingComplete,
      optIntoAnalyticsWarning:
          optIntoAnalyticsWarning ?? this.optIntoAnalyticsWarning,
      lastUsedVersion: lastUsedVersion ?? this.lastUsedVersion,
      defaultWeightUnit: defaultWeightUnit ?? this.defaultWeightUnit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (settingsId.present) {
      map['settings_id'] = Variable<int>(settingsId.value);
    }
    if (acceptedTermsAndConditions.present) {
      map['accepted_terms_and_conditions'] = Variable<bool>(
        acceptedTermsAndConditions.value,
      );
    }
    if (onBoardingComplete.present) {
      map['on_boarding_complete'] = Variable<bool>(onBoardingComplete.value);
    }
    if (optIntoAnalyticsWarning.present) {
      map['opt_into_analytics_warning'] = Variable<bool>(
        optIntoAnalyticsWarning.value,
      );
    }
    if (lastUsedVersion.present) {
      map['last_used_version'] = Variable<String>(lastUsedVersion.value);
    }
    if (defaultWeightUnit.present) {
      map['default_weight_unit'] = Variable<int>(defaultWeightUnit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('settingsId: $settingsId, ')
          ..write('acceptedTermsAndConditions: $acceptedTermsAndConditions, ')
          ..write('onBoardingComplete: $onBoardingComplete, ')
          ..write('optIntoAnalyticsWarning: $optIntoAnalyticsWarning, ')
          ..write('lastUsedVersion: $lastUsedVersion, ')
          ..write('defaultWeightUnit: $defaultWeightUnit')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseService extends GeneratedDatabase {
  _$DatabaseService(QueryExecutor e) : super(e);
  $DatabaseServiceManager get managers => $DatabaseServiceManager(this);
  late final $SpeciesTypesTable speciesTypes = $SpeciesTypesTable(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $PetMedsTable petMeds = $PetMedsTable(this);
  late final $PetVaccinationsTable petVaccinations = $PetVaccinationsTable(
    this,
  );
  late final $PetWeightsTable petWeights = $PetWeightsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $JournalEntryTagsTable journalEntryTags = $JournalEntryTagsTable(
    this,
  );
  late final $PetJournalEntriesTable petJournalEntries =
      $PetJournalEntriesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    speciesTypes,
    pets,
    petMeds,
    petVaccinations,
    petWeights,
    journalEntries,
    journalEntryTags,
    petJournalEntries,
    settings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pet_meds', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pet_vaccinations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pet_weights', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entry_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pet_journal_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pet_journal_entries', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SpeciesTypesTableCreateCompanionBuilder =
    SpeciesTypesCompanion Function({
      Value<int> speciesId,
      required String name,
      Value<bool> userAdded,
    });
typedef $$SpeciesTypesTableUpdateCompanionBuilder =
    SpeciesTypesCompanion Function({
      Value<int> speciesId,
      Value<String> name,
      Value<bool> userAdded,
    });

final class $$SpeciesTypesTableReferences
    extends BaseReferences<_$DatabaseService, $SpeciesTypesTable, SpeciesType> {
  $$SpeciesTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PetsTable, List<Pet>> _petsRefsTable(
    _$DatabaseService db,
  ) => MultiTypedResultKey.fromTable(
    db.pets,
    aliasName: $_aliasNameGenerator(
      db.speciesTypes.speciesId,
      db.pets.speciesId,
    ),
  );

  $$PetsTableProcessedTableManager get petsRefs {
    final manager = $$PetsTableTableManager($_db, $_db.pets).filter(
      (f) => f.speciesId.speciesId.sqlEquals($_itemColumn<int>('species_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_petsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesTypesTableFilterComposer
    extends Composer<_$DatabaseService, $SpeciesTypesTable> {
  $$SpeciesTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get userAdded => $composableBuilder(
    column: $table.userAdded,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> petsRefs(
    Expression<bool> Function($$PetsTableFilterComposer f) f,
  ) {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTypesTableOrderingComposer
    extends Composer<_$DatabaseService, $SpeciesTypesTable> {
  $$SpeciesTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get userAdded => $composableBuilder(
    column: $table.userAdded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpeciesTypesTableAnnotationComposer
    extends Composer<_$DatabaseService, $SpeciesTypesTable> {
  $$SpeciesTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get userAdded =>
      $composableBuilder(column: $table.userAdded, builder: (column) => column);

  Expression<T> petsRefs<T extends Object>(
    Expression<T> Function($$PetsTableAnnotationComposer a) f,
  ) {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTypesTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $SpeciesTypesTable,
          SpeciesType,
          $$SpeciesTypesTableFilterComposer,
          $$SpeciesTypesTableOrderingComposer,
          $$SpeciesTypesTableAnnotationComposer,
          $$SpeciesTypesTableCreateCompanionBuilder,
          $$SpeciesTypesTableUpdateCompanionBuilder,
          (SpeciesType, $$SpeciesTypesTableReferences),
          SpeciesType,
          PrefetchHooks Function({bool petsRefs})
        > {
  $$SpeciesTypesTableTableManager(
    _$DatabaseService db,
    $SpeciesTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeciesTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeciesTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> userAdded = const Value.absent(),
              }) => SpeciesTypesCompanion(
                speciesId: speciesId,
                name: name,
                userAdded: userAdded,
              ),
          createCompanionCallback:
              ({
                Value<int> speciesId = const Value.absent(),
                required String name,
                Value<bool> userAdded = const Value.absent(),
              }) => SpeciesTypesCompanion.insert(
                speciesId: speciesId,
                name: name,
                userAdded: userAdded,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpeciesTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (petsRefs) db.pets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (petsRefs)
                    await $_getPrefetchedData<
                      SpeciesType,
                      $SpeciesTypesTable,
                      Pet
                    >(
                      currentTable: table,
                      referencedTable: $$SpeciesTypesTableReferences
                          ._petsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SpeciesTypesTableReferences(db, table, p0).petsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.speciesId == item.speciesId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SpeciesTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $SpeciesTypesTable,
      SpeciesType,
      $$SpeciesTypesTableFilterComposer,
      $$SpeciesTypesTableOrderingComposer,
      $$SpeciesTypesTableAnnotationComposer,
      $$SpeciesTypesTableCreateCompanionBuilder,
      $$SpeciesTypesTableUpdateCompanionBuilder,
      (SpeciesType, $$SpeciesTypesTableReferences),
      SpeciesType,
      PrefetchHooks Function({bool petsRefs})
    >;
typedef $$PetsTableCreateCompanionBuilder =
    PetsCompanion Function({
      Value<int> petId,
      required String name,
      required int speciesId,
      required String breed,
      required String colour,
      Value<int> sex,
      Value<DateTime?> dob,
      Value<bool> dobEstimate,
      Value<String?> diet,
      Value<String?> notes,
      Value<String?> history,
      Value<bool> isNeutered,
      Value<DateTime?> neuterDate,
      Value<int> status,
      Value<DateTime> statusDate,
      Value<bool?> isMicrochipped,
      Value<DateTime?> microchipDate,
      Value<String?> microchipNotes,
      Value<String?> microchipNumber,
      Value<String?> microchipCompany,
    });
typedef $$PetsTableUpdateCompanionBuilder =
    PetsCompanion Function({
      Value<int> petId,
      Value<String> name,
      Value<int> speciesId,
      Value<String> breed,
      Value<String> colour,
      Value<int> sex,
      Value<DateTime?> dob,
      Value<bool> dobEstimate,
      Value<String?> diet,
      Value<String?> notes,
      Value<String?> history,
      Value<bool> isNeutered,
      Value<DateTime?> neuterDate,
      Value<int> status,
      Value<DateTime> statusDate,
      Value<bool?> isMicrochipped,
      Value<DateTime?> microchipDate,
      Value<String?> microchipNotes,
      Value<String?> microchipNumber,
      Value<String?> microchipCompany,
    });

final class $$PetsTableReferences
    extends BaseReferences<_$DatabaseService, $PetsTable, Pet> {
  $$PetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SpeciesTypesTable _speciesIdTable(_$DatabaseService db) =>
      db.speciesTypes.createAlias(
        $_aliasNameGenerator(db.pets.speciesId, db.speciesTypes.speciesId),
      );

  $$SpeciesTypesTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$SpeciesTypesTableTableManager(
      $_db,
      $_db.speciesTypes,
    ).filter((f) => f.speciesId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PetMedsTable, List<PetMed>> _petMedsRefsTable(
    _$DatabaseService db,
  ) => MultiTypedResultKey.fromTable(
    db.petMeds,
    aliasName: $_aliasNameGenerator(db.pets.petId, db.petMeds.pet),
  );

  $$PetMedsTableProcessedTableManager get petMedsRefs {
    final manager = $$PetMedsTableTableManager(
      $_db,
      $_db.petMeds,
    ).filter((f) => f.pet.petId.sqlEquals($_itemColumn<int>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(_petMedsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PetVaccinationsTable, List<PetVaccination>>
  _petVaccinationsRefsTable(_$DatabaseService db) =>
      MultiTypedResultKey.fromTable(
        db.petVaccinations,
        aliasName: $_aliasNameGenerator(db.pets.petId, db.petVaccinations.pet),
      );

  $$PetVaccinationsTableProcessedTableManager get petVaccinationsRefs {
    final manager = $$PetVaccinationsTableTableManager(
      $_db,
      $_db.petVaccinations,
    ).filter((f) => f.pet.petId.sqlEquals($_itemColumn<int>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(
      _petVaccinationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PetWeightsTable, List<PetWeight>>
  _petWeightsRefsTable(_$DatabaseService db) => MultiTypedResultKey.fromTable(
    db.petWeights,
    aliasName: $_aliasNameGenerator(db.pets.petId, db.petWeights.pet),
  );

  $$PetWeightsTableProcessedTableManager get petWeightsRefs {
    final manager = $$PetWeightsTableTableManager(
      $_db,
      $_db.petWeights,
    ).filter((f) => f.pet.petId.sqlEquals($_itemColumn<int>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(_petWeightsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PetJournalEntriesTable, List<PetJournalEntry>>
  _petJournalEntriesRefsTable(_$DatabaseService db) =>
      MultiTypedResultKey.fromTable(
        db.petJournalEntries,
        aliasName: $_aliasNameGenerator(
          db.pets.petId,
          db.petJournalEntries.petId,
        ),
      );

  $$PetJournalEntriesTableProcessedTableManager get petJournalEntriesRefs {
    final manager = $$PetJournalEntriesTableTableManager(
      $_db,
      $_db.petJournalEntries,
    ).filter((f) => f.petId.petId.sqlEquals($_itemColumn<int>('pet_id')!));

    final cache = $_typedResult.readTableOrNull(
      _petJournalEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PetsTableFilterComposer
    extends Composer<_$DatabaseService, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dobEstimate => $composableBuilder(
    column: $table.dobEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get history => $composableBuilder(
    column: $table.history,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNeutered => $composableBuilder(
    column: $table.isNeutered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get neuterDate => $composableBuilder(
    column: $table.neuterDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get statusDate => $composableBuilder(
    column: $table.statusDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMicrochipped => $composableBuilder(
    column: $table.isMicrochipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get microchipDate => $composableBuilder(
    column: $table.microchipDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get microchipNotes => $composableBuilder(
    column: $table.microchipNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get microchipNumber => $composableBuilder(
    column: $table.microchipNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get microchipCompany => $composableBuilder(
    column: $table.microchipCompany,
    builder: (column) => ColumnFilters(column),
  );

  $$SpeciesTypesTableFilterComposer get speciesId {
    final $$SpeciesTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTypes,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTypesTableFilterComposer(
            $db: $db,
            $table: $db.speciesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> petMedsRefs(
    Expression<bool> Function($$PetMedsTableFilterComposer f) f,
  ) {
    final $$PetMedsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petMeds,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetMedsTableFilterComposer(
            $db: $db,
            $table: $db.petMeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> petVaccinationsRefs(
    Expression<bool> Function($$PetVaccinationsTableFilterComposer f) f,
  ) {
    final $$PetVaccinationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petVaccinations,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetVaccinationsTableFilterComposer(
            $db: $db,
            $table: $db.petVaccinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> petWeightsRefs(
    Expression<bool> Function($$PetWeightsTableFilterComposer f) f,
  ) {
    final $$PetWeightsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petWeights,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetWeightsTableFilterComposer(
            $db: $db,
            $table: $db.petWeights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> petJournalEntriesRefs(
    Expression<bool> Function($$PetJournalEntriesTableFilterComposer f) f,
  ) {
    final $$PetJournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petJournalEntries,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetJournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.petJournalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PetsTableOrderingComposer
    extends Composer<_$DatabaseService, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dobEstimate => $composableBuilder(
    column: $table.dobEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get history => $composableBuilder(
    column: $table.history,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNeutered => $composableBuilder(
    column: $table.isNeutered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get neuterDate => $composableBuilder(
    column: $table.neuterDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get statusDate => $composableBuilder(
    column: $table.statusDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMicrochipped => $composableBuilder(
    column: $table.isMicrochipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get microchipDate => $composableBuilder(
    column: $table.microchipDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get microchipNotes => $composableBuilder(
    column: $table.microchipNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get microchipNumber => $composableBuilder(
    column: $table.microchipNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get microchipCompany => $composableBuilder(
    column: $table.microchipCompany,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpeciesTypesTableOrderingComposer get speciesId {
    final $$SpeciesTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTypes,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTypesTableOrderingComposer(
            $db: $db,
            $table: $db.speciesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetsTableAnnotationComposer
    extends Composer<_$DatabaseService, $PetsTable> {
  $$PetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<String> get colour =>
      $composableBuilder(column: $table.colour, builder: (column) => column);

  GeneratedColumn<int> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<bool> get dobEstimate => $composableBuilder(
    column: $table.dobEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diet =>
      $composableBuilder(column: $table.diet, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get history =>
      $composableBuilder(column: $table.history, builder: (column) => column);

  GeneratedColumn<bool> get isNeutered => $composableBuilder(
    column: $table.isNeutered,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get neuterDate => $composableBuilder(
    column: $table.neuterDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get statusDate => $composableBuilder(
    column: $table.statusDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMicrochipped => $composableBuilder(
    column: $table.isMicrochipped,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get microchipDate => $composableBuilder(
    column: $table.microchipDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get microchipNotes => $composableBuilder(
    column: $table.microchipNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get microchipNumber => $composableBuilder(
    column: $table.microchipNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get microchipCompany => $composableBuilder(
    column: $table.microchipCompany,
    builder: (column) => column,
  );

  $$SpeciesTypesTableAnnotationComposer get speciesId {
    final $$SpeciesTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.speciesTypes,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.speciesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> petMedsRefs<T extends Object>(
    Expression<T> Function($$PetMedsTableAnnotationComposer a) f,
  ) {
    final $$PetMedsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petMeds,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetMedsTableAnnotationComposer(
            $db: $db,
            $table: $db.petMeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> petVaccinationsRefs<T extends Object>(
    Expression<T> Function($$PetVaccinationsTableAnnotationComposer a) f,
  ) {
    final $$PetVaccinationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petVaccinations,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetVaccinationsTableAnnotationComposer(
            $db: $db,
            $table: $db.petVaccinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> petWeightsRefs<T extends Object>(
    Expression<T> Function($$PetWeightsTableAnnotationComposer a) f,
  ) {
    final $$PetWeightsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.petWeights,
      getReferencedColumn: (t) => t.pet,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetWeightsTableAnnotationComposer(
            $db: $db,
            $table: $db.petWeights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> petJournalEntriesRefs<T extends Object>(
    Expression<T> Function($$PetJournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$PetJournalEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.petId,
          referencedTable: $db.petJournalEntries,
          getReferencedColumn: (t) => t.petId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PetJournalEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.petJournalEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PetsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $PetsTable,
          Pet,
          $$PetsTableFilterComposer,
          $$PetsTableOrderingComposer,
          $$PetsTableAnnotationComposer,
          $$PetsTableCreateCompanionBuilder,
          $$PetsTableUpdateCompanionBuilder,
          (Pet, $$PetsTableReferences),
          Pet,
          PrefetchHooks Function({
            bool speciesId,
            bool petMedsRefs,
            bool petVaccinationsRefs,
            bool petWeightsRefs,
            bool petJournalEntriesRefs,
          })
        > {
  $$PetsTableTableManager(_$DatabaseService db, $PetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> petId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<String> colour = const Value.absent(),
                Value<int> sex = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<bool> dobEstimate = const Value.absent(),
                Value<String?> diet = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> history = const Value.absent(),
                Value<bool> isNeutered = const Value.absent(),
                Value<DateTime?> neuterDate = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> statusDate = const Value.absent(),
                Value<bool?> isMicrochipped = const Value.absent(),
                Value<DateTime?> microchipDate = const Value.absent(),
                Value<String?> microchipNotes = const Value.absent(),
                Value<String?> microchipNumber = const Value.absent(),
                Value<String?> microchipCompany = const Value.absent(),
              }) => PetsCompanion(
                petId: petId,
                name: name,
                speciesId: speciesId,
                breed: breed,
                colour: colour,
                sex: sex,
                dob: dob,
                dobEstimate: dobEstimate,
                diet: diet,
                notes: notes,
                history: history,
                isNeutered: isNeutered,
                neuterDate: neuterDate,
                status: status,
                statusDate: statusDate,
                isMicrochipped: isMicrochipped,
                microchipDate: microchipDate,
                microchipNotes: microchipNotes,
                microchipNumber: microchipNumber,
                microchipCompany: microchipCompany,
              ),
          createCompanionCallback:
              ({
                Value<int> petId = const Value.absent(),
                required String name,
                required int speciesId,
                required String breed,
                required String colour,
                Value<int> sex = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<bool> dobEstimate = const Value.absent(),
                Value<String?> diet = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> history = const Value.absent(),
                Value<bool> isNeutered = const Value.absent(),
                Value<DateTime?> neuterDate = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> statusDate = const Value.absent(),
                Value<bool?> isMicrochipped = const Value.absent(),
                Value<DateTime?> microchipDate = const Value.absent(),
                Value<String?> microchipNotes = const Value.absent(),
                Value<String?> microchipNumber = const Value.absent(),
                Value<String?> microchipCompany = const Value.absent(),
              }) => PetsCompanion.insert(
                petId: petId,
                name: name,
                speciesId: speciesId,
                breed: breed,
                colour: colour,
                sex: sex,
                dob: dob,
                dobEstimate: dobEstimate,
                diet: diet,
                notes: notes,
                history: history,
                isNeutered: isNeutered,
                neuterDate: neuterDate,
                status: status,
                statusDate: statusDate,
                isMicrochipped: isMicrochipped,
                microchipDate: microchipDate,
                microchipNotes: microchipNotes,
                microchipNumber: microchipNumber,
                microchipCompany: microchipCompany,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PetsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                speciesId = false,
                petMedsRefs = false,
                petVaccinationsRefs = false,
                petWeightsRefs = false,
                petJournalEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (petMedsRefs) db.petMeds,
                    if (petVaccinationsRefs) db.petVaccinations,
                    if (petWeightsRefs) db.petWeights,
                    if (petJournalEntriesRefs) db.petJournalEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (speciesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.speciesId,
                                    referencedTable: $$PetsTableReferences
                                        ._speciesIdTable(db),
                                    referencedColumn: $$PetsTableReferences
                                        ._speciesIdTable(db)
                                        .speciesId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (petMedsRefs)
                        await $_getPrefetchedData<Pet, $PetsTable, PetMed>(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._petMedsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PetsTableReferences(db, table, p0).petMedsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pet == item.petId,
                              ),
                          typedResults: items,
                        ),
                      if (petVaccinationsRefs)
                        await $_getPrefetchedData<
                          Pet,
                          $PetsTable,
                          PetVaccination
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._petVaccinationsRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).petVaccinationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pet == item.petId,
                              ),
                          typedResults: items,
                        ),
                      if (petWeightsRefs)
                        await $_getPrefetchedData<Pet, $PetsTable, PetWeight>(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._petWeightsRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).petWeightsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pet == item.petId,
                              ),
                          typedResults: items,
                        ),
                      if (petJournalEntriesRefs)
                        await $_getPrefetchedData<
                          Pet,
                          $PetsTable,
                          PetJournalEntry
                        >(
                          currentTable: table,
                          referencedTable: $$PetsTableReferences
                              ._petJournalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $$PetsTableReferences(
                            db,
                            table,
                            p0,
                          ).petJournalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.petId == item.petId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PetsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $PetsTable,
      Pet,
      $$PetsTableFilterComposer,
      $$PetsTableOrderingComposer,
      $$PetsTableAnnotationComposer,
      $$PetsTableCreateCompanionBuilder,
      $$PetsTableUpdateCompanionBuilder,
      (Pet, $$PetsTableReferences),
      Pet,
      PrefetchHooks Function({
        bool speciesId,
        bool petMedsRefs,
        bool petVaccinationsRefs,
        bool petWeightsRefs,
        bool petJournalEntriesRefs,
      })
    >;
typedef $$PetMedsTableCreateCompanionBuilder =
    PetMedsCompanion Function({
      Value<int> petMedId,
      required int pet,
      required String name,
      required String dose,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<String?> notes,
    });
typedef $$PetMedsTableUpdateCompanionBuilder =
    PetMedsCompanion Function({
      Value<int> petMedId,
      Value<int> pet,
      Value<String> name,
      Value<String> dose,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<String?> notes,
    });

final class $$PetMedsTableReferences
    extends BaseReferences<_$DatabaseService, $PetMedsTable, PetMed> {
  $$PetMedsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petTable(_$DatabaseService db) =>
      db.pets.createAlias($_aliasNameGenerator(db.petMeds.pet, db.pets.petId));

  $$PetsTableProcessedTableManager get pet {
    final $_column = $_itemColumn<int>('pet')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PetMedsTableFilterComposer
    extends Composer<_$DatabaseService, $PetMedsTable> {
  $$PetMedsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get petMedId => $composableBuilder(
    column: $table.petMedId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get pet {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetMedsTableOrderingComposer
    extends Composer<_$DatabaseService, $PetMedsTable> {
  $$PetMedsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get petMedId => $composableBuilder(
    column: $table.petMedId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get pet {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetMedsTableAnnotationComposer
    extends Composer<_$DatabaseService, $PetMedsTable> {
  $$PetMedsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get petMedId =>
      $composableBuilder(column: $table.petMedId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PetsTableAnnotationComposer get pet {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetMedsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $PetMedsTable,
          PetMed,
          $$PetMedsTableFilterComposer,
          $$PetMedsTableOrderingComposer,
          $$PetMedsTableAnnotationComposer,
          $$PetMedsTableCreateCompanionBuilder,
          $$PetMedsTableUpdateCompanionBuilder,
          (PetMed, $$PetMedsTableReferences),
          PetMed,
          PrefetchHooks Function({bool pet})
        > {
  $$PetMedsTableTableManager(_$DatabaseService db, $PetMedsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetMedsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetMedsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetMedsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> petMedId = const Value.absent(),
                Value<int> pet = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> dose = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetMedsCompanion(
                petMedId: petMedId,
                pet: pet,
                name: name,
                dose: dose,
                startDate: startDate,
                endDate: endDate,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> petMedId = const Value.absent(),
                required int pet,
                required String name,
                required String dose,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetMedsCompanion.insert(
                petMedId: petMedId,
                pet: pet,
                name: name,
                dose: dose,
                startDate: startDate,
                endDate: endDate,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PetMedsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pet = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pet) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pet,
                                referencedTable: $$PetMedsTableReferences
                                    ._petTable(db),
                                referencedColumn: $$PetMedsTableReferences
                                    ._petTable(db)
                                    .petId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PetMedsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $PetMedsTable,
      PetMed,
      $$PetMedsTableFilterComposer,
      $$PetMedsTableOrderingComposer,
      $$PetMedsTableAnnotationComposer,
      $$PetMedsTableCreateCompanionBuilder,
      $$PetMedsTableUpdateCompanionBuilder,
      (PetMed, $$PetMedsTableReferences),
      PetMed,
      PrefetchHooks Function({bool pet})
    >;
typedef $$PetVaccinationsTableCreateCompanionBuilder =
    PetVaccinationsCompanion Function({
      Value<int> petVaccinationId,
      required int pet,
      required String name,
      required DateTime administeredDate,
      Value<DateTime?> expiryDate,
      Value<DateTime?> reminderDate,
      Value<String?> notes,
      required String vaccineBatchNumber,
      required String vaccineManufacturer,
      required String administeredBy,
    });
typedef $$PetVaccinationsTableUpdateCompanionBuilder =
    PetVaccinationsCompanion Function({
      Value<int> petVaccinationId,
      Value<int> pet,
      Value<String> name,
      Value<DateTime> administeredDate,
      Value<DateTime?> expiryDate,
      Value<DateTime?> reminderDate,
      Value<String?> notes,
      Value<String> vaccineBatchNumber,
      Value<String> vaccineManufacturer,
      Value<String> administeredBy,
    });

final class $$PetVaccinationsTableReferences
    extends
        BaseReferences<
          _$DatabaseService,
          $PetVaccinationsTable,
          PetVaccination
        > {
  $$PetVaccinationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PetsTable _petTable(_$DatabaseService db) => db.pets.createAlias(
    $_aliasNameGenerator(db.petVaccinations.pet, db.pets.petId),
  );

  $$PetsTableProcessedTableManager get pet {
    final $_column = $_itemColumn<int>('pet')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PetVaccinationsTableFilterComposer
    extends Composer<_$DatabaseService, $PetVaccinationsTable> {
  $$PetVaccinationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get petVaccinationId => $composableBuilder(
    column: $table.petVaccinationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get administeredDate => $composableBuilder(
    column: $table.administeredDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vaccineBatchNumber => $composableBuilder(
    column: $table.vaccineBatchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vaccineManufacturer => $composableBuilder(
    column: $table.vaccineManufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get administeredBy => $composableBuilder(
    column: $table.administeredBy,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get pet {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetVaccinationsTableOrderingComposer
    extends Composer<_$DatabaseService, $PetVaccinationsTable> {
  $$PetVaccinationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get petVaccinationId => $composableBuilder(
    column: $table.petVaccinationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get administeredDate => $composableBuilder(
    column: $table.administeredDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vaccineBatchNumber => $composableBuilder(
    column: $table.vaccineBatchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vaccineManufacturer => $composableBuilder(
    column: $table.vaccineManufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get administeredBy => $composableBuilder(
    column: $table.administeredBy,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get pet {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetVaccinationsTableAnnotationComposer
    extends Composer<_$DatabaseService, $PetVaccinationsTable> {
  $$PetVaccinationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get petVaccinationId => $composableBuilder(
    column: $table.petVaccinationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get administeredDate => $composableBuilder(
    column: $table.administeredDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get vaccineBatchNumber => $composableBuilder(
    column: $table.vaccineBatchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vaccineManufacturer => $composableBuilder(
    column: $table.vaccineManufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get administeredBy => $composableBuilder(
    column: $table.administeredBy,
    builder: (column) => column,
  );

  $$PetsTableAnnotationComposer get pet {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetVaccinationsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $PetVaccinationsTable,
          PetVaccination,
          $$PetVaccinationsTableFilterComposer,
          $$PetVaccinationsTableOrderingComposer,
          $$PetVaccinationsTableAnnotationComposer,
          $$PetVaccinationsTableCreateCompanionBuilder,
          $$PetVaccinationsTableUpdateCompanionBuilder,
          (PetVaccination, $$PetVaccinationsTableReferences),
          PetVaccination,
          PrefetchHooks Function({bool pet})
        > {
  $$PetVaccinationsTableTableManager(
    _$DatabaseService db,
    $PetVaccinationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetVaccinationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetVaccinationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetVaccinationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> petVaccinationId = const Value.absent(),
                Value<int> pet = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> administeredDate = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> vaccineBatchNumber = const Value.absent(),
                Value<String> vaccineManufacturer = const Value.absent(),
                Value<String> administeredBy = const Value.absent(),
              }) => PetVaccinationsCompanion(
                petVaccinationId: petVaccinationId,
                pet: pet,
                name: name,
                administeredDate: administeredDate,
                expiryDate: expiryDate,
                reminderDate: reminderDate,
                notes: notes,
                vaccineBatchNumber: vaccineBatchNumber,
                vaccineManufacturer: vaccineManufacturer,
                administeredBy: administeredBy,
              ),
          createCompanionCallback:
              ({
                Value<int> petVaccinationId = const Value.absent(),
                required int pet,
                required String name,
                required DateTime administeredDate,
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String vaccineBatchNumber,
                required String vaccineManufacturer,
                required String administeredBy,
              }) => PetVaccinationsCompanion.insert(
                petVaccinationId: petVaccinationId,
                pet: pet,
                name: name,
                administeredDate: administeredDate,
                expiryDate: expiryDate,
                reminderDate: reminderDate,
                notes: notes,
                vaccineBatchNumber: vaccineBatchNumber,
                vaccineManufacturer: vaccineManufacturer,
                administeredBy: administeredBy,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PetVaccinationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pet = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pet) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pet,
                                referencedTable:
                                    $$PetVaccinationsTableReferences._petTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$PetVaccinationsTableReferences
                                        ._petTable(db)
                                        .petId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PetVaccinationsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $PetVaccinationsTable,
      PetVaccination,
      $$PetVaccinationsTableFilterComposer,
      $$PetVaccinationsTableOrderingComposer,
      $$PetVaccinationsTableAnnotationComposer,
      $$PetVaccinationsTableCreateCompanionBuilder,
      $$PetVaccinationsTableUpdateCompanionBuilder,
      (PetVaccination, $$PetVaccinationsTableReferences),
      PetVaccination,
      PrefetchHooks Function({bool pet})
    >;
typedef $$PetWeightsTableCreateCompanionBuilder =
    PetWeightsCompanion Function({
      Value<int> petWeightId,
      required int pet,
      required DateTime date,
      required double weight,
      Value<int> weightUnit,
      Value<String?> notes,
    });
typedef $$PetWeightsTableUpdateCompanionBuilder =
    PetWeightsCompanion Function({
      Value<int> petWeightId,
      Value<int> pet,
      Value<DateTime> date,
      Value<double> weight,
      Value<int> weightUnit,
      Value<String?> notes,
    });

final class $$PetWeightsTableReferences
    extends BaseReferences<_$DatabaseService, $PetWeightsTable, PetWeight> {
  $$PetWeightsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PetsTable _petTable(_$DatabaseService db) => db.pets.createAlias(
    $_aliasNameGenerator(db.petWeights.pet, db.pets.petId),
  );

  $$PetsTableProcessedTableManager get pet {
    final $_column = $_itemColumn<int>('pet')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PetWeightsTableFilterComposer
    extends Composer<_$DatabaseService, $PetWeightsTable> {
  $$PetWeightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get petWeightId => $composableBuilder(
    column: $table.petWeightId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PetsTableFilterComposer get pet {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetWeightsTableOrderingComposer
    extends Composer<_$DatabaseService, $PetWeightsTable> {
  $$PetWeightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get petWeightId => $composableBuilder(
    column: $table.petWeightId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PetsTableOrderingComposer get pet {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetWeightsTableAnnotationComposer
    extends Composer<_$DatabaseService, $PetWeightsTable> {
  $$PetWeightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get petWeightId => $composableBuilder(
    column: $table.petWeightId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PetsTableAnnotationComposer get pet {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pet,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetWeightsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $PetWeightsTable,
          PetWeight,
          $$PetWeightsTableFilterComposer,
          $$PetWeightsTableOrderingComposer,
          $$PetWeightsTableAnnotationComposer,
          $$PetWeightsTableCreateCompanionBuilder,
          $$PetWeightsTableUpdateCompanionBuilder,
          (PetWeight, $$PetWeightsTableReferences),
          PetWeight,
          PrefetchHooks Function({bool pet})
        > {
  $$PetWeightsTableTableManager(_$DatabaseService db, $PetWeightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetWeightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetWeightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetWeightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> petWeightId = const Value.absent(),
                Value<int> pet = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<int> weightUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetWeightsCompanion(
                petWeightId: petWeightId,
                pet: pet,
                date: date,
                weight: weight,
                weightUnit: weightUnit,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> petWeightId = const Value.absent(),
                required int pet,
                required DateTime date,
                required double weight,
                Value<int> weightUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PetWeightsCompanion.insert(
                petWeightId: petWeightId,
                pet: pet,
                date: date,
                weight: weight,
                weightUnit: weightUnit,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PetWeightsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pet = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pet) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pet,
                                referencedTable: $$PetWeightsTableReferences
                                    ._petTable(db),
                                referencedColumn: $$PetWeightsTableReferences
                                    ._petTable(db)
                                    .petId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PetWeightsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $PetWeightsTable,
      PetWeight,
      $$PetWeightsTableFilterComposer,
      $$PetWeightsTableOrderingComposer,
      $$PetWeightsTableAnnotationComposer,
      $$PetWeightsTableCreateCompanionBuilder,
      $$PetWeightsTableUpdateCompanionBuilder,
      (PetWeight, $$PetWeightsTableReferences),
      PetWeight,
      PrefetchHooks Function({bool pet})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> journalEntryId,
      required String entryText,
      Value<DateTime> createdDateTime,
      Value<DateTime?> lastUpdatedDateTime,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> journalEntryId,
      Value<String> entryText,
      Value<DateTime> createdDateTime,
      Value<DateTime?> lastUpdatedDateTime,
    });

final class $$JournalEntriesTableReferences
    extends
        BaseReferences<_$DatabaseService, $JournalEntriesTable, JournalEntry> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$JournalEntryTagsTable, List<JournalEntryTag>>
  _journalEntryTagsRefsTable(_$DatabaseService db) =>
      MultiTypedResultKey.fromTable(
        db.journalEntryTags,
        aliasName: $_aliasNameGenerator(
          db.journalEntries.journalEntryId,
          db.journalEntryTags.journalEntryId,
        ),
      );

  $$JournalEntryTagsTableProcessedTableManager get journalEntryTagsRefs {
    final manager =
        $$JournalEntryTagsTableTableManager($_db, $_db.journalEntryTags).filter(
          (f) => f.journalEntryId.journalEntryId.sqlEquals(
            $_itemColumn<int>('journal_entry_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _journalEntryTagsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PetJournalEntriesTable, List<PetJournalEntry>>
  _petJournalEntriesRefsTable(_$DatabaseService db) =>
      MultiTypedResultKey.fromTable(
        db.petJournalEntries,
        aliasName: $_aliasNameGenerator(
          db.journalEntries.journalEntryId,
          db.petJournalEntries.journalEntryId,
        ),
      );

  $$PetJournalEntriesTableProcessedTableManager get petJournalEntriesRefs {
    final manager =
        $$PetJournalEntriesTableTableManager(
          $_db,
          $_db.petJournalEntries,
        ).filter(
          (f) => f.journalEntryId.journalEntryId.sqlEquals(
            $_itemColumn<int>('journal_entry_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _petJournalEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$DatabaseService, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryText => $composableBuilder(
    column: $table.entryText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdDateTime => $composableBuilder(
    column: $table.createdDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDateTime => $composableBuilder(
    column: $table.lastUpdatedDateTime,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> journalEntryTagsRefs(
    Expression<bool> Function($$JournalEntryTagsTableFilterComposer f) f,
  ) {
    final $$JournalEntryTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntryTags,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntryTagsTableFilterComposer(
            $db: $db,
            $table: $db.journalEntryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> petJournalEntriesRefs(
    Expression<bool> Function($$PetJournalEntriesTableFilterComposer f) f,
  ) {
    final $$PetJournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.petJournalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetJournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.petJournalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$DatabaseService, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryText => $composableBuilder(
    column: $table.entryText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDateTime => $composableBuilder(
    column: $table.createdDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDateTime => $composableBuilder(
    column: $table.lastUpdatedDateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$DatabaseService, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get journalEntryId => $composableBuilder(
    column: $table.journalEntryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryText =>
      $composableBuilder(column: $table.entryText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdDateTime => $composableBuilder(
    column: $table.createdDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDateTime => $composableBuilder(
    column: $table.lastUpdatedDateTime,
    builder: (column) => column,
  );

  Expression<T> journalEntryTagsRefs<T extends Object>(
    Expression<T> Function($$JournalEntryTagsTableAnnotationComposer a) f,
  ) {
    final $$JournalEntryTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntryTags,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntryTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> petJournalEntriesRefs<T extends Object>(
    Expression<T> Function($$PetJournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$PetJournalEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.journalEntryId,
          referencedTable: $db.petJournalEntries,
          getReferencedColumn: (t) => t.journalEntryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PetJournalEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.petJournalEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntry, $$JournalEntriesTableReferences),
          JournalEntry,
          PrefetchHooks Function({
            bool journalEntryTagsRefs,
            bool petJournalEntriesRefs,
          })
        > {
  $$JournalEntriesTableTableManager(
    _$DatabaseService db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> journalEntryId = const Value.absent(),
                Value<String> entryText = const Value.absent(),
                Value<DateTime> createdDateTime = const Value.absent(),
                Value<DateTime?> lastUpdatedDateTime = const Value.absent(),
              }) => JournalEntriesCompanion(
                journalEntryId: journalEntryId,
                entryText: entryText,
                createdDateTime: createdDateTime,
                lastUpdatedDateTime: lastUpdatedDateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> journalEntryId = const Value.absent(),
                required String entryText,
                Value<DateTime> createdDateTime = const Value.absent(),
                Value<DateTime?> lastUpdatedDateTime = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                journalEntryId: journalEntryId,
                entryText: entryText,
                createdDateTime: createdDateTime,
                lastUpdatedDateTime: lastUpdatedDateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({journalEntryTagsRefs = false, petJournalEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (journalEntryTagsRefs) db.journalEntryTags,
                    if (petJournalEntriesRefs) db.petJournalEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (journalEntryTagsRefs)
                        await $_getPrefetchedData<
                          JournalEntry,
                          $JournalEntriesTable,
                          JournalEntryTag
                        >(
                          currentTable: table,
                          referencedTable: $$JournalEntriesTableReferences
                              ._journalEntryTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JournalEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntryTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.journalEntryId == item.journalEntryId,
                              ),
                          typedResults: items,
                        ),
                      if (petJournalEntriesRefs)
                        await $_getPrefetchedData<
                          JournalEntry,
                          $JournalEntriesTable,
                          PetJournalEntry
                        >(
                          currentTable: table,
                          referencedTable: $$JournalEntriesTableReferences
                              ._petJournalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JournalEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).petJournalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.journalEntryId == item.journalEntryId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntry, $$JournalEntriesTableReferences),
      JournalEntry,
      PrefetchHooks Function({
        bool journalEntryTagsRefs,
        bool petJournalEntriesRefs,
      })
    >;
typedef $$JournalEntryTagsTableCreateCompanionBuilder =
    JournalEntryTagsCompanion Function({
      Value<int> journalEntryTagId,
      required int journalEntryId,
      required String tag,
    });
typedef $$JournalEntryTagsTableUpdateCompanionBuilder =
    JournalEntryTagsCompanion Function({
      Value<int> journalEntryTagId,
      Value<int> journalEntryId,
      Value<String> tag,
    });

final class $$JournalEntryTagsTableReferences
    extends
        BaseReferences<
          _$DatabaseService,
          $JournalEntryTagsTable,
          JournalEntryTag
        > {
  $$JournalEntryTagsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JournalEntriesTable _journalEntryIdTable(_$DatabaseService db) =>
      db.journalEntries.createAlias(
        $_aliasNameGenerator(
          db.journalEntryTags.journalEntryId,
          db.journalEntries.journalEntryId,
        ),
      );

  $$JournalEntriesTableProcessedTableManager get journalEntryId {
    final $_column = $_itemColumn<int>('journal_entry_id')!;

    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.journalEntryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journalEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalEntryTagsTableFilterComposer
    extends Composer<_$DatabaseService, $JournalEntryTagsTable> {
  $$JournalEntryTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get journalEntryTagId => $composableBuilder(
    column: $table.journalEntryTagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  $$JournalEntriesTableFilterComposer get journalEntryId {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntryTagsTableOrderingComposer
    extends Composer<_$DatabaseService, $JournalEntryTagsTable> {
  $$JournalEntryTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get journalEntryTagId => $composableBuilder(
    column: $table.journalEntryTagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  $$JournalEntriesTableOrderingComposer get journalEntryId {
    final $$JournalEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntryTagsTableAnnotationComposer
    extends Composer<_$DatabaseService, $JournalEntryTagsTable> {
  $$JournalEntryTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get journalEntryTagId => $composableBuilder(
    column: $table.journalEntryTagId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  $$JournalEntriesTableAnnotationComposer get journalEntryId {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntryTagsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $JournalEntryTagsTable,
          JournalEntryTag,
          $$JournalEntryTagsTableFilterComposer,
          $$JournalEntryTagsTableOrderingComposer,
          $$JournalEntryTagsTableAnnotationComposer,
          $$JournalEntryTagsTableCreateCompanionBuilder,
          $$JournalEntryTagsTableUpdateCompanionBuilder,
          (JournalEntryTag, $$JournalEntryTagsTableReferences),
          JournalEntryTag,
          PrefetchHooks Function({bool journalEntryId})
        > {
  $$JournalEntryTagsTableTableManager(
    _$DatabaseService db,
    $JournalEntryTagsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntryTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntryTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntryTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> journalEntryTagId = const Value.absent(),
                Value<int> journalEntryId = const Value.absent(),
                Value<String> tag = const Value.absent(),
              }) => JournalEntryTagsCompanion(
                journalEntryTagId: journalEntryTagId,
                journalEntryId: journalEntryId,
                tag: tag,
              ),
          createCompanionCallback:
              ({
                Value<int> journalEntryTagId = const Value.absent(),
                required int journalEntryId,
                required String tag,
              }) => JournalEntryTagsCompanion.insert(
                journalEntryTagId: journalEntryTagId,
                journalEntryId: journalEntryId,
                tag: tag,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntryTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({journalEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (journalEntryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.journalEntryId,
                                referencedTable:
                                    $$JournalEntryTagsTableReferences
                                        ._journalEntryIdTable(db),
                                referencedColumn:
                                    $$JournalEntryTagsTableReferences
                                        ._journalEntryIdTable(db)
                                        .journalEntryId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalEntryTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $JournalEntryTagsTable,
      JournalEntryTag,
      $$JournalEntryTagsTableFilterComposer,
      $$JournalEntryTagsTableOrderingComposer,
      $$JournalEntryTagsTableAnnotationComposer,
      $$JournalEntryTagsTableCreateCompanionBuilder,
      $$JournalEntryTagsTableUpdateCompanionBuilder,
      (JournalEntryTag, $$JournalEntryTagsTableReferences),
      JournalEntryTag,
      PrefetchHooks Function({bool journalEntryId})
    >;
typedef $$PetJournalEntriesTableCreateCompanionBuilder =
    PetJournalEntriesCompanion Function({
      required int petId,
      required int journalEntryId,
      Value<int> rowid,
    });
typedef $$PetJournalEntriesTableUpdateCompanionBuilder =
    PetJournalEntriesCompanion Function({
      Value<int> petId,
      Value<int> journalEntryId,
      Value<int> rowid,
    });

final class $$PetJournalEntriesTableReferences
    extends
        BaseReferences<
          _$DatabaseService,
          $PetJournalEntriesTable,
          PetJournalEntry
        > {
  $$PetJournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PetsTable _petIdTable(_$DatabaseService db) => db.pets.createAlias(
    $_aliasNameGenerator(db.petJournalEntries.petId, db.pets.petId),
  );

  $$PetsTableProcessedTableManager get petId {
    final $_column = $_itemColumn<int>('pet_id')!;

    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.petId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_petIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JournalEntriesTable _journalEntryIdTable(_$DatabaseService db) =>
      db.journalEntries.createAlias(
        $_aliasNameGenerator(
          db.petJournalEntries.journalEntryId,
          db.journalEntries.journalEntryId,
        ),
      );

  $$JournalEntriesTableProcessedTableManager get journalEntryId {
    final $_column = $_itemColumn<int>('journal_entry_id')!;

    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.journalEntryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journalEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PetJournalEntriesTableFilterComposer
    extends Composer<_$DatabaseService, $PetJournalEntriesTable> {
  $$PetJournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PetsTableFilterComposer get petId {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JournalEntriesTableFilterComposer get journalEntryId {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetJournalEntriesTableOrderingComposer
    extends Composer<_$DatabaseService, $PetJournalEntriesTable> {
  $$PetJournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PetsTableOrderingComposer get petId {
    final $$PetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableOrderingComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JournalEntriesTableOrderingComposer get journalEntryId {
    final $$JournalEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetJournalEntriesTableAnnotationComposer
    extends Composer<_$DatabaseService, $PetJournalEntriesTable> {
  $$PetJournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PetsTableAnnotationComposer get petId {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.petId,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.petId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JournalEntriesTableAnnotationComposer get journalEntryId {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetJournalEntriesTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $PetJournalEntriesTable,
          PetJournalEntry,
          $$PetJournalEntriesTableFilterComposer,
          $$PetJournalEntriesTableOrderingComposer,
          $$PetJournalEntriesTableAnnotationComposer,
          $$PetJournalEntriesTableCreateCompanionBuilder,
          $$PetJournalEntriesTableUpdateCompanionBuilder,
          (PetJournalEntry, $$PetJournalEntriesTableReferences),
          PetJournalEntry,
          PrefetchHooks Function({bool petId, bool journalEntryId})
        > {
  $$PetJournalEntriesTableTableManager(
    _$DatabaseService db,
    $PetJournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetJournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetJournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetJournalEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> petId = const Value.absent(),
                Value<int> journalEntryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PetJournalEntriesCompanion(
                petId: petId,
                journalEntryId: journalEntryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int petId,
                required int journalEntryId,
                Value<int> rowid = const Value.absent(),
              }) => PetJournalEntriesCompanion.insert(
                petId: petId,
                journalEntryId: journalEntryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PetJournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({petId = false, journalEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (petId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.petId,
                                referencedTable:
                                    $$PetJournalEntriesTableReferences
                                        ._petIdTable(db),
                                referencedColumn:
                                    $$PetJournalEntriesTableReferences
                                        ._petIdTable(db)
                                        .petId,
                              )
                              as T;
                    }
                    if (journalEntryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.journalEntryId,
                                referencedTable:
                                    $$PetJournalEntriesTableReferences
                                        ._journalEntryIdTable(db),
                                referencedColumn:
                                    $$PetJournalEntriesTableReferences
                                        ._journalEntryIdTable(db)
                                        .journalEntryId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PetJournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $PetJournalEntriesTable,
      PetJournalEntry,
      $$PetJournalEntriesTableFilterComposer,
      $$PetJournalEntriesTableOrderingComposer,
      $$PetJournalEntriesTableAnnotationComposer,
      $$PetJournalEntriesTableCreateCompanionBuilder,
      $$PetJournalEntriesTableUpdateCompanionBuilder,
      (PetJournalEntry, $$PetJournalEntriesTableReferences),
      PetJournalEntry,
      PrefetchHooks Function({bool petId, bool journalEntryId})
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> settingsId,
      Value<bool> acceptedTermsAndConditions,
      Value<bool> onBoardingComplete,
      Value<bool> optIntoAnalyticsWarning,
      Value<String?> lastUsedVersion,
      Value<int?> defaultWeightUnit,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> settingsId,
      Value<bool> acceptedTermsAndConditions,
      Value<bool> onBoardingComplete,
      Value<bool> optIntoAnalyticsWarning,
      Value<String?> lastUsedVersion,
      Value<int?> defaultWeightUnit,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$DatabaseService, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get settingsId => $composableBuilder(
    column: $table.settingsId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get acceptedTermsAndConditions => $composableBuilder(
    column: $table.acceptedTermsAndConditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onBoardingComplete => $composableBuilder(
    column: $table.onBoardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get optIntoAnalyticsWarning => $composableBuilder(
    column: $table.optIntoAnalyticsWarning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUsedVersion => $composableBuilder(
    column: $table.lastUsedVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultWeightUnit => $composableBuilder(
    column: $table.defaultWeightUnit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$DatabaseService, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get settingsId => $composableBuilder(
    column: $table.settingsId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get acceptedTermsAndConditions => $composableBuilder(
    column: $table.acceptedTermsAndConditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onBoardingComplete => $composableBuilder(
    column: $table.onBoardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get optIntoAnalyticsWarning => $composableBuilder(
    column: $table.optIntoAnalyticsWarning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUsedVersion => $composableBuilder(
    column: $table.lastUsedVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultWeightUnit => $composableBuilder(
    column: $table.defaultWeightUnit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$DatabaseService, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get settingsId => $composableBuilder(
    column: $table.settingsId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get acceptedTermsAndConditions => $composableBuilder(
    column: $table.acceptedTermsAndConditions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onBoardingComplete => $composableBuilder(
    column: $table.onBoardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get optIntoAnalyticsWarning => $composableBuilder(
    column: $table.optIntoAnalyticsWarning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastUsedVersion => $composableBuilder(
    column: $table.lastUsedVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultWeightUnit => $composableBuilder(
    column: $table.defaultWeightUnit,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$DatabaseService,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$DatabaseService, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$DatabaseService db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> settingsId = const Value.absent(),
                Value<bool> acceptedTermsAndConditions = const Value.absent(),
                Value<bool> onBoardingComplete = const Value.absent(),
                Value<bool> optIntoAnalyticsWarning = const Value.absent(),
                Value<String?> lastUsedVersion = const Value.absent(),
                Value<int?> defaultWeightUnit = const Value.absent(),
              }) => SettingsCompanion(
                settingsId: settingsId,
                acceptedTermsAndConditions: acceptedTermsAndConditions,
                onBoardingComplete: onBoardingComplete,
                optIntoAnalyticsWarning: optIntoAnalyticsWarning,
                lastUsedVersion: lastUsedVersion,
                defaultWeightUnit: defaultWeightUnit,
              ),
          createCompanionCallback:
              ({
                Value<int> settingsId = const Value.absent(),
                Value<bool> acceptedTermsAndConditions = const Value.absent(),
                Value<bool> onBoardingComplete = const Value.absent(),
                Value<bool> optIntoAnalyticsWarning = const Value.absent(),
                Value<String?> lastUsedVersion = const Value.absent(),
                Value<int?> defaultWeightUnit = const Value.absent(),
              }) => SettingsCompanion.insert(
                settingsId: settingsId,
                acceptedTermsAndConditions: acceptedTermsAndConditions,
                onBoardingComplete: onBoardingComplete,
                optIntoAnalyticsWarning: optIntoAnalyticsWarning,
                lastUsedVersion: lastUsedVersion,
                defaultWeightUnit: defaultWeightUnit,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$DatabaseService,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$DatabaseService, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $DatabaseServiceManager {
  final _$DatabaseService _db;
  $DatabaseServiceManager(this._db);
  $$SpeciesTypesTableTableManager get speciesTypes =>
      $$SpeciesTypesTableTableManager(_db, _db.speciesTypes);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$PetMedsTableTableManager get petMeds =>
      $$PetMedsTableTableManager(_db, _db.petMeds);
  $$PetVaccinationsTableTableManager get petVaccinations =>
      $$PetVaccinationsTableTableManager(_db, _db.petVaccinations);
  $$PetWeightsTableTableManager get petWeights =>
      $$PetWeightsTableTableManager(_db, _db.petWeights);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$JournalEntryTagsTableTableManager get journalEntryTags =>
      $$JournalEntryTagsTableTableManager(_db, _db.journalEntryTags);
  $$PetJournalEntriesTableTableManager get petJournalEntries =>
      $$PetJournalEntriesTableTableManager(_db, _db.petJournalEntries);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
