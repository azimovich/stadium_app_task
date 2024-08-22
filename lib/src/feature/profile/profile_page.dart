import 'package:flutter/material.dart';
import 'package:stadium_app_task/src/core/widget/app_material_context.dart';

// Theme Ozgartilishi uchun switchTheme ozi kifoya ekanligi uchun ortiq contorllerlar qoshmadim

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'This Page Will Be Soon',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // InheritedThemeNotifier.maybeOf(context)?.switchTheme();
          themeController.switchTheme();
        },
        child: themeController.isLight ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
      ),
    );
  }
}
