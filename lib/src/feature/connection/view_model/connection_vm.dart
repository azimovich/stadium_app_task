// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/setup.dart';
import 'package:stadium_app_task/src/core/router/app_route_name.dart';

final connectionVm = ChangeNotifierProvider((ref) => ConnectionVm());

class ConnectionVm with ChangeNotifier {
  Future<void> checkConnection(BuildContext context) async {
    if (await checkInternetConnection()) {
      context.go(AppRouteName.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Try Again!')));
    }
  }
}
