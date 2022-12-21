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

class RoutesList extends StatefulWidget {
  const RoutesList({super.key});

  @override
  State<RoutesList> createState() => _RoutesListState();
}

class _RoutesListState extends State<RoutesList> {
  @override
  Widget build(BuildContext context) {
    getRoads();
    return Scaffold(
      appBar: AppBar(title: const Text('Roads Created by ME')),
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

  getRoads() async {
    roads = await db.getRoads();
    setState(() {});
  }

  addToFavorite(String? id, String roadId) async {
    DatabaseManager db = DatabaseManager();
    await db.addToFavoriteRoads(id: id, roadId: roadId);
  }

  deleteFromFav(String? id, String roadId) async {
    DatabaseManager db = DatabaseManager();
    await db.removeFromFavoriteRoads(id: id, roadId: roadId);
  }
}
