import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/data/mapper/species_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'species_controller.g.dart';

@riverpod
class SpeciesController extends _$SpeciesController {
  late final DatabaseService _databaseService =
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  ref.read(DatabaseService.provider);

  @override
  Stream<List<SpeciesModel>> build() {
    return _databaseService.getAllSpeciesTypes().map(
      (p) => SpeciesMapper.mapToModelList(p),
    );
  }
}
