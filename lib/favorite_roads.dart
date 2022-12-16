import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/auth_controller.dart';
import 'package:youbike/fav_route_card.dart';

import 'DTO/user.dart';
import 'custom_drawer.dart';

DatabaseManager db = DatabaseManager();
List roads = [];

class FavRoutesList extends StatefulWidget {
  const FavRoutesList({super.key});

  @override
  State<FavRoutesList> createState() => _FavRoutesListState();
}

class _FavRoutesListState extends State<FavRoutesList> {
  @override
  Widget build(BuildContext context) {
    getFavRoads(AuthController.instance.auth.currentUser?.uid);
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

  getFavRoads(String? id) async {
    roads = await db.getFavRoads(id: id);
    setState(() {});
  }
}
