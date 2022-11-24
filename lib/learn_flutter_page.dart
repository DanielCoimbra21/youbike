import 'package:flutter/material.dart';

class LearFlutterPage extends StatefulWidget {
  const LearFlutterPage({super.key});

  @override
  State<LearFlutterPage> createState() => _LearFlutterPageState();
}

class _LearFlutterPageState extends State<LearFlutterPage> {
  bool isSwitch = false;
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            debugPrint('Actions');
          }, icon: const Icon(Icons.access_alarm))
        ],
        title: const Text('Learn Flutter'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      //Column to have multiple widgets inside
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Divider(color: Colors.black),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              color: Colors.blueGrey,
              width: double.infinity, //Take all the place possible
              child: const Center(
                child: Text(
                  'This is a text widget',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: isSwitch ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                debugPrint('Elevated Button');
              },
              child: const Text('Elevated Button'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: isChecked! ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                debugPrint('Outline Button');
              },
              child: const Text('Outline Button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('text Button');
              },
              child: const Text('text Button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('This is the rown');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                  Text('row Widget'),
                  Icon(
                    Icons.local_fire_department,
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool newBool) {
                setState(() {
                  isSwitch = newBool;
                });
              },
            ),
            Checkbox(
              value: isChecked,
              onChanged: (bool? checked) { //boolean that can be nullable
                setState(() {
                  isChecked = checked;
                });
              },
            ),
            //Image.asset('images/Logo-Hes-so.png')
          ],
        ),
      ),
    );
  }
}
