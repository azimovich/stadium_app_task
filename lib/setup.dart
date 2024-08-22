import 'package:geolocator/geolocator.dart';

bool isLocationServiceEnabled = false;

Future<void> setup() async {
  isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
}
