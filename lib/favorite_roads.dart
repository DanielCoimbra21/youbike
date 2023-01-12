import 'package:flutter/material.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/fav_route_card.dart';
import 'custom_drawer.dart';

DatabaseManager db = DatabaseManager();
List roads = [];

///Page that displays all the Favorite Roads of an user
class FavRoutesList extends StatefulWidget {
  const FavRoutesList({super.key});

  @override
  State<FavRoutesList> createState() => _FavRoutesListState();
}

class _FavRoutesListState extends State<FavRoutesList> {
  @override
  Widget build(BuildContext context) {
    getFavRoads();
    return Scaffold(
      appBar: AppBar(title: const Text('My favorites')),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: roads.length,
          itemBuilder: (context, index) {
            return RouteCard(roads[index] as Road);
          },
        ),
      ),
    );
  }

  //database query to  fetch all the favorite roads
  getFavRoads() async {
    roads = await db.getFavRoads();
    setState(() {});
  }
}
