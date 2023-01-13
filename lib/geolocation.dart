// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:youbike/map_page.dart';
import 'package:youbike/polyline/latlngz.dart';

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<StatefulWidget> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  Position? _currentPosition;

  // The function checks if the user has granted location permissions or not.
  // If the user has granted location permissions, it returns true.
  // Otherwise, it returns false.
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  // This function is called at build.
  // It gets the current position of the user if the app has permission.
  // Otherwise, it sets the current position to a default value.
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      _currentPosition = Position(
          latitude: 46.29780644959061,
          longitude: 7.505141064790101,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => _currentPosition =
            position); // ignore: avoid_print, avoid_types_on_closure_parameters
      }).catchError((e) {
        debugPrint(e);
      });
    }
    position = LatLngZ(_currentPosition!.latitude, _currentPosition!.longitude);
  }

  var position;

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      loaded = true;
      _getCurrentPosition()
          .then((value) => Get.to(() => MapPage(currentPosition: position)));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation'),
      ),
      body: const Center(
        child: Text('Getting current location'),
      ),
    );
  }
}
