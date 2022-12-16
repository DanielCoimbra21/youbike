import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:favorite_button/favorite_button.dart';
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
        appBar: AppBar(title: const Text('All Routes')),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Road').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(
                  //     child: Text("Loading..."),
                  //   );
                  // }
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Text(snap[index]['Name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Distance: ${snap[index]['Distance']} metres | Duration: ${snap[index]['Duration']} minutes |",
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),

                                // Text.rich(
                                //   WidgetSpan(
                                //       child: Icon(
                                //     Icons.favorite_border_outlined,
                                //     color: Colors.pink,
                                //   )),
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Elevation: ${snap[index]['Elevation Departure']} metres - ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                                Text(
                                    "${snap[index]['Elevation Arrival']} metres",
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                FavoriteButton(
                                    isFavorite: false,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                    }),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                ))
                              ],
                            )
                          ]),
                        ));
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ));
  }

  getRoads() async {
    roads = await db.getRoads();
    setState(() {});
  }
}
