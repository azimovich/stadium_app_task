import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_map.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_search.dart';
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
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 27, vertical: 16),
              child: SizedBox(
                height: 51,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: REdgeInsets.all(2),
                    child: TabBar(
                      onTap: (value) {
                        ref.read(homeVM).changeTab(value);
                      },
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      ),
                      labelColor: AppColors.c2AA64C,
                      unselectedLabelColor: AppColors.c181725,
                      labelStyle: const TextStyle(fontFamily: 'Gilroy-SemiBold'),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ref.watch(homeVM).currextTabIndex == 0
                                  ? SvgPicture.asset('assets/svg/active_map.svg')
                                  : SvgPicture.asset('assets/svg/map.svg'),
                              8.horizontalSpace,
                              const Text(
                                'Map',
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ref.watch(homeVM).currextTabIndex == 1
                                  ? SvgPicture.asset('assets/svg/active_list_check.svg')
                                  : SvgPicture.asset('assets/svg/list_check.svg'),
                              8.horizontalSpace,
                              const Text(
                                'List',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [HomePageMap(), HomePageSearch()],
        ),
      ),
    );
  }
}
