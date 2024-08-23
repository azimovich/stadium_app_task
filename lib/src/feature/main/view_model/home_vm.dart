import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';
import 'package:stadium_app_task/src/data/repository/app_repository_impl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final homeVM = ChangeNotifierProvider((ref) => HomeVm());

// Fechting data
final homeFetchData = FutureProvider((ref) async {
  ref.read(homeVM).getStadiumList();
});

class HomeVm with ChangeNotifier {
  // HomePageSearch Varibales
  bool isLoading = false;
  int currextTabIndex = 0;
  List<StadiumModel> stadiumList = [];
  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  // HomePageMap Varibles
  late Position myPosition;
  late Animation<double> animation;
  List<MapObject> mapObjectList = [];
  bool isFloatactionButtonVisibility = true;
  StadiumModel stadiumModel = StadiumModel();
  late YandexMapController yandexMapController;
  late AnimationController animationController;

  // Uzbekistan Latitude and longitude
  final double uzbLatitude = 41.311081;
  final double uzbLongitude = 69.240562;

  /// Methods

  void initial() {
    getStadiumList().then((_) {});
  }

  /// Get Satdium List Method
  Future<void> getStadiumList() async {
    stadiumList = await _appRepositoryImpl.getStadiumList() ?? [];
    for (var element in stadiumList) {
      putLabel(
        lan: element.longitude ?? 0,
        lon: element.latitude ?? 0,
        id: element.latitude.toString(),
        imgPath: "assets/img/point.png",
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// Method that works when the map is first created
  void onMapCreated(YandexMapController controller) {
    yandexMapController = controller;
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: uzbLatitude,
            longitude: uzbLongitude,
          ),
          zoom: 11,
        ),
      ),
    );
  }

  /// Method that determines user location
  Future<void> findMe() async {
    if (isLoading) {
      return;
    }

    determinePosition().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        yandexMapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: Point(
                latitude: myPosition.latitude,
                longitude: myPosition.longitude,
              ),
              zoom: 19,
              tilt: 10,
              azimuth: 40,
            ),
          ),
          animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2),
        );
        notifyListeners();
      });
    });
  }

  /// A method that returns location after determining whether location is allowed in the application
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    myPosition = await Geolocator.getCurrentPosition();

    if (mapObjectList.whereType<PlacemarkMapObject>().last.mapId.value == "user") {
      mapObjectList.removeLast();
      putLabel(
        lan: myPosition.latitude,
        lon: myPosition.longitude,
        id: 'user',
        imgPath: "assets/img/dot.png",
      );
    } else {
      putLabel(
        lan: myPosition.latitude,
        lon: myPosition.longitude,
        id: 'user',
        imgPath: "assets/img/dot.png",
      );
    }

    notifyListeners();
    return myPosition;
  }

  /// A method that places a PlacemarkIcon on the map
  void putLabel({
    required double lan,
    required double lon,
    required String id,
    required String imgPath,
  }) {
    PlacemarkIcon placemarkIcon = PlacemarkIcon.single(
      PlacemarkIconStyle(
        scale: 1,
        anchor: const Offset(0, 0),
        isFlat: false,
        rotationType: RotationType.noRotation,
        image: BitmapDescriptor.fromAssetImage(imgPath),
      ),
    );

    mapObjectList.add(
      PlacemarkMapObject(
        mapId: MapObjectId(id),
        opacity: 1,
        point: Point(
          latitude: lan,
          longitude: lon,
        ),
        icon: placemarkIcon,
      ),
    );

    notifyListeners();
  }

  // Method to handle map tap and check proximity to placemarks
  void handleMapTap(Point tappedPoint) {
    const double maxDistance = 30; // Maximum tap distance in meters for placemarks

    for (var placemark in mapObjectList.whereType<PlacemarkMapObject>()) {
      final double distance = calculateDistance(tappedPoint, placemark.point);
      if (distance <= maxDistance) {
        for (var element in stadiumList) {
          if (element.latitude == placemark.point.longitude) {
            stadiumModel = element;
            notifyListeners();
            closeFloatingActionButton();
            break;
          }
        }
        break;
      }
    }
  }

  // Utility method to calculate the distance between two points
  double calculateDistance(Point p1, Point p2) {
    const double earthRadius = 6371000; // Radius of Earth in meters
    final double lat1 = p1.latitude * pi / 180;
    final double lon1 = p1.longitude * pi / 180;
    final double lat2 = p2.latitude * pi / 180;
    final double lon2 = p2.longitude * pi / 180;

    final double dlat = lat2 - lat1;
    final double dlon = lon2 - lon1;

    final double a = sin(dlat / 2) * sin(dlat / 2) + cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }

  void initialAnimations(TickerProvider value) {
    animationController = AnimationController(
      vsync: value,
      duration: const Duration(milliseconds: 1500),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();
  }

  void closeFloatingActionButton() {
    isFloatactionButtonVisibility = !isFloatactionButtonVisibility;
    notifyListeners();
  }

  Future<void> changeTab(int value) async {
    await Future.delayed(const Duration(milliseconds: 200));
    currextTabIndex = value;
    notifyListeners();
  }

  void showLocationSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "To continue, enable geolocation on your device, which uses Google's location service",
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'No Thanks',
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // open device location setting
                await Geolocator.openLocationSettings();
                context.pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
