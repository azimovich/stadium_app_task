import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_app_task/setup.dart';

// ConnetionControllerProvider ni yaratamiz
final connetionControllerProvider = ChangeNotifierProvider<ConnetionController>((ref) {
  return ConnetionController();
});

class ConnetionController with ChangeNotifier {
  late bool isDeviceConnectionEnable;
  late Stream<ConnectivityResult> _connectivityStream;

  ConnetionController() : isDeviceConnectionEnable = false {
    listenDeviceConnectionEnable();
  }

  Future<void> listenDeviceConnectionEnable() async {
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivityStream.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isDeviceConnectionEnable = false;
        isConneted = false;
        notifyListeners();
        log('connection not enable');
        log('$isConneted');
      } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        isConneted = true;
        isDeviceConnectionEnable = true;
        notifyListeners();
        log('$isConneted');
        log('connection enable');
      }
    });

    isDeviceConnectionEnable = await checkInternetConnection();
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true; // Internet mavjud
    } else {
      return false; // Internet yo'q
    }
  }
}
