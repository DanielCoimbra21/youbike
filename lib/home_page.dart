import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/learn_flutter_page.dart';
import 'package:flutter/material.dart';

import 'DTO/get_text.dart';
import 'custom_drawer.dart';

DatabaseManager d = DatabaseManager(uid: "HelloWorld");

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        drawer: const CustomDrawer(),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LearFlutterPage();
                  },
                ),
              );
            },
            child: const Text("Bonjour"),
          ),
        ),
        );
  }
}
