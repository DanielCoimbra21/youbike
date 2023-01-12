import 'package:flutter/material.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'DTO/road.dart';
import 'custom_drawer.dart';
import 'fav_route_card.dart';

DatabaseManager db = DatabaseManager();
List roads = [];
bool isAscending = false;

class RoutesList extends StatefulWidget {
  const RoutesList({super.key});

  @override
  State<RoutesList> createState() => _RoutesListState();
}

class _RoutesListState extends State<RoutesList> {
  void handleClick(String value) {
    switch (value) {
      case 'Distance':
        sortByDistance();
        break;
      case 'Duration':
        sortByDuration();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getRoads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Roads'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Distance', 'Duration'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
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

  sortByDistance() {
    setState(() {
      roads.sort((a, b) => a.distance.compareTo(b.distance));
      if (isAscending) {
        isAscending = false;
      } else {
        roads = roads.reversed.toList();
        isAscending = true;
      }

      // print("-----sortByDistance-----");

      // for (var i = 0; i < roads.length; i++) {
      //   print(roads[i].distance);
      // }
    });
  }

  sortByDuration() {
    setState(() {
      roads.sort((a, b) => a.duration.compareTo(b.duration));
      if (isAscending) {
        isAscending = false;
      } else {
        roads = roads.reversed.toList();
        isAscending = true;
      }
    });
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
