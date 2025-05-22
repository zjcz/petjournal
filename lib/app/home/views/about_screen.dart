import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petjournal/app/home/views/policy_viewer_screen.dart';
import 'package:petjournal/route_config.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'unknown',
    packageName: 'unknown',
    version: 'unknown',
    buildNumber: 'unknown',
  );

  final petJournalWebSiteUrl = Uri(
    scheme: 'https',
    host: 'happybunnysoftware.co.uk',
    path: 'petjournal',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20.0,
              children: [
                Image.asset('assets/images/icon.png'),
                Text(
                  'Pet Journal',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'by Happy Bunny Software Ltd',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Version: ${_packageInfo.version}, build: ${_packageInfo.buildNumber}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ElevatedButton(
                  child: const Text('Visit Website'),
                  onPressed: () => _launchInBrowser(petJournalWebSiteUrl),
                ),
                ElevatedButton(
                  child: const Text('Terms and Conditions'),
                  onPressed: () {
                    context.push(
                      RouteDefs.policyViewer,
                      extra: PolicyType.termsAndConditions,
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Privacy Policy'),
                  onPressed: () {
                    context.push(
                      RouteDefs.policyViewer,
                      extra: PolicyType.privacyPolicy,
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('3rd Party Licenses'),
                  onPressed: () {
                    showLicensePage(context: context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unable to launch website')));
    }
  }
}
