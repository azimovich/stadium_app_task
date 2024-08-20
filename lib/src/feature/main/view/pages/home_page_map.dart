// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:stadium_app_task/src/core/style/app_colors.dart';
// import 'package:stadium_app_task/src/core/widget/app_material_context.dart';
// import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class HomePageMap extends ConsumerStatefulWidget {
//   const HomePageMap({super.key});

//   @override
//   ConsumerState<HomePageMap> createState() => _HomePageMapState();
// }

// class _HomePageMapState extends ConsumerState<HomePageMap> {
//   @override
//   void initState() {
//     ref.read(homeFetchData);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ctr = ref.read(homeVM);
//     return Scaffold(
//       body: ref.watch(homeVM).isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.c2AA64C,
//               ),
//             )
//           : Stack(
//               alignment: const Alignment(0, 1),
//               children: [
//                 YandexMap(
//                   mode2DEnabled: true,
//                   onMapTap: (Point point) {},
//                   nightModeEnabled: themeController.isDark,
//                   mapObjects: ref.watch(homeVM).mapObjectList,
//                   onMapCreated: ref.watch(homeVM).onMapCreated,
//                 ),

//               ],
//             ),
//       floatingActionButton: ctr.isFloatactionButtonVisibility
//           ? FloatingActionButton(
//               backgroundColor: themeController.theme.colorScheme.primary,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
//               onPressed: () {
//                 ref.read(homeVM).findMe();
//               },
//               child: SvgPicture.asset('assets/svg/gps.svg'),
//             )
//           : null,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/core/widget/app_material_context.dart';
import 'package:stadium_app_task/src/feature/main/view/widgets/home_page_map_card_widget.dart';
import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomePageMap extends ConsumerStatefulWidget {
  const HomePageMap({super.key});

  @override
  ConsumerState<HomePageMap> createState() => _HomePageMapState();
}

class _HomePageMapState extends ConsumerState<HomePageMap> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    ref.read(homeFetchData);

    // Animation controller initialization
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward(); // Start the animation when FAB is shown
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctr = ref.read(homeVM);
    return Scaffold(
      body: ref.watch(homeVM).isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.c2AA64C,
              ),
            )
          : Stack(
              alignment: const Alignment(0, 0.9),
              children: [
                YandexMap(
                  mode2DEnabled: true,
                  onMapTap: (Point point) {
                    ctr.onMapTap();
                  },
                  nightModeEnabled: themeController.isDark,
                  mapObjects: ref.watch(homeVM).mapObjectList,
                  onMapCreated: ref.watch(homeVM).onMapCreated,
                ),
                ctr.isFloatactionButtonVisibility
                    ? const SizedBox()
                    : ScaleTransition(
                        scale: _animation,
                        child: SizedBox(
                          height: 180.h,
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 25),
                            child: HomePageMapCardWidget(
                              stadiumModel: ctr.stadiumList[1],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
      floatingActionButton: ctr.isFloatactionButtonVisibility
          ? ScaleTransition(
              scale: _animation,
              child: FloatingActionButton(
                backgroundColor: themeController.theme.colorScheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                onPressed: () {
                  ref.read(homeVM).findMe();
                },
                child: SvgPicture.asset('assets/svg/gps.svg'),
              ),
            )
          : null,
    );
  }
}
