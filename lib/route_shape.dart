
class RouteShape{
  /// RouteShape class represents an object we use to store in the DB firebase
  final String polyline;
  final double elvDeparture;
  final double elvArrival;
  final int duration;
  final int distance;
  final String transportMode;

  const RouteShape({
    required this.polyline,
    required this.elvDeparture,
    required this.elvArrival,
    required this.duration,
    required this.distance,
    required this.transportMode,
  });

  /// Method to transform the response JSON to an object called RouteShape
  factory RouteShape.fromJson(Map<String, dynamic> json){
    return RouteShape(
      polyline: json['routes'][0]['sections'][0]['polyline'] as String,
      elvDeparture: json['routes'][0]['sections'][0]['departure']['place']['location']['elv'] as double,
      elvArrival: json['routes'][0]['sections'][0]['arrival']['place']['location']['elv'] as double,
      duration: json['routes'][0]['sections'][0]['summary']['duration'] as int,
      distance: json['routes'][0]['sections'][0]['summary']['length'] as int ,
      transportMode: json['routes'][0]['sections'][0]['transport']['mode'] as String,
    );
  }
} 