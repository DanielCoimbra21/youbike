import 'package:youbike/map_page.dart';
import 'package:youbike/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DTO/firebase_options.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

//Refresh the screen with statefull
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [HomePage(), RoutesPage(), MapPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      // bottomNavigationBar: NavigationBar(
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //     NavigationDestination(icon: Icon(Icons.route), label: 'Routes'),
      //     NavigationDestination(icon: Icon(Icons.map), label: 'Map')
      //   ],
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPage = index;
      //       debugPrint(index.toString());
      //     });
      //   },
      //   selectedIndex: currentPage,
      // ),
    );
  }
}
