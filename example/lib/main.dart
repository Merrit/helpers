import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
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

  Widget child = const _TextInputListTileExample();

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
                  child = const _TextInputListTileExample();
                  break;
                default:
                  child = const Placeholder();
              }

              setState(() => selectedIndex = value);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: child,
            ),
          ),
        ],
      ),
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
            editingPlaceholderText: true,
            textAlign: TextAlign.center,
            callback: (value) {},
          ),
        ),
        const Icon(Icons.hot_tub),
      ],
    );
  }
}
