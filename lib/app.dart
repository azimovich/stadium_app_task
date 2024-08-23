import 'package:flutter/material.dart';
import 'package:stadium_app_task/src/core/widget/app_material_context.dart';
import 'package:stadium_app_task/src/core/widget/cutsom_screen_util_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const CustomScreenUtil(
        // enabledPreview: false,
        child: AppMaterialContext(),
      );
}
