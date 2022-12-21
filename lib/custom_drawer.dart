import 'package:flutter/material.dart';
import 'package:youbike/favorite_roads.dart';
import 'package:youbike/myRoutesAdmin.dart';
import 'package:youbike/routes_list.dart';
import 'package:youbike/welcome_page.dart';
import 'auth_controller.dart';
import 'map_page.dart';

var emailController = TextEditingController();

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Scaffold(
        body: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Text('YouBike'),
            ),
            ListTile(
              leading: const Icon(Icons.route_outlined),
              title: const Text('My routes Admin'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const MyRoutesAdmin()),
                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map_sharp),
              title: const Text('Map'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MapPage(),
                  ),
                );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_road),
              title: const Text('My Routes'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const RoutesList()),
                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.festival),
              title: const Text('Fav Routes'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const FavRoutesList()),
                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          WelcomePage(email: emailController.text.trim())),
                );
                //Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                AuthController.instance.logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
