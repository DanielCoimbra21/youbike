import 'package:flutter/material.dart';

import 'custom_drawer.dart';

/// Displays the information about the App
/// and about the developpers as well as about he version: 1.0.0
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      drawer : const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: const <Widget>[
            SizedBox(height: 20),
            Text("This is a Flutter App created for a course at the HES-So.", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Developed by: Doriane Papilloud, Thomas Cheseaux, Fabio Almeida and Daniel Coimbra", style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Text("version: 1.0.0", style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}