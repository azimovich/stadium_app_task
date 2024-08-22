import 'package:flutter/material.dart';
import 'package:stadium_app_task/src/core/router/router_config.dart';
import 'package:stadium_app_task/src/feature/setting/inherted_theme_notifair.dart';
import 'package:stadium_app_task/src/feature/setting/theme_controller.dart';

final ThemeController themeController = ThemeController();

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) => InheritedThemeNotifier(
        themeController: themeController,
        child: Builder(builder: (context) {
          return MaterialApp.router(
            routerConfig: RouteSystem.goRouter,
            theme: InheritedThemeNotifier.maybeOf(context)?.theme,
            debugShowCheckedModeBanner: false,
          );
        }),
      );
}
