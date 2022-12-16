import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/auth_controller.dart';
import 'package:youbike/register_page.dart';

class RouteCard extends StatelessWidget {
  final Road road;
  RouteCard(this.road);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(road.name,
                    style: Theme.of(context).textTheme.headline6),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Distance: ${road.distance} metres | Duration: ${road.duration} minutes |",
                  style: TextStyle(
                    fontSize: 12,
                  )),

              // Text.rich(
              //   WidgetSpan(
              //       child: Icon(
              //     Icons.favorite_border_outlined,
              //     color: Colors.pink,
              //   )),
              // ),
            ],
          ),
          Row(
            children: [
              Text("Elevation: ${road.elvDeparture} metres - ",
                  style: TextStyle(
                    fontSize: 12,
                  )),
              Text("${road.elvArrival} metres",
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
          Row(
            children: [
              FavoriteButton(
                  isFavorite: false,
                  valueChanged: (_isFavorite) {
                    print('Is Favorite : $_isFavorite');
                  }),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 1,
              ))
            ],
          )
        ]),
      )),
    );
  }
}
