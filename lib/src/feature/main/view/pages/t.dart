import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stadium_app_task/src/core/constants/context_extension.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CustomYandexMap extends StatefulWidget {
  const CustomYandexMap({super.key});

  @override
  State<CustomYandexMap> createState() => _CustomYandexMapState();
}

class _CustomYandexMapState extends State<CustomYandexMap> {
  /// O'zgaruvchilar
  late YandexMapController yandexMapController;
  late Position myPosition;
  bool isLoading = false;
  bool _isTheme = false;
  List<MapObject> mapObjectList = [];
  String speed = "0";

  /// Map birinchi create bo'lganda ishlaydiga method
  void onMapCreated(YandexMapController controller) {
    yandexMapController = controller;
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: myPosition.latitude, longitude: myPosition.longitude),
          zoom: 13,
          tilt: 900,
          azimuth: 180,
        ),
      ),
    );
  }

  /// Ilovada location ga ruxsat berilganligini aniqlab keyin location qaytradigan method
  Future<Position> _determinePosition() async {
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
    isLoading = true;
    setState(() {});
    return myPosition;
  }

  /// User location aniqlaydigan method
  void findMe() {
    yandexMapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: myPosition.latitude,
              longitude: myPosition.longitude,
            ),
            zoom: 18,
            tilt: 90,
            azimuth: 90,
          ),
        ),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2));


    log(mapObjectList.toString());
  }

  /// Map dan belgilangan joyga pointer (belgi) qo'yib beradi
  void putLabel({
    required double lan,
    required double lon,
    required String id,
  }) {
    PlacemarkIcon placemarkIcon = PlacemarkIcon.single(
      PlacemarkIconStyle(
        scale: 0.15,
        isFlat: false,
        rotationType: RotationType.noRotation,
        anchor: const Offset(0.5, 1),
        image: BitmapDescriptor.fromAssetImage("assets/img/dot.png"),
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
    // mapObjectList.removeRange(1, mapObjectList.length - 1); // no need if id is same
    setState(() {});
  }


  @override
  void initState() {
    _determinePosition().then((value) {
      putLabel(
        lan: myPosition.latitude,
        lon: myPosition.longitude,
        id: myPosition.latitude.toString(),
      );
    });
    super.initState();
  }

////Asosiy qism
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Stack(
                alignment: const Alignment(0, -0.8),
                children: [
                  YandexMap(
                    onMapCreated: onMapCreated,
                    onMapTap: (Point point) {
                      putLabel(
                        lan: point.latitude,
                        lon: point.longitude,
                        id: point.latitude.toString(), // id should be same
                      );
                    },
                    mode2DEnabled: true,
                    nightModeEnabled: _isTheme,
                    mapObjects: mapObjectList,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
                    child: Text("Speed: $speed m/s"),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          onPressed: () {
            findMe();
          },
          child: const Icon(Icons.gps_fixed_rounded),
        ),);
  }
}
