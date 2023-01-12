import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Database/firestore_reference.dart';
import 'myRoutesAdmin.dart';


 DatabaseManager db = DatabaseManager();


///Thanks to this class we can edit a road name
class EditRoadNamePage extends StatefulWidget {
  final String initialName;
  final String? id;
 

 const EditRoadNamePage({super.key, required this.initialName, required this.id});

  @override
  _EditRoadNamePageState createState() => _EditRoadNamePageState();
}

class _EditRoadNamePageState extends State<EditRoadNamePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.initialName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Road Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Road Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the name of the client';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        updateRoadName(widget.id, nameController.text);
                        Get.to(
                            () => const MyRoutesAdmin());
                      // Send the data to the backend for updating the client's information
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}

///Method to call the DataBase query
updateRoadName(String? id, String name) async{
  db.updateRoadName(id, name);
}
