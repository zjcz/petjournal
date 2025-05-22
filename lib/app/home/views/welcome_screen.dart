import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/home/views/policy_viewer_screen.dart';
import 'package:petjournal/app/home/views/widgets/terms_of_use_widget.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
//import 'package:petjournal/helpers/analytics_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/widgets/analytics_opt_in.dart';
import 'package:petjournal/widgets/custom_switch.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  static const welcomeAcceptTermsAndConditionsKey = Key(
    'acceptTermsAndConditions',
  );
  static const welcomeAcceptFinanicalAdviceWarningKey = Key(
    'acceptFinancialAdviceWarning',
  );
  static const welcomeOptIntoAnalyticsKey = Key('optIntoAnalytics');
  static const welcomeRestoreKey = Key('restoreButton');
  static const welcomeContinueKey = Key('continueButton');

  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool acceptTermsAndConditions = false;
  bool optIntoAnalyticsWarning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: const EdgeInsets.all(10.0),
        child: Container(
          margin: MediaQuery.of(context).padding,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20.0,
              children: [
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'to Pet Journal',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Text(
                  'PetJournal is a pet management app that helps you keep track of your pet\'s health, appointments, and more.',
                ),
                TermsOfUseWidget(
                  termsAndConditionsTap: () {
                    context.push(
                      RouteDefs.policyViewer,
                      extra: PolicyType.termsAndConditions,
                    );
                  },
                  privacyPolicyTap: () {
                    context.push(
                      RouteDefs.policyViewer,
                      extra: PolicyType.privacyPolicy,
                    );
                  },
                ),
                CustomSwitch(
                  key: WelcomeScreen.welcomeAcceptTermsAndConditionsKey,
                  labelText: 'I accept the terms and conditions',
                  switchValue: acceptTermsAndConditions,
                  onChanged: (newValue) {
                    setState(() {
                      acceptTermsAndConditions = newValue;
                    });
                  },
                ),
                AnalyticsOptIn(
                  key: WelcomeScreen.welcomeOptIntoAnalyticsKey,
                  optIntoAnalyticsValue: optIntoAnalyticsWarning,
                  onChanged: (newValue) {
                    setState(() {
                      optIntoAnalyticsWarning = newValue;
                    });
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    key: WelcomeScreen.welcomeContinueKey,
                    onPressed:
                        (!acceptTermsAndConditions)
                            ? null
                            : () async {
                              if (await _saveData()) {
                                // navigate to home page
                              }
                            },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: context.primary),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _saveData() async {
    if (!acceptTermsAndConditions) {
      return false;
    }
    try {
      final success = await ref
          .read(settingsControllerProvider.notifier)
          .saveOnboardingSettings(
            acceptTermsAndConditions,
            optIntoAnalyticsWarning,
            true,
          );
      if (!success) {
        return false;
      }
    } catch (e) {
      return false;
    }

    // if (optIntoAnalyticsWarning) {
    //   getIt<AnalyticsHelper>().enableAnalytics(true);
    // }

    if (context.mounted) {
      // navigate to home page
      if (!mounted) return false;
      context.go(RouteDefs.home);
    }

    return true;
  }
}
