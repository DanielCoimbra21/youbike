import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:youbike/auth/secrets.dart';
import 'package:youbike/polyline/flexible_polyline.dart';
import 'package:youbike/route_shape.dart';
import 'custom_drawer.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var poly = '';
  var url =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
  var satLayer =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg';
  var mapLayer =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';

  var start;
  var end;
  // ignore: prefer_typing_uninitialized_variables
  List<Marker> markers = <Marker>[];
  var maxMarker = 10;
  var currentNumbMarker = 0;
  bool isCancelBtnVisible = false;
  bool isUndoBtnVisible = false;
  bool isValidateBtnVisible = false;
  var latStart = 0.0;
  var longStart = 0.0;
  var latEnd = 0.0;
  var longEnd = 0.0;
  late Future<RouteShape> futureRouteShape;
  bool isLoaded = false;
  late List<LatLng> latlen = <LatLng>[];

  Future<RouteShape> fetchRouteShape() async {
    final response;
    var uri = "";

    if (currentNumbMarker == 2) {
      uri =
          "https://router.hereapi.com/v8/routes?transportMode=bicycle&origin=${markers.first.point.latitude},${markers.first.point.longitude}&destination=${markers.last.point.latitude},${markers.last.point.longitude}&return=polyline,elevation,summary&apikey=$apiHERE";
    } else {
      var via = "";
      for (int i = 1; i <= markers.length - 2; i++) {
        via +=
            "&via=${markers[i].point.latitude},${markers[i].point.longitude}!passThrough=true";
      }
      uri =
          "https://router.hereapi.com/v8/routes?transportMode=bicycle&return=polyline,summary,elevation,passthrough&origin=${markers.first.point.latitude},${markers.first.point.longitude}&destination=${markers.last.point.latitude},${markers.last.point.longitude}&$via&apikey=$apiHERE";
    }
    log(uri);

    response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return RouteShape.fromJson(jsonDecode(response.body));
    } else {
      log(response.statusCode.toString());
      throw Exception('Failed to load routeShape');
    }
  }

  route() {
    if (isLoaded != false) {
      latlen = [];
      var list = FlexiblePolyline.decode(poly);
      var count = 0;
      for (var l in list) {
        log(count.toString() + l.toString());
        if (count == 0) {
          start = LatLng(l.lat, l.lng);
        }
        if (count == list.length - 1) {
          log(count.toString());
          end = LatLng(l.lat, l.lng);
        }
        latlen.add(LatLng(l.lat, l.lng));
        count++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(children: [
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: LatLng(46.283099, 7.539069),
              zoom: 15,
              onTap: (tapPosition, LatLng latLng) {
                if (currentNumbMarker < maxMarker) {
                  markers.add(
                    Marker(
                      point: latLng,
                      builder: (ctx) => const Icon(
                        Icons.flag,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                  setState(() {
                    currentNumbMarker += 1;
                    isCancelBtnVisible = true;
                    isUndoBtnVisible = true;
                  });

                  if (currentNumbMarker >= 2) {
                    isValidateBtnVisible = true;
                  }
                }
              },
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.all(20),
                child: FloatingActionButton(
                  onPressed: () {
                    if (url == mapLayer) {
                      setState(() {
                        url = satLayer;
                      });
                    } else {
                      setState(() {
                        url = mapLayer;
                      });
                    }
                  },
                  child: const Icon(Icons.map),
                ),
              ),
              Visibility(
                visible: isCancelBtnVisible,
                child: Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 100, right: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      markers.clear();
                      if (latlen.isNotEmpty) {
                        latlen.clear();
                      }
                      setState(() {
                        currentNumbMarker = 0;
                        isCancelBtnVisible = false;
                        isUndoBtnVisible = false;
                        isValidateBtnVisible = false;
                      });
                    },
                    child: const Icon(Icons.cancel),
                  ),
                ),
              ),
              Visibility(
                visible: isUndoBtnVisible,
                child: Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 180, right: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (currentNumbMarker > 0) {
                        markers.removeLast();
                        if (latlen.isNotEmpty) {
                          latlen.clear();
                        }
                        setState(() {
                          currentNumbMarker -= 1;
                          if (currentNumbMarker == 0) {
                            isUndoBtnVisible = false;
                            isCancelBtnVisible = false;
                          }
                        });
                      }
                      if (currentNumbMarker == 1) {
                        isValidateBtnVisible = false;
                      }
                    },
                    child: const Icon(Icons.undo),
                  ),
                ),
              ),
              Visibility(
                visible: isValidateBtnVisible,
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      futureRouteShape = fetchRouteShape();
                      futureRouteShape.then(
                        (value) {
                          setState(() {
                            poly = value.polyline;
                            isLoaded = true;
                            route();
                          });
                        },
                      );
                    },
                    child: const Icon(Icons.check),
                  ),
                ),
              )
            ],
            mapController: MapController(),
            children: [
              TileLayer(
                urlTemplate: url,
              ),
              TileLayer(
                urlTemplate:
                    'https://wmts20.geo.admin.ch/1.0.0/ch.astra.veloland/default/current/3857/{z}/{x}/{y}.png',
                backgroundColor: Colors.transparent,
                opacity: 0.5,
              ),
              TileLayer(
                urlTemplate:
                    'https://wmts20.geo.admin.ch/1.0.0/ch.astra.mountainbikeland/default/current/3857/{z}/{x}/{y}.png',
                backgroundColor: Colors.transparent,
                opacity: 0.5,
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      if (currentNumbMarker >= 2 && isLoaded != false)
                        for (var l in latlen) l,
                    ],
                    strokeWidth: 5,
                    color: Colors.red,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  for (var m in markers) m,
                ],
              )
            ],
          )),
        ]),
      ),
    );
  }
}
