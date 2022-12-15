import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youbike/DTO/route_shape.dart';

import '../DTO/road.dart';
import '../DTO/user.dart';

class DatabaseManager {

  final roadRef = FirebaseFirestore.instance.collection('Road').withConverter<Road>(
      fromFirestore: (snapshot, _) => Road.fromJson(snapshot.data()!),
      toFirestore: (road, _) => road.toJson(),
    );

  final userRef = FirebaseFirestore.instance.collection('User').withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
    );

  // final userRef = FirebaseFirestore.instance.collection('User').withConverter<User>(
  //     fromFirestore: (snapshot, _) => Road.fromJson(snapshot.data()!),
  //     toFirestore: (road, _) => road.toJson(),
  //   );

  //List Roads
  Future<List<Road?>> getRoads() async {
     final snaphot = await roadRef.get();
     List<Road> roads = [];
     for(var doc in snaphot.docs) {
      roads.add(doc.data());
     }
     return roads;
  }

  //Add User
  //Future<void> addUser({required String email, required String? id}) async {
   Future<void> addUser({required String email, required String? id}) async { 
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    
    final user = {
    'email': email, 
    'favoriteRoads': [], 
    'firstName': '', 
    'myRoads': [], 
    'name': '', 
    'position': 'position', 
    'role': 'user'};

    await docUser.set(user);
  }


  //Add Road
  Future<void> addRoad({required RouteShape rs, required String name, required String? id}) async { 
    final docRoad = FirebaseFirestore.instance.collection('Road').doc();
    
    final road = {
    'Name': name, 
    'Duration': rs.duration, 
    'Elevation Arrival': rs.elvArrival, 
    'Elevation Departure': rs.elvDeparture, 
    'Polyline': rs.polyline, 
    'Transport Mode': rs.transportMode, 
    'Distance': rs.distance};

    await docRoad.set(road);
    //updateMyRoadsByUser(id: id);
  }

  Future<void> updateMyRoadsByUser({required String? id}) async{
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    
    docUser.get().then(
    (DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print(data);
  },
  onError: (e) => print("Error getting document: $e"),
);

    //docUser.update({'favoriteRoads':  })
  }

  // Stream<List<Road>> getRoads() => FirebaseFirestore.instance
  //   .collection('Road')
  //   .snapshots()
  //   .map((snapshot) => snapshot.docs.map((doc) => Road.fromJson(doc.data())).toList());
  

}