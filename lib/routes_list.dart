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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Roads'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Road').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              )
                            ]),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(snap[index]['Name']),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.centerRight,
                              child: Text("${snap[index]['Distance']} metres"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  getRoads() async {
    roads = await db.getRoads();
    setState(() {});
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
