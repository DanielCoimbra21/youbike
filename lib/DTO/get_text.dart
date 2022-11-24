import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetText extends StatelessWidget {

  final String title;

  GetText(this.title);


  @override
  Widget build(BuildContext context) {

    CollectionReference title = FirebaseFirestore.instance.collection('HelloWorld');

    return Container();
  }
}