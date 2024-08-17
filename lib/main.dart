import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stadium_app_task/app.dart';

void main(List<String> args) async {
  runApp(const ProviderScope(child: App()));
}
