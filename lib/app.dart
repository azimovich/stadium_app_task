import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import "package:device_preview/device_preview.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/widget/app_material_context.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => DevicePreview(
        enabled: kDebugMode && false,
        builder: (context) => const AppMaterialContext(),
      ),
    );
  }
}
