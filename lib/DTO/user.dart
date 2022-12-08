import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youbike/DTO/road.dart';

class User {
  User(
      {required this.email,
      required this.favoriteRoads,
      required this.firstName,
      required this.myRoads,
      required this.name,
      required this.position,
      required this.role});

  final String email;
  final List<Road> favoriteRoads;
  final String firstName;
  final String name;
  final int role;
  final List<Road> myRoads;
  final String position;



  factory User.fromJson(Map<String, dynamic> json) => User(email : json['email'] as String,
      favoriteRoads :json['favoriteRoads'] as List<Road>,
      firstName : json['firstName'] as String,
      myRoads: json['myRoads'] as List<Road>,
      name: json['name'] as String,
      position: json['position'] as String,
      role: json['role'] as int);

  Map<String, dynamic> toJson() => _userToJson(this);

}

User _userFromJson(Map<String, dynamic> json) {
  return User(
      email : json['email'] as String,
      favoriteRoads :json['favoriteRoads'] as List<Road>,
      firstName : json['firstName'] as String,
      myRoads: json['myRoads'] as List<Road>,
      name: json['name'] as String,
      position: json['position'] as String,
      role: json['role'] as int);
}


Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'favoriteRoads': _favoriteRoads(instance.favoriteRoads),
      'firstName': instance.firstName,
      'myRoads': _myRoadsList(instance.myRoads),
      'name': instance.name,
      'position': instance.position,
      'role': instance.role
    };

List<Map<String, dynamic>>? _favoriteRoads(List<Road>? roads) {
  if (roads == null) {
    return null;
  }
  final roadMap = <Map<String, dynamic>>[];
  roads.forEach((road) {
    roadMap.add(road.toJson());
  });
  return roadMap;
}

List<Map<String, dynamic>>? _myRoadsList(List<Road>? roads) {
  if (roads == null) {
    return null;
  }
  final roadMap = <Map<String, dynamic>>[];
  roads.forEach((road) {
    roadMap.add(road.toJson());
  });
  return roadMap;
}
