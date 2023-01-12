import 'package:flutter/material.dart';
import 'package:youbike/favorite_roads.dart';
import 'package:youbike/geolocation.dart';
import 'package:youbike/myRoutesAdmin.dart';
import 'package:youbike/routes_list.dart';
import 'Database/firestore_reference.dart';
import 'about_page.dart';
import 'auth_controller.dart';

var emailController = TextEditingController();

///This Drawer class has the purpose
///of displaying the different pages
///so the user can navigate 
///
///it has a condition that tests if the user is Admin  or not
///and based on the result it displays or hides certain pages
///
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

DatabaseManager db = DatabaseManager();
String role = "";
bool isAdmin = true;

class _CustomDrawerState extends State<CustomDrawer> {
  getIsAdmin() async {
    role = await db.getUserRole();
    if (role == 'admin') {
      setState(() {
        isAdmin = false;
      });
    } else {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  initState() {
    super.initState();
    getIsAdmin();
  }

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
            Offstage(
              offstage: isAdmin,
              child: ListTile(
                leading: const Icon(Icons.route_outlined),
                title: const Text('My routes'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MyRoutesAdmin()),
                  );
                },
              ),
            ),
            Offstage(
              offstage: isAdmin,
              child: ListTile(
                leading: const Icon(Icons.map_sharp),
                title: const Text('Map'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Geolocation(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_road),
              title: const Text('All Routes'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const RoutesList()),
                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favourites Routes'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const FavRoutesList()),
                );
                //Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AboutPage()),
                );
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

