import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/auth_controller.dart';
import 'package:youbike/register_page.dart';

import 'DTO/route_shape.dart';

class MyAdminRoads extends StatelessWidget {
  final Road road;
  DatabaseManager db = DatabaseManager();
  MyAdminRoads(this.road, {super.key});

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
    return Container(
        padding: const EdgeInsets.all(10),
        child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Text(road.name,
                      style: Theme.of(context).textTheme.headline6),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Distance: ${road.distance} metres | Duration: ${road.duration} minutes |",
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
                Text("Elevation: ${road.elvDeparture} metres - ",
                    style: const TextStyle(
                      fontSize: 12,
                    )),
                Text("${road.elvArrival} metres",
                    style: const TextStyle(
                      fontSize: 12,
                    )),
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
                                        var name = road.name;
                                        RouteShape routeShape = RouteShape(
                                            polyline: road.polyline,
                                            elvDeparture: road.elvDeparture,
                                            elvArrival: road.elvArrival,
                                            duration: road.duration,
                                            distance: road.distance,
                                            transportMode: road.transportMode);

                                        db.deleteMyRoad(road.id);
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Deleted route ${road.name}'),
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
            Row(
              children: [
                const Expanded(
                    child: Divider(
                  thickness: 1,
                ))
              ],
            )
          ]),
        )));
  }
}
