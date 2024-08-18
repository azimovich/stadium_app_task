import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';
import 'package:stadium_app_task/src/data/repository/app_repository_impl.dart';

final homeVM = ChangeNotifierProvider((ref) => HomeVm());
final homeFetchData = FutureProvider((ref) async {
  log('1');
  ref.read(homeVM).getStadiumList();
  log('2');
});

class HomeVm with ChangeNotifier {
  int currextTabIndex = 0;
  List<StadiumModel> stadiumList = [];
  bool isLoading = true;
  HomeVm() {
    getStadiumList();
  }
  AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  void tabChange(int value) {
    currextTabIndex = value;
    notifyListeners();
  }

  Future<void> getStadiumList() async {
    stadiumList = await _appRepositoryImpl.getStadiumList() ?? [];
    notifyListeners();
  }
}
