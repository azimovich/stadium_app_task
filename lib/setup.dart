import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

bool isConneted = true;

Future<void> setup() async {
  isConneted = await checkInternetConnection();
}

/// Chech Location Service Is Enable
Future<bool> checkLocationServiceEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

/// Check Internet Connection
Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true; // Internet mavjud
  } else {
    return false; // Internet yo'q
  }
}
