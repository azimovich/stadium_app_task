import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stadium_app_task/src/core/constants/context_extension.dart';

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
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
            nextBranch(currentIndex);
          },
          useLegacyColorScheme: false,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            fontFamily: 'Gilroy',
            color: context.theme.colorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            fontFamily: 'Gilroy',
            color: context.theme.colorScheme.onSecondary,
          ),
          elevation: 0,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Image.asset(
                'assets/img/stadium.png',
                height: 20,
                width: 25,
                color: context.theme.colorScheme.onSecondary,
              ),
              activeIcon: Image.asset(
                'assets/img/stadium.png',
                height: 20,
                width: 25,
                color: context.theme.colorScheme.primary,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Favourite',
              icon: Image.asset(
                'assets/img/bookmark.png',
                height: 20,
                width: 23,
                color: context.theme.colorScheme.onSecondary,
              ),
              activeIcon: Image.asset(
                'assets/img/bookmark.png',
                height: 20,
                width: 23,
                color: context.theme.colorScheme.primary,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Image.asset(
                'assets/img/profile.png',
                height: 20,
                width: 16,
                color: context.theme.colorScheme.onSecondary,
              ),
              activeIcon: Image.asset(
                'assets/img/profile.png',
                height: 20,
                width: 16,
                color: context.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
