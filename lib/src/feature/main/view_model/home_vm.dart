import 'dart:developer';

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
  bool isFloatactionButtonVisibility = true;
  int currextTabIndex = 0;
  List<StadiumModel> stadiumList = [];
  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  // HomePageMap Varibles
  late Position myPosition;
  List<MapObject> mapObjectList = [];
  late YandexMapController yandexMapController;

  /// Map birinchi create bo'lganda ishlaydiga method
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

  /// Ilovada location ga ruxsat berilganligini aniqlab keyin location qaytradigan method
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

    // log(mapObjectList.toString());

    isLoading = false;
    notifyListeners();
    return myPosition;
  }

  /// User location aniqlaydigan method
  void findMe() {
    if (isLoading) {
      // Handle case where position is not yet available
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

  /// Map dan belgilangan joyga pointer (belgi) qo'yib beradi
  void putLabel({
    required double lan,
    required double lon,
    required String id,
    required String imgPath,
  }) {
    PlacemarkIcon placemarkIcon = PlacemarkIcon.single(
      PlacemarkIconStyle(
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

  void initial() {
    getStadiumList().then((_) {
      determinePosition().then((value) {
        // Mapga Stadionlarni joylashgan joyini korsatish
        for (var element in stadiumList) {
          log("lon: ${element.longitude.toString()}");
          log("lan: ${element.latitude.toString()}");
          log('');
          putLabel(
            lan: element.longitude ?? 0,
            lon: element.latitude ?? 0,
            id: element.latitude.toString(),
            imgPath: "assets/img/point.png",
          );
        }

        // Mapda user turgan joylashuvni korsatish
        putLabel(
          lan: myPosition.latitude,
          lon: myPosition.longitude,
          id: myPosition.latitude.toString(),
          imgPath: "assets/img/dot.png",
        );
      });
    });
  }

  void onMapTap() {
    isFloatactionButtonVisibility = !isFloatactionButtonVisibility;
    notifyListeners();
  }

  void tabChange(int value) {
    currextTabIndex = value;
    notifyListeners();
  }

  Future<void> getStadiumList() async {
    stadiumList = await _appRepositoryImpl.getStadiumList() ?? [];
    notifyListeners();
  }
}
