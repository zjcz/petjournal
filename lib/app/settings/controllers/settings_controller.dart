import 'package:petjournal/app/settings/models/settings_model.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/mapper/settings_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:petjournal/data/database/database_service.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  late final DatabaseService _databaseService =
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(DatabaseService.provider);

  @override
  Stream<SettingsModel> build() {
    return _databaseService.watchSettings().map(
      (s) => SettingsMapper.mapToModel(s),
    );
  }

  Future<bool> saveOnboardingSettings(
    bool acceptedTermsAndConditions,
    bool optIntoAnalyticsWarning,
    bool onBoardingComplete,
  ) async {
    var updateCount = await _databaseService.saveSettingsOnboarding(
      acceptedTermsAndConditions,
      optIntoAnalyticsWarning,
      onBoardingComplete,
    );

    if (updateCount == 1) {
      ref.invalidateSelf();
      return true;
    }

    return false;
  }

  Future<bool> saveUserSettings(
    WeightUnits? defaultWeightUnit,
    bool? optIntoAnalyticsWarning,
  ) async {
    var updateCount = await _databaseService.saveSettingsUser(
      defaultWeightUnit,
      optIntoAnalyticsWarning,
    );

    if (updateCount == 1) {
      ref.invalidateSelf();
      return true;
    }

    return false;
  }
}
