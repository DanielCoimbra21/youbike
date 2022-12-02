import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  // Stream<List<Road>> getRoads() => FirebaseFirestore.instance
  //   .collection('Road')
  //   .snapshots()
  //   .map((snapshot) => snapshot.docs.map((doc) => Road.fromJson(doc.data())).toList());
  

}