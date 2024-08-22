import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatelessWidget {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokatsiya Tekshirish'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _locationService.checkLocationPermission(context);
          },
          child: Text('Lokatsiyani Tekshirish'),
        ),
      ),
    );
  }
}

class LocationService {
  // Lokatsiya xizmatlarini tekshirish va ruxsat so'rash
  Future<void> checkLocationPermission(BuildContext context) async {
    // Lokatsiya xizmatlari yoqilganligini tekshirish
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      // Agar lokatsiya xizmati yoqilmagan bo'lsa, dialog ko'rsatish
      showLocationSettingsDialog(context);
      return;
    }

    // Lokatsiya ruxsatlarini tekshirish
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Agar foydalanuvchi ruxsatni rad etgan bo'lsa, ruxsat so'rash
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lokatsiya xizmati uchun ruxsat berilmadi.'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Agar foydalanuvchi ruxsatni doimiy rad etsa
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lokatsiya ruxsati rad etildi, ilova sozlamalarida ruxsatni yoqing.'),
        ),
      );
      return;
    }

    // Agar hamma narsa yaxshi bo'lsa, lokatsiyani olish
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lokatsiyangiz: ${position.latitude}, ${position.longitude}'),
      ),
    );
  }

  // Foydalanuvchiga lokatsiya sozlamalariga yo'naltiruvchi dialogni ko'rsatish
  void showLocationSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("To continue, enable geolocation on your device, which uses Google's location service"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'No Thanks',
                style: TextStyle(fontFamily: 'Gilroy-Regular', fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'Gilroy-Regular', fontWeight: FontWeight.w400),
              ),
            ),
          ],
        );
      },
    );
  }
}
