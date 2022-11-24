import 'package:flutter/material.dart';

const itemCount = 20;
bool isSelected = false;
Color iconColor = Colors.grey;



class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

    @override
  State<StatefulWidget> createState() => _RoutesPageState();
}


class _RoutesPageState extends State<RoutesPage>{

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('item of the list ${(index + 1)}'),
          leading: const Icon(Icons.person),
          trailing: IconButton(
                    onPressed: () {
                      // setState(() {
                      //   // if(){

                      //   // }
                      // });
                    },
                    color: iconColor,
                    iconSize: 10,
                    icon: const Icon(
                      Icons.favorite
                    ),
                  ),
          onTap: () {
            debugPrint('Item ${(index + 1)} selected');
          },
        );
      },
    );
  }
  

}


//tab favoris
//