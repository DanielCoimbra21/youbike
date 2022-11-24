import 'package:youbike/learn_flutter_page.dart';
import 'package:flutter/material.dart';

import 'custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: CustomDrawer(),
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
          child: const Text('Learn FLutter'),
        ),
      ),
    );
  }
}
