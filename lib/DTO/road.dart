import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  final String name;
  final String polyline;
  final int elvDeparture;
  final int elvArrival;
  final int duration;
  final int distance;
  final String transportMode;
  bool isFavorite;
  String? id;

    Road({
      required this.name,
  required this.polyline,
  required this.elvDeparture,
  required this.elvArrival,
  required this.duration,
  required this.distance,
  required this.transportMode,
  this.id,
  this.isFavorite = false});

  //factory Road.fromJson(Map<String, dynamic> json) => _roadFromJson(json);

  factory Road.fromJson(Map<String, dynamic> json) => Road(
    id: json['Id'],
    name: json['Name'],
    polyline: json['Polyline'],
    distance: json['Distance'],
    duration: json['Duration'],
    elvDeparture: json['Elevation Departure'] as int,
    elvArrival : json['Elevation Arrival'] as int,
    transportMode: json['Transport Mode']);
  

  Map<String, dynamic> toJson() => _roadToJson(this);

    void set setId(String newId){
     id = newId;
  }

  void set setFavorite(bool newFavorite){
     isFavorite = newFavorite;
  }

}


Map<String, dynamic> _roadToJson(Road instance) => <String, dynamic>{
      'Distance': instance.distance,
      'Duration': instance.duration,
      'Elevation Departure': instance.elvDeparture,
      'Elevation Arrival': instance.elvArrival,
      'Polyline': instance.polyline,
      'Transport Mode': instance.transportMode,
      'Name': instance.name
    };

Road roadFromJson(String str) => Road.fromJson(json.decode(str));
String raodToJson(Road data) => json.encode(data.toJson());


