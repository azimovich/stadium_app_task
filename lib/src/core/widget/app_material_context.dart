import 'package:flutter/material.dart';
import 'package:stadium_app_task/src/core/router/router_config.dart';
// import 'package:stadium_app_task/src/feature/connection/view/pages/connection_page.dart';
// import 'package:stadium_app_task/src/feature/profile/profile_page.dart';
import 'package:stadium_app_task/src/feature/setting/connetion_controller.dart';
import 'package:stadium_app_task/src/feature/setting/inherted_connection_notifair.dart';
import 'package:stadium_app_task/src/feature/setting/inherted_theme_notifair.dart';
import 'package:stadium_app_task/src/feature/setting/theme_controller.dart';

final ThemeController themeController = ThemeController();
final ConnetionController connetionController = ConnetionController();

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) => InheritedThemeNotifier(
        themeController: themeController,
        child: InhertedConnectionNotifair(
          connetionController: connetionController,
          child: Builder(builder: (context) {
            return MaterialApp.router(
              routerConfig: RouteSystem.goRouter,
              theme: InheritedThemeNotifier.maybeOf(context)?.theme,
              debugShowCheckedModeBanner: false,
            );
          }),
        ),
      );

  // @override
  // Widget build(BuildContext context) => InheritedThemeNotifier(
  //       themeController: themeController,
  //       child: InhertedConnectionNotifair(
  //         connetionController: connetionController,
  //         child: Builder(builder: (context) {
  //           return MaterialApp(
  //             home: InhertedConnectionNotifair.maybeOf(context)!.isDeviceConnectionEnable ? ProfilePage() : ConnectionPage(),
  //           );
  //         }),
  //       ),
  //     );
}
