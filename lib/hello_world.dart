import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_drawer.dart';

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

// void initState() {
//   super.initState();
//   text = reference.snapshots();
// }

class _HelloWorldState extends State<HelloWorld> {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('HelloWorld');
  late Stream<QuerySnapshot> text;

  @override
  void initState() {
    super.initState();

    text = reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    reference.get(); //future : cannot listen
    reference.snapshots(); //sstream : can listen, gets real time updates

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const CustomDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: text,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List docs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map b = document.data() as Map<String, dynamic>;
            docs.add(b);
            b['id'] = document.id;
          }).toList();

          return Column(
            children: List.generate(
                docs.length,
                (i) => Column(
                      children: [
                        Text(
                          docs[i]['AppName'],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          docs[i]['Creator1'],
                        ),
                      ],
                    )),
          );
        },
      ),
    );
  }
}
