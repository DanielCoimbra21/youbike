import 'dart:developer';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:youbike/polyline/flexible_polyline.dart';
import 'custom_drawer.dart';
// ignore: depend_on_referenced_packages

class DisplayRouteMap extends StatefulWidget {
  final String polyline;
  const DisplayRouteMap({super.key, required this.polyline});

  @override
  State<StatefulWidget> createState() => _DisplayRouteMapState();
}

class _DisplayRouteMapState extends State<DisplayRouteMap> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  var url =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
  var satLayer =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg';
  var mapLayer =
      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';

  // ignore: prefer_typing_uninitialized_variables
  List<Marker> markers = <Marker>[];
  var maxMarker = 10;
  var currentNumbMarker = 0;
  var latStart = 0.0;
  var longStart = 0.0;
  var latEnd = 0.0;
  var longEnd = 0.0;

  List<LatLng> latlen = <LatLng>[];

  route() {
    latlen = [];
    var list = FlexiblePolyline.decode(widget.polyline);
    var count = 0;
    for (var l in list) {
      log(count.toString() + l.toString());
      if (count == 0) {
        markers.add(Marker(
          anchorPos: AnchorPos.exactly(Anchor(10, -7)),
          point: LatLng(l.lat, l.lng),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ));
      }
      if (count == list.length - 1) {
        markers.add(Marker(
          anchorPos: AnchorPos.exactly(Anchor(10, -7)),
          point: LatLng(l.lat, l.lng),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ));
      }
      latlen.add(LatLng(l.lat, l.lng));
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    route();
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(children: [
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: markers.first.point,
              zoom: 14,
            ),
            nonRotatedChildren: [
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
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
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
