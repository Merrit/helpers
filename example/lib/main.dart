import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromRGBO(0, 179, 255, 1),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.time_to_leave),
                label: Text('TextInputListTile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.disabled_by_default_outlined),
                label: Text('Placeholder'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.disabled_by_default_outlined),
                label: Text('Placeholder'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (int value) {
              switch (value) {
                case 0:
                  break;
                default:
              }

              setState(() => selectedIndex = value);
            },
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(80.0),
              child: BodyWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _showReleaseNotesDialog(context);
          },
          child: const Text('Show release notes dialog'),
        ),
        const _TextInputListTileExample(),
      ],
    );
  }

  Future<void> _showReleaseNotesDialog(BuildContext context) async {
    final releaseNotesService =
        ReleaseNotesService(client: http.Client(), repository: 'merrit/nyrna');

    final releaseNotes = await releaseNotesService.getReleaseNotes('v2.11.0');
    if (releaseNotes == null) return;

    // ignore until fixed:https://github.com/dart-lang/linter/issues/4007
    // ignore: use_build_context_synchronously
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return ReleaseNotesDialog(
          releaseNotes: releaseNotes,
          showDonateButton: true,
          donateCallback: () {},
          launchURL: (url) {},
          onClose: () {},
        );
      },
    );
  }
}

class _TextInputListTileExample extends StatelessWidget {
  const _TextInputListTileExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.flutter_dash),
        Flexible(
          child: TextInputListTile(
            placeholderText: 'TextInputListTile',
            editingPlaceholderText: false,
            retainFocus: true,
            textAlign: TextAlign.center,
            callback: (value) {},
          ),
        ),
        const Icon(Icons.hot_tub),
      ],
    );
  }
}
