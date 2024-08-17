import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';

final homeVM = ChangeNotifierProvider((ref) => HomeVm());

class HomeVm with ChangeNotifier {
  // List<StadiumModel> stadiumList = stadiumModelFromJson();
}
