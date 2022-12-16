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
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(road.name),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(road.name),
                  const Spacer(),
                  Text(road.distance.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
