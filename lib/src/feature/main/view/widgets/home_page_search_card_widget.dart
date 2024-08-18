import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';

class HomePageSearchCardWidget extends StatelessWidget {
  final StadiumModel stadiumModel;
  const HomePageSearchCardWidget({super.key, required this.stadiumModel});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.cEDEDED, width: 1.w),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SizedBox(
                  height: 166,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        12.r,
                      ),
                      bottomLeft: Radius.circular(12.r),
                    ),
                    child: Image.network(
                      stadiumModel.image ?? 'https://i.ibb.co/khh3NYM/image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  left: 14.w,
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: stadiumModel.isAvailable == true ? AppColors.c00AA5B : AppColors.cFFDA69,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      stadiumModel.isAvailable == true ? 'Working' : "Closed",
                      style: TextStyle(
                        color: stadiumModel.isAvailable == true ? AppColors.white : AppColors.c4D3D0F,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-Regular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: REdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stadiumModel.name ?? "Unknow",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.c181725,
                      fontFamily: 'Gilroy-Bold',
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    stadiumModel.address ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.cB2B2B2,
                      fontFamily: 'Gilroy-SemiBold',
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    '${stadiumModel.pricePerHour} uzs/hour',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.c2AA64C,
                      fontFamily: 'Gilroy-SemiBold',
                    ),
                  ),
                  8.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          height: 36.h,
                          highlightElevation: 0,
                          elevation: 0,
                          minWidth: MediaQuery.of(context).size.width * 0.34,
                          // minWidth: double.infinity,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          color: stadiumModel.isAvailable == true ? AppColors.c2AA64C : AppColors.cB2B2B2,
                          onPressed: () {},
                          child: Text(
                            'Book now!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy-SemiBold',
                            ),
                          ),
                        ),
                        // 8.horizontalSpace,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
