import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/Database/firestore_reference.dart';
import 'package:youbike/auth_controller.dart';
import 'DTO/route_shape.dart';
import 'edit_road_name.dart';

///Configuration of a button
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

///This class has only the purpose
///of displaying a good UI
///in cards
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
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
              colors: [
                Color(0xffD60C2E),
                Color(0xffAD0B26),
                Color(0xffFE8437),
                Color(0xffF45E01),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        fontSize: 14,
                      )),
                ],
              ),
              Row(
                children: [
                  Text("Elevation: ${road.elvDeparture} metres - ",
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                  Text("${road.elvArrival} metres",
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              
              Row(
                children: [
                  ///This button is used to delete one road
                  Visibility(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 30, right: 30),
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
                        content: Text('Deleted route ${road.name}'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            db.addRoad(
                                rs: routeShape,
                                name: name,
                                id: AuthController
                                    .instance.auth.currentUser?.uid);
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
              ),
              Visibility(
                ///this button is used to Edit one road Name
                child: Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 0, right: 20),
                  child: IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () => Get.to(
                            () => EditRoadNamePage(initialName: road.name, id : road.id)),
                        icon: const Icon(Icons.edit)),
                ),
              ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
