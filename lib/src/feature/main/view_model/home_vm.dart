import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';
import 'package:stadium_app_task/src/data/repository/app_repository_impl.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final homeVM = ChangeNotifierProvider((ref) => HomeVm());

// Fechting data
final homeFetchData = FutureProvider((ref) async {
  ref.read(homeVM).initial();
});

class HomeVm with ChangeNotifier {
  // HomePageSearch Varibales
  bool isLoading = true;
  int currextTabIndex = 0;
  StadiumModel stadiumModel = StadiumModel();
  List<StadiumModel> stadiumList = [];
  bool isFloatactionButtonVisibility = true;
  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  // HomePageMap Varibles
  late Position myPosition;
  List<MapObject> mapObjectList = [];
  late YandexMapController yandexMapController;
  late AnimationController animationController;
  late Animation<double> animation;

  /// Methods

  /// Get Satdium List Method
  Future<void> getStadiumList() async {
    stadiumList = await _appRepositoryImpl.getStadiumList() ?? [];
    notifyListeners();
  }

  /// Method that works when the map is first created
  void onMapCreated(YandexMapController controller) {
    yandexMapController = controller;
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: myPosition.latitude, longitude: myPosition.longitude),
          zoom: 15,
          tilt: 10,
          azimuth: 0,
        ),
      ),
    );
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

    isLoading = false;
    notifyListeners();
    return myPosition;
  }

  /// Method that determines user location
  void findMe() {
    if (isLoading) {
      return;
    }
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
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2));
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

  void initial() {
    getStadiumList().then((_) {
      determinePosition().then((value) {
        for (var element in stadiumList) {
          putLabel(
            lan: element.longitude ?? 0,
            lon: element.latitude ?? 0,
            id: element.latitude.toString(),
            imgPath: "assets/img/point.png",
          );
        }

        putLabel(
          lan: myPosition.latitude,
          lon: myPosition.longitude,
          id: myPosition.latitude.toString(),
          imgPath: "assets/img/dot.png",
        );
      });
    });
  }

  void closeFloatingActionButton() {
    isFloatactionButtonVisibility = !isFloatactionButtonVisibility;
    notifyListeners();
  }

  void changeTab(int value) {
    currextTabIndex = value;
    notifyListeners();
  }
}
