import 'dart:developer';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:youbike/DTO/road.dart';
import 'package:youbike/polyline/flexible_polyline.dart';
import 'package:youbike/polyline/latlngz.dart';
import 'custom_drawer.dart';
// ignore: depend_on_referenced_packages

class DisplayRouteMap extends StatefulWidget {
  final Road road;
  const DisplayRouteMap({super.key, required this.road});

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
  List<LatLngZ> latlenz = <LatLngZ>[];
  List<Elevation> elevation = <Elevation>[];
  late TooltipBehavior _tooltipBehavior;

  route() {
    latlen = [];
    latlenz = FlexiblePolyline.decode(widget.road.polyline);
    var count = 0;
    for (var l in latlenz) {
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
      if (count == latlenz.length - 1) {
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
      elevation.add(Elevation(count, l.z));
      count++;
    }
  }

  int i = 0;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true, format: "point.y m");
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
              slidingUpPanel(),
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

  Widget slidingUpPanel() {
    return Container(
      child: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        panel: Container(
            margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Route Details",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                    "Distance: ${(widget.road.distance / 1000).toStringAsFixed(2)} km | Duration: ${(widget.road.duration / 60).toStringAsFixed(1)} minutes |",
                    style: const TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 400,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Elevation'),
                    tooltipBehavior: _tooltipBehavior,
                    primaryYAxis: NumericAxis(
                      interval: 100,
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryXAxis: NumericAxis(
                      isVisible: false,
                    ),
                    series: <ChartSeries>[
                      LineSeries<Elevation, int>(
                        name: "Elevation",
                        dataSource: elevation,
                        xValueMapper: (Elevation elevation, _) => elevation.x,
                        yValueMapper: (Elevation elevation, _) => elevation.y,
                        enableTooltip: true,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class Elevation {
  Elevation(this.x, this.y);
  final int x;
  final double y;
}
