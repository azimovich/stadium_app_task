import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void nextBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          nextBranch(currentIndex);
        },
        
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, fontFamily: 'Gilroy', color: AppColors.c2AA64C),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, fontFamily: 'Gilroy', color: AppColors.c181725),
        elevation: 0,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Image.asset(
              'assets/img/stadium.png',
              height: 20,
              width: 25,
              color: AppColors.c181725,
            ),
            activeIcon: Image.asset(
              'assets/img/stadium.png',
              height: 20,
              width: 25,
              color: AppColors.c2AA64C,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favourite',
            icon: Image.asset(
              'assets/img/bookmark.png',
              height: 20,
              width: 23,
              color: AppColors.c181725,
            ),
            activeIcon: Image.asset(
              'assets/img/bookmark.png',
              height: 20,
              width: 23,
              color: AppColors.c2AA64C,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Image.asset(
              'assets/img/profile.png',
              height: 20,
              width: 16,
              color: AppColors.c181725,
            ),
            activeIcon: Image.asset(
              'assets/img/profile.png',
              height: 20,
              width: 16,
              color: AppColors.c2AA64C,
            ),
          ),
        ],
      ),
    );
  }
}
