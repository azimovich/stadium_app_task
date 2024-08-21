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
                    if (ctr.isFloatactionButtonVisibility) {
                      ctr.handleMapTap(point);
                    } else {
                      ctr.closeFloatingActionButton();
                    }
                  },
                  nightModeEnabled: themeController.isDark,
                  mapObjects: ctr.mapObjectList,
                  onMapCreated: ctr.onMapCreated,
                ),
                AnimatedSlide(
                  offset: ctr.isFloatactionButtonVisibility
                      ? const Offset(0, 1.1) // Boshida ekrandan tashqarida turadi
                      : const Offset(0, 0), // So'ngra ko'rinadigan holatga o'tadi
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedOpacity(
                    opacity: ctr.isFloatactionButtonVisibility ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 600),
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 25),
                      child: HomePageMapCardWidget(
                        stadiumModel: ctr.stadiumModel,
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
