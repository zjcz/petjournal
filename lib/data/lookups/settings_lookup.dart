import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/app/settings/models/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_lookup.g.dart';

/// Class to get the Settings
class SettingsLookup {
  SettingsModel? _settings;

  static final SettingsLookup _instance = SettingsLookup._internal();

  factory SettingsLookup() {
    return _instance;
  }

  SettingsLookup._internal();

  /// Refresh the settings
  void refreshSettings(SettingsModel settings) {
    _settings = settings;
  }

  /// Get a SettingsModel object
  SettingsModel? getSettings() {
    return _settings;
  }
}

@Riverpod(keepAlive: true)
Future<void> populateSettingsLookup(Ref ref) async {
  final settings = await ref.watch(settingsControllerProvider.future);
  SettingsLookup().refreshSettings(settings);
}
