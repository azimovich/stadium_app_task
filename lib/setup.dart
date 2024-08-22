import 'package:geolocator/geolocator.dart';

bool isLocationServiceEnabled = false;

Future<void> setup() async {
  isLocationServiceEnabled = await checkLocationServiceEnabled();
}

Future<bool> checkLocationServiceEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}
