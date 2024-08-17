import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/main/view/widgets/home_page_stadium_card_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      ),
                      labelColor: AppColors.c2AA64C,
                      unselectedLabelColor: AppColors.c181725,
                      tabs: const [
                        TabItem(
                          title: 'Map',
                          iconPath: "assets/svg/map.svg",
                        ),
                        TabItem(
                          title: 'List',
                          iconPath: "assets/svg/list_check.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('Archived Page')),
            SizedBox.expand(
              child: ListView.separated(
                padding: REdgeInsets.all(25),
                itemBuilder: (_, i) {
                  return HomePageStadiumCardWidgets();
                },
                separatorBuilder: (BuildContext context, int index) => 10.verticalSpace,
                itemCount: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final String iconPath;

  const TabItem({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
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
            ),
            8.horizontalSpace,
            Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
