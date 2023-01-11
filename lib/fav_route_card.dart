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

import 'mapRouteDisplay.dart';

class RouteCard extends StatelessWidget {
  final Road road;
  const RouteCard(this.road, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
              colors: [
                Color(0xffFFFFFF),
                Color(0xffF45E01),
                Color(0xffD60C2E),
                Color(0xffAD0B26),
                
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Center(
                        child: Text(road.name,
                            style: Theme.of(context).textTheme.headline6),
                      ),
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
                Row(
                  children: [
                    FavoriteButton(
                      isFavorite: road.isFavorite,
                      valueChanged: (isFavorite) {
                        if (road.isFavorite) {
                          road.isFavorite = false;
                          deleteFromFav(
                              AuthController.instance.auth.currentUser?.uid,
                              road.id);
                        } else {
                          road.isFavorite = true;
                          addToFavorite(
                              AuthController.instance.auth.currentUser?.uid,
                              road.id);
                        }
                      },
                    ),
                    IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () => Get.to(
                            () => DisplayRouteMap(polyline: road.polyline)),
                        icon: const Icon(Icons.pedal_bike)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

deleteFromFav(String? id, String? roadId) async {
  DatabaseManager db = DatabaseManager();
  await db.removeFromFavoriteRoads(id: id, roadId: roadId);
}

addToFavorite(String? id, String? roadId) async {
  DatabaseManager db = DatabaseManager();
  await db.addToFavoriteRoads(id: id, roadId: roadId);
}
