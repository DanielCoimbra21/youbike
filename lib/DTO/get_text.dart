import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {

  final String uid;
  DatabaseManager({required this.uid});

  final CollectionReference getText = FirebaseFirestore.instance.collection('HelloWorld');

  //Future 

  // fetchText() async {
  //   var text = await FirebaseFirestore.instance.collection('HelloWorld');
  //   mapText(text);
  // }

  // mapText(CollectionReference<Map<String, dynamic>> text){
  //   debugPrint("je ssuiss là ${text.doc()}"); 
  // }

}