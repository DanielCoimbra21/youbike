import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/route_shape.dart';
import 'package:youbike/auth_controller.dart';
import '../DTO/road.dart';
import '../DTO/user.dart';

//Reference to the collections User and Road
//to read and write data
class DatabaseManager {
  final roadRef =
      FirebaseFirestore.instance.collection('Road').withConverter<Road>(
            fromFirestore: (snapshot, _) => Road.fromJson(snapshot.data()!),
            toFirestore: (road, _) => road.toJson(),
          );

  final userRef =
      FirebaseFirestore.instance.collection('User').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  //List all Roads
  //the favorite ones will have a filled heart in red
  Future<List<Road?>> getRoads() async {
    final docUser = FirebaseFirestore.instance
        .collection('User')
        .doc(AuthController.instance.auth.currentUser?.uid);
    final allRoads = await roadRef.get();

    DocumentSnapshot docU = await docUser.get();

    List favRoadsName = docU.get('favoriteRoads');
    List<Road> roads = [];

  for(var road in allRoads.docs){
    Road road5 = road.data();
    road5.id = road.id;
    if(favRoadsName.contains(road.id))
    {
      road5.isFavorite = true;
    }
    roads.add(road5);
  }
    return roads;
  }

  //Get User Role
  Future<String> getUserRole() async{
        final docUser = FirebaseFirestore.instance
        .collection('User')
        .doc(AuthController.instance.auth.currentUser?.uid);

        DocumentSnapshot docU = await docUser.get();
        return docU.get('role');

  }

  //List my Admin Roads
  Future<List<Road?>> getMyRoads() async {
    final docUser = FirebaseFirestore.instance
        .collection('User')
        .doc(AuthController.instance.auth.currentUser?.uid);
    final allRoads = await roadRef.get();

    DocumentSnapshot docU = await docUser.get();

    List myRoads = docU.get('myRoads');
    List<Road> roads = [];

    for (var idRoute in myRoads) {
      for (var road in allRoads.docs) {
        if (road.id == idRoute) {
          Road road5 = road.data();
          road5.id = road.id;
          roads.add(road5);
        }
      }
    }

    return roads;
  }

  //List the favourite Roads
  Future<List<Road?>> getFavRoads() async {
    final docUser = FirebaseFirestore.instance
        .collection('User')
        .doc(AuthController.instance.auth.currentUser?.uid);
    final allRoads = await roadRef.get();

    DocumentSnapshot docU = await docUser.get();

    List favRoadsName = docU.get('favoriteRoads');
    List<Road> roads = [];
    for (var idRoute in favRoadsName) {
      for (var road in allRoads.docs) {
        if (road.id == idRoute) {
          Road road5 = road.data();
          road5.id = road.id;
          road5.isFavorite = true;
          roads.add(road5);
        }
      }
      //addRoad in anotherlist of roads
    }

    return roads;
  }

  //Add User to the App
  Future<void> addUser({required String email, required String? id}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);

    final user = {
      'email': email,
      'favoriteRoads': [],
      'firstName': '',
      'myRoads': [],
      'name': '',
      'position': 'position',
      'role': 'user',
    };

    await docUser.set(user);
  }

  //Update Road Name
  Future<void> updateRoadName(String? id, String name) async {
     FirebaseFirestore.instance.collection("Road").doc(id).update({"Name":name});
  }

  //Add Road to the DataBase
  Future<void> addRoad(
      {required RouteShape rs,
      required String name,
      required String? id}) async {
    final docRoad = FirebaseFirestore.instance.collection('Road').doc();

    final road = {
      'Name': name,
      'Duration': rs.duration,
      'Elevation Arrival': rs.elvArrival,
      'Elevation Departure': rs.elvDeparture,
      'Polyline': rs.polyline,
      'Transport Mode': rs.transportMode,
      'Distance': rs.distance
    };

    await docRoad.set(road);
    updateMyRoadsByUser(id: id, roadId: docRoad.id);
  }

  //Add the road to the Admin user road list
  Future<void> updateMyRoadsByUser(
      {required String? id, required String? roadId}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);

    var collection = FirebaseFirestore.instance.collection('User');
    collection.doc(id).update({
      'myRoads': FieldValue.arrayUnion([roadId]),
    });
  }

  //Delete the road
  Future<void> deleteMyRoad(String? roadId) async {
    FirebaseFirestore.instance.collection("Road").doc(roadId).delete().then(
          (doc) => log("Document deleted"),
          onError: (e) => log("Error updating document $e"),
        );

    removeFromMyRoadsRoads(
        id: AuthController.instance.auth.currentUser?.uid, roadId: roadId);
  }

  //Add to favourtie Road list when its liked
  Future<void> addToFavoriteRoads(
      {required String? id, required String? roadId}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    final allRoads = await roadRef.get();

    for (var road in allRoads.docs) {
      if (road.id == roadId) {
        DocumentSnapshot doc = await docUser.get();

        docUser.update(
          {
            'favoriteRoads': FieldValue.arrayUnion([road.id]),
          },
        );
      }
    }
  }

  //Remove from the FAvorite Road list when unliked
  Future<void> removeFromFavoriteRoads(
      {required String? id, required String? roadId}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    final allRoads = await roadRef.get();

    for (var road in allRoads.docs) {
      if (road.id == roadId) {
        DocumentSnapshot doc = await docUser.get();

        List roads = doc.get('favoriteRoads');

        docUser.update(
          {
            'favoriteRoads': FieldValue.arrayRemove([road.id]),
          },
        );
      }
    }
  }

 //Remove the road from the list my roads in the database
  Future<void> removeFromMyRoadsRoads(
      {required String? id, required String? roadId}) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);

    DocumentSnapshot doc = await docUser.get();

    var roads = doc.get('myRoads');

    if (roads.contains(roadId)) {
      docUser.update({
        'myRoads': FieldValue.arrayRemove([roadId]),
      });
    }

  }
}
