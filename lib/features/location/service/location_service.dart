import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/location_repository_provider.dart';

class LocationService {

  final Ref ref;

  LocationService(this.ref);

  StreamSubscription? subscription;

  Future<void> start() async {

    print("Location Service Started");

    subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) async {

      print("Latitude : ${position.latitude}");
      print("Longitude: ${position.longitude}");

      await ref
          .read(locationRepositoryProvider)
          .uploadLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      print("Location Uploaded");

    });

  }

  void stop() {

    subscription?.cancel();

  }

}