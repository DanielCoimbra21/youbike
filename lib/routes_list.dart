import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/Database/firestore_reference.dart';

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
      appBar: AppBar(title: const Text('Home')),
      drawer: const CustomDrawer(),
      body: ListView.builder(
        itemCount: roads.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('item $index'),
          );
        },
      ),
    );
  }

getRoads() async {
  roads = await db.getRoads();
  setState(() {
    
  });
  debugPrint('Tessttt');
}

}



// class Roads extends StatefulWidget{
// final Road road;

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }

// }

// Widget buildRoad(Road road) => ListTile(
//   leading: CircleAvatar(child: Text('${road.endPoint}')),
//   title: Text(road.startingPoint),
//   subtitle: Text(road.duration.toString()),
// );