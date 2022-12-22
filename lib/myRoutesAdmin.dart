import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/DTO/route_shape.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/auth_controller.dart';

import 'DTO/user.dart';
import 'admin_roads_card.dart';
import 'custom_drawer.dart';

DatabaseManager db = DatabaseManager();
List roads = [];

class MyRoutesAdmin extends StatefulWidget {
  const MyRoutesAdmin({super.key});

  @override
  State<MyRoutesAdmin> createState() => _RoutesListState();
}

class _RoutesListState extends State<MyRoutesAdmin> {
  

  @override
  Widget build(BuildContext context) {
    getFavRoads();
    return Scaffold(
      appBar: AppBar(title: const Text('My Roads Admin')),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: roads.length,
          itemBuilder: (context, index) {
            return MyAdminRoads(roads[index] as Road);
          },
        ),
      ),
    );
  }

  getFavRoads() async {
    roads = await db.getMyRoads();
    setState(() {});
  }
}
