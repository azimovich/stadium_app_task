import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/data/model/stadium_model.dart';

class HomePageMapCardWidget extends StatelessWidget {
  final StadiumModel stadiumModel;
  const HomePageMapCardWidget({super.key, required this.stadiumModel});

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
            child: SizedBox(
              height: 178.h,
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
                  // height: 186.h,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
                  // 6.verticalSpace,
                  MaterialButton(
                    height: 36.h,
                    elevation: 0,
                    highlightElevation: 0,
                    minWidth: double.infinity,
                    color: AppColors.c2AA64C,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
