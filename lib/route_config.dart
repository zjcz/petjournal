import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/app/home/views/about_screen.dart';
import 'package:petjournal/app/home/views/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/app/home/views/policy_viewer_screen.dart';
import 'package:petjournal/app/home/views/welcome_screen.dart';
import 'package:petjournal/app/pet/views/edit_pet_screen.dart';
import 'package:petjournal/app/pet/views/view_pet_screen.dart';
import 'package:petjournal/app/settings/controllers/settings_controller.dart';
import 'package:petjournal/app/settings/views/settings_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_config.g.dart';

class RouteDefs {
  static const String home = '/home';
  static const String welcome = '/welcome';
  static const String viewPet = '/home/view_pet';
  static const String editPet = '/home/edit_pet';
  static const String aboutScreen = '/home/about_screen';
  static const String editSettings = '/home/edit_settings';
  // static const String loading = '/';
  static const String policyViewer = '/policy_view';

  static String getPageName(String pageName, {String? parentPage}) {
    return pageName.replaceAll(parentPage ?? '', '').substring(1);
  }
}

// The route configuration.
@riverpod
GoRouter setupRouter(Ref ref) {
  return GoRouter(
    initialLocation: RouteDefs.home,
    //initialExtra: initialExtra,
    //observers: observers,
    redirect: (context, state) {
      final settings = ref.read(settingsControllerProvider).requireValue;
      final path = state.uri.path;
      if (!settings.onBoardingComplete) {
        if (path != RouteDefs.welcome) {
          return RouteDefs.welcome;
        }
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: RouteDefs.home,
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: RouteDefs.getPageName(
              RouteDefs.aboutScreen,
              parentPage: RouteDefs.home,
            ),
            name: 'aboutScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const AboutScreen();
            },
          ),
          GoRoute(
            path: '${RouteDefs.getPageName(
              RouteDefs.viewPet,
              parentPage: RouteDefs.home,
            )}/:petId',
            name: 'viewPet',
            builder: (BuildContext context, GoRouterState state) {
              return ViewPetScreen(petId:  int.parse(state.pathParameters['petId']!));
            },
          ),
          GoRoute(
            path: RouteDefs.getPageName(
              RouteDefs.editPet,
              parentPage: RouteDefs.home,
            ),
            name: 'editPet',
            builder: (BuildContext context, GoRouterState state) {
              PetModel? p;
              if (state.extra != null) {
                p = state.extra! as PetModel;
              }
              return EditPetScreen(pet: p);
            },
          ),
          GoRoute(
            path: RouteDefs.getPageName(
              RouteDefs.editSettings,
              parentPage: RouteDefs.home,
            ),
            name: 'editSettings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteDefs.getPageName(RouteDefs.policyViewer),
        name: 'policyViewer',
        builder: (BuildContext context, GoRouterState state) {
          PolicyType? policyType;
          if (state.extra != null) {
            policyType = state.extra! as PolicyType;
          }
          return PolicyViewerScreen(
            policyType: policyType ?? PolicyType.termsAndConditions,
          );
        },
      ),
      GoRoute(
        path: RouteDefs.welcome,
        name: 'welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
    ],
  );
}
