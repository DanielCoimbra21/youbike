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

class RouteCard extends StatelessWidget {
  final Road road;
  const RouteCard(this.road, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
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
            Row(
              children: [
                FavoriteButton(
                    isFavorite: road.isFavorite,
                    valueChanged: (_isFavorite) {
                      if(_isFavorite){
                        deleteFromFav(AuthController.instance.auth.currentUser?.uid, road.name);
                      }
                      else{
                        addToFavorite(AuthController.instance.auth.currentUser?.uid, road.name);
                      }
                      // deleteFromFav(
                      //     AuthController.instance.auth.currentUser?.uid,
                      //     road.id);
                    },
                  ),
              ],
            ),
            Row(
                children: const [
                  Expanded(
                    child: Divider(
                  thickness: 1,
                    ),
                  )
              ],
            )
            ],
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

addToFavorite(String? id, String roadId) async {
  DatabaseManager db = DatabaseManager();
  await db.addToFavoriteRoads(id: id, roadId: roadId);
}
