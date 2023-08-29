import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:helpers/helpers.dart';
import 'package:http/http.dart' as http;

import 'launch_url.dart';

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

        /// Fallback font family needed to display emojis in color.
        fontFamilyFallback: const ['Noto Color Emoji'],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      this.index = index;

      switch (index) {
        case 1:
          body = const _ReleaseNotesExample();
          break;
        default:
          body = home;
      }
    });
  }

  static const Widget home = Center(
    child: SizedBox(
      width: 300,
      height: 300,
      child: Text('Demonstrate and test helper package features'),
    ),
  );

  Widget body = home;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final bool isSmall = width < 600;

    // Define the list of destinations to be used within the app.
    const List<NavigationDestination> destinations = <NavigationDestination>[
      NavigationDestination(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
      NavigationDestination(
        label: 'Release Notes',
        icon: Icon(Icons.notes),
      ),
    ];

    Widget bodyContainer = Stack(
      children: [
        if (!isSmall) const VerticalDivider(),
        body,
      ],
    );

    // Workaround for bug: https://github.com/flutter/flutter/issues/121392
    final selectedLabelTextStyle = Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary) ??
        const TextStyle();

    return Scaffold(
      body: AdaptiveLayout(
        // Primary navigation config has nothing from 0 to 600 dp screen width,
        // then an unextended NavigationRail with no labels and just icons then an
        // extended NavigationRail with both icons and labels.
        primaryNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.medium: SlotLayout.from(
              inAnimation: AdaptiveScaffold.leftOutIn,
              key: const Key('Primary Navigation Medium'),
              builder: (_) => AdaptiveScaffold.standardNavigationRail(
                destinations: destinations
                    .map((_) => AdaptiveScaffold.toRailDestination(_))
                    .toList(),
                onDestinationSelected: _onDestinationSelected,
                selectedIndex: index,
                selectedLabelTextStyle: selectedLabelTextStyle,
              ),
            ),
            Breakpoints.large: SlotLayout.from(
              key: const Key('Primary Navigation Large'),
              inAnimation: AdaptiveScaffold.leftOutIn,
              builder: (_) => AdaptiveScaffold.standardNavigationRail(
                extended: true,
                destinations: destinations
                    .map((_) => AdaptiveScaffold.toRailDestination(_))
                    .toList(),
                onDestinationSelected: _onDestinationSelected,
                selectedIndex: index,
                selectedLabelTextStyle: selectedLabelTextStyle,
              ),
            ),
          },
        ),
        body: SlotLayout(
          config: {
            Breakpoints.standard: SlotLayout.from(
              key: const Key('Body Standard'),
              builder: (_) => bodyContainer,
            ),
          },
        ),
      ),
    );
  }
}

class _ReleaseNotesExample extends StatelessWidget {
  const _ReleaseNotesExample();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Release Notes'),
          ElevatedButton(
            onPressed: () => _showReleaseNotes(context),
            child: const Text('Show Release Notes'),
          ),
        ],
      ),
    );
  }

  Future<void> _showReleaseNotes(BuildContext context) async {
    final releaseNotesService = ReleaseNotesService(
      client: http.Client(),
      repository: 'merrit/nyrna',
    );

    final releaseNotes = await releaseNotesService.getReleaseNotes('v2.17.0');
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
          launchURL: (url) => launchURL(url),
          onClose: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
