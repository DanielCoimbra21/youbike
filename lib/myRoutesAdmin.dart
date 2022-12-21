import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/DTO/route_shape.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/auth_controller.dart';

import 'DTO/user.dart';
import 'custom_drawer.dart';

DatabaseManager db = DatabaseManager();
List roads = [];

class MyRoutesAdmin extends StatefulWidget {
  const MyRoutesAdmin({super.key});

  @override
  State<MyRoutesAdmin> createState() => _RoutesListState();
}

class _RoutesListState extends State<MyRoutesAdmin> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

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
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
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
                                        style: const TextStyle(
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
                                        style: const TextStyle(
                                          fontSize: 12,
                                        )),
                                    Text(
                                        "${snap[index]['Elevation Arrival']} metres",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Expanded(
                                        child: Divider(
                                      thickness: 1,
                                    ))
                                  ],
                                ),
                                Visibility(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 40),
                                    child: TextButton(
                                      style: flatButtonStyle,
                                      onPressed: () {
                                        var name = snap[index]['Name'];
                                        RouteShape routeShape = RouteShape(
                                            polyline: snap[index]['Polyline'],
                                            elvDeparture: snap[index]
                                                ['Elevation Departure'],
                                            elvArrival: snap[index]
                                                ['Elevation Arrival'],
                                            duration: snap[index]['Duration'],
                                            distance: snap[index]['Distance'],
                                            transportMode: snap[index]
                                                ['Transport Mode']);

                                        db.deleteMyRoad(snap[index].id);
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Deleted route ${snap[index]['Name']}'),
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {
                                              db.addRoad(
                                                  rs: routeShape,
                                                  name: name,
                                                  id: AuthController.instance
                                                      .auth.currentUser?.uid);
                                            },
                                          ),
                                        );

                                        // Find the ScaffoldMessenger in the widget tree
                                        // and use it to show a SnackBar.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
        ));


    // Visibility(
    //                               child: Container(
    //                                 alignment: Alignment.topRight,
    //                                 margin: const EdgeInsets.only(
    //                                     left: 20, right: 40),
    //                                 child: TextButton(
    //                                   style: flatButtonStyle,
    //                                   onPressed: () {
    //                                     var name = snap[index]['Name'];
    //                                     RouteShape routeShape = RouteShape(
    //                                         polyline: snap[index]['Polyline'],
    //                                         elvDeparture: snap[index]
    //                                             ['Elevation Departure'],
    //                                         elvArrival: snap[index]
    //                                             ['Elevation Arrival'],
    //                                         duration: snap[index]['Duration'],
    //                                         distance: snap[index]['Distance'],
    //                                         transportMode: snap[index]
    //                                             ['Transport Mode']);

    //                                     db.deleteMyRoad(snap[index].id);
    //                                     final snackBar = SnackBar(
    //                                       content: Text(
    //                                           'Deleted route ${snap[index]['Name']}'),
    //                                       action: SnackBarAction(
    //                                         label: 'Undo',
    //                                         onPressed: () {
    //                                           db.addRoad(
    //                                               rs: routeShape,
    //                                               name: name,
    //                                               id: AuthController.instance
    //                                                   .auth.currentUser?.uid);
    //                                         },
    //                                       ),
    //                                     );

    //                                     // Find the ScaffoldMessenger in the widget tree
    //                                     // and use it to show a SnackBar.
    //                                     ScaffoldMessenger.of(context)
    //                                         .showSnackBar(snackBar);
    //                                   },
    //                                   child: const Icon(Icons.delete),
    //                                 ),
    //                               ),
    //                             ),
  }

  getRoads() async {
    roads = await db.getRoads();
    setState(() {});
  }
}
