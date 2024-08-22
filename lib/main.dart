import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_app_task/app.dart';
import 'package:stadium_app_task/setup.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const ProviderScope(child: App()));
}
