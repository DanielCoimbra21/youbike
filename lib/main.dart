import 'package:youbike/map_page.dart';
import 'package:youbike/profile_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

//REfresh the screen with statefull
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
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: pages[currentPage],

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.route), label: 'Routes'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map')
        ],
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
            debugPrint(index.toString());
          });
        },
        selectedIndex: currentPage,
      ),

    //   drawer: Drawer(
    //     child: Material(
    //     // Add a ListView to the drawer. This ensures the user can scroll
    //     // through the options in the drawer if there isn't enough vertical
    //     // space to fit everything.
    //     child: ListView(
    //       // Important: Remove any padding from the ListView.
    //       padding: EdgeInsets.zero,
    //       children: [
    //         const DrawerHeader(
    //           decoration: BoxDecoration(color: Colors.pink),
    //           child: Text('Drawer Header'),
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.home),
    //           title: const Text('Home'),
    //           onTap: () {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(
    //                   builder: (BuildContext context) => const HomePage()),
    //             );

    //             //Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.route),
    //           title: const Text('My Routes'),
    //           onTap: () {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(
    //                   builder: (BuildContext context) => const RoutesPage()),
    //             );
    //             //Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.map),
    //           title: const Text('Map'),
    //           onTap: () {
    //             Navigator.of(context).pushReplacement(
    //               MaterialPageRoute(
    //                 builder: (context) => const MapPage(),
    //               ),
    //             );
    //             Navigator.pop(context);
    //           },
    //         ),
    //         const Divider(color: Colors.black),
    //         ListTile(
    //           leading: const Icon(Icons.info),
    //           title: const Text('About'),
    //           onTap: () {
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.logout),
    //           title: const Text('Logout'),
    //           onTap: () {
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    );
  }
}
