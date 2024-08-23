import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stadium_app_task/src/core/constants/context_extension.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';

class HomePageTabbarWidget extends ConsumerWidget {
  const HomePageTabbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 27, vertical: 16),
      child: SizedBox(
        height: 51,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            color: context.theme.colorScheme.secondaryFixed,
          ),
          child: Padding(
            padding: REdgeInsets.all(2),
            child: TabBar(
              onTap: (value) async {
                await ref.read(homeVM).changeTab(value);
              },
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: context.theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.all(Radius.circular(7.r)),
              ),
              labelColor: AppColors.c2AA64C,
              unselectedLabelColor: context.theme.colorScheme.onPrimary,
              labelStyle: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ref.watch(homeVM).currextTabIndex == 0
                          ? SvgPicture.asset('assets/svg/active_map.svg')
                          : SvgPicture.asset(
                              'assets/svg/map.svg',
                              color: context.theme.colorScheme.onPrimary,
                            ),
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
                          : SvgPicture.asset(
                              'assets/svg/list_check.svg',
                              color: context.theme.colorScheme.onPrimary,
                            ),
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
    );
  }
}
