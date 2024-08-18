import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/main/view/pages/home_page_search.dart';
import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctr = ref.watch(homeVM);
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
                      onTap: (value) => ctr.tabChange(value),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      ),
                      labelColor: AppColors.c2AA64C,
                      unselectedLabelColor: AppColors.c181725,
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: 165.w,
                            height: 46.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/img/bookmark.png',
                                  height: 16.h,
                                  width: 16.w,
                                  color: ctr.currextTabIndex == 0 ? Colors.green : Colors.black,
                                ),
                                8.horizontalSpace,
                                Text(
                                  'Map',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            width: 165.w,
                            height: 46.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/img/bookmark.png',
                                  height: 16.h,
                                  width: 16.w,
                                  color: ctr.currextTabIndex == 1 ? Colors.green : Colors.black,
                                ),
                                8.horizontalSpace,
                                Text(
                                  'Map',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
        body: ctr.currextTabIndex == 0
            ? Container(
                color: Colors.black,
                height: double.infinity,
                width: double.infinity,
              )
            : Container(
                color: Colors.black,
                height: double.infinity,
                width: double.infinity,
              ),
      ),
    );
  }
}