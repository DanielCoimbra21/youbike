import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'custom_drawer.dart';

//LINK API MAP : 'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
//flUTTER MAP :

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      drawer: CustomDrawer(),
      body: Center(
        child: Container(
          child: Column(children: [
            Flexible(
                child: FlutterMap(
              options: MapOptions(
                center: LatLng(46.283099, 7.539069),
                zoom: 15,
              ),
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],
              mapController: MapController(),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg',
                ),
                Container(
                  child: FloatingActionButton(
                    onPressed: () {
                      if (url ==
                          'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg') {
                        setState(() {
                          url =
                              'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg';
                        });
                      } else {
                        setState(() {
                          url =
                              'https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg';
                        });
                      }
                    },
                    child: const Icon(Icons.map),
                  ),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(20),
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
