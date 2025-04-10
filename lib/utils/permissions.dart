import 'package:geolocator/geolocator.dart';

class Permissions {
  static Future<LocationPermission> checkAndRequestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }
}