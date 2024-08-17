import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';

class HomePageStadiumCardWidgets extends StatelessWidget {
  const HomePageStadiumCardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 178.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.cEDEDED, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 168.h,
                child: Stack(
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(12.r),
                    //     bottomLeft: Radius.circular(12.r),
                    //   ),
                    //   child: Image.network(
                    //     'https://i.ibb.co/khh3NYM/image.png',
                    //     fit: BoxFit.cover,
                    //     height: 168.h,
                    //   ),
                    // ),
                    Positioned(
                      top: 20.h,
                      left: 24.w,
                      child: Container(
                        padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.c00AA5B,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          'Working',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy-Medium',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Padding(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stadium “Signal Iduna Park”',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.c181725,
                          fontFamily: 'Gilroy_Bold',
                        ),
                      ),
                      Text(
                        'Shayhontohur, St. Bunyodkor',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.cB2B2B2,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      Text(
                        '120 000 uzs/hour',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.c2AA64C,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width * 0.7,
                            height: 36.h,
                            highlightElevation: 0,
                            // padding: EdgeInsets.zesro,
                            padding: REdgeInsets.symmetric(horizontal: 40, vertical: 5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            color: AppColors.c2AA64C,
                            onPressed: () {},
                            child: Text(
                              'Book now!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy-Medium',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36.h,
                            width: 36.w,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.cF7F7F7,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: REdgeInsets.all(5.5),
                                child: SvgPicture.asset('assets/svg/vector.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
