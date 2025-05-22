import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/app/settings/views/widgets/edit_settings_widget.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
//import 'package:petjournal/helpers/analytics_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const settingDeleteAllKey = Key('deleteAllButton');

  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _unsavedChanges = false;
  EditSettingsData? _userSettings;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsData = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: context.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                backgroundColor: context.primary,
                color: context.onPrimary,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate() && _userSettings != null) {
                if (!await _saveData()) {
                  // an error occurred and we cannot save?
                  return;
                }

                if (!context.mounted) return;
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            canPop: !_unsavedChanges,
            onPopInvokedWithResult: (bool didPop, _) async {
              if (didPop) {
                return;
              }
              await _showSaveChangesDialog();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 20.0,
                children: [
                  settingsData.when(
                    data: (settings) {
                      _userSettings ??= EditSettingsData(
                        weightUnits: settings.defaultWeightUnit,
                        optIntoAnalyticsWarning:
                            settings.optIntoAnalyticsWarning,
                      );
                      return EditSettingsWidget(
                        userSettings: _userSettings!,
                        onChanged: (EditSettingsData updated) {
                          setState(() {
                            _userSettings = updated;
                            _unsavedChanges = true;
                          });
                        },
                      );
                    },
                    loading: () => buildLoadingWidget(),
                    error: (error, _) => buildErrorWidget(error),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      key: SettingsScreen.settingDeleteAllKey,
                      onPressed: () async {
                        await _showDeleteAllDialog();
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'Delete All',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildErrorWidget(Object error) {
    return Center(child: Text('Error loading settings: $error'));
  }

  Future<bool> _saveData() async {
    if (_userSettings == null) return false;

    await ref
        .read(settingsControllerProvider.notifier)
        .saveUserSettings(_userSettings?.weightUnits, _userSettings?.optIntoAnalyticsWarning);

    // // enable / disable analytics
    // getIt<AnalyticsHelper>()
    //     .enableAnalytics(_userSettings!.optIntoAnalyticsWarning);

    return true;
  }

  Future<void> _showSaveChangesDialog() async {
    final bool? shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Any unsaved changes will be lost!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes, discard my changes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('No, continue editing'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );

    if (shouldDiscard ?? false) {
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  Future<void> _showDeleteAllDialog() async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete All Data?'),
          content: const Text(
            'Are you sure you want to delete all data in the app?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );

    if (shouldDelete ?? false) {
      final databaseService = ref.read(DatabaseService.provider);

      try {
        await databaseService.clearAllData();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing data: $e')),
        );
        return;
      }
      
      // Show success message
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All data removed successfully!')),
      );

      context.go(RouteDefs.home);
    }
  }
}
