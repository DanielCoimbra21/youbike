import 'package:flutter/material.dart';

class RouteShape{
  final String polyline;

  const RouteShape({
    required this.polyline,
  });

  factory RouteShape.fromJson(Map<String, dynamic> json){
    return RouteShape(
      polyline: json['routes'][0]['sections'][0]['polyline'] as String,
    );
  }
} 