import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'This Page Will Be Soon',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
    );
  }
}
