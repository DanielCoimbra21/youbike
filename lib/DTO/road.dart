import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Road {
  double distance;
  double duration;
  int elevation;
  String endPoint;
  String startingPoint;

  Road(
      {required this.distance,
      required this.duration,
      required this.elevation,
      required this.endPoint,
      required this.startingPoint});

  //factory Road.fromJson(Map<String, dynamic> json) => _roadFromJson(json);

  factory Road.fromJson(Map<String, dynamic> json) => Road(
    distance: json['Distance'],
      duration: json['Duration'],
      elevation: json['Elevation'],
      endPoint: json['EndPoint'],
      startingPoint: json['StartingPoint']);

  Map<String, dynamic> toJson() => _roadToJson(this);

}

Road _roadFromJson(Map<String, dynamic> json) {
  return Road(
      distance: json['distance'],
      duration: json['duration'],
      elevation: json['elevation'],
      endPoint: json['endPoint'],
      startingPoint: json['startingPoint']);
}

Map<String, dynamic> _roadToJson(Road instance) => <String, dynamic>{
      'Distance': instance.distance,
      'Duration': instance.duration,
      'Elevation': instance.elevation,
      'EndPoint': instance.endPoint,
      'StartingPoint': instance.startingPoint
    };

Road roadFromJson(String str) => Road.fromJson(json.decode(str));
String raodToJson(Road data) => json.encode(data.toJson());
