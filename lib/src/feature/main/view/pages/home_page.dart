import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_map.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_search.dart';
import 'package:stadium_app_task/src/feature/main/view/widgets/home_page_tabbar_widget.dart';
import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(homeFetchData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: const HomePageTabbarWidget(),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePageMap(),
            HomePageSearch(),
          ],
        ),
      ),
    );
  }
}
