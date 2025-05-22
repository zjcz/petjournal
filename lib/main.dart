import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app_startup.dart';
import 'package:petjournal/route_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: PetJournalApp()));
}

class PetJournalApp extends ConsumerWidget {
  const PetJournalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouterConfig = ref.watch(setupRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouterConfig,
      builder: (_, child) {
        return AppStartupWidget(onLoaded: (_) => child!);
      },
      title: 'PetJournal',
      color: Colors.white,
      theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: ThemeMode.system,
      // Use the following when generating screenshots to remove the debug banner
      //debugShowCheckedModeBanner: false,
    );
  }
}
