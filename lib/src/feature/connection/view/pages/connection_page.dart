import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/core/style/app_colors.dart';
import 'package:stadium_app_task/src/feature/connection/view_model/connection_vm.dart';

class ConnectionPage extends ConsumerWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
              width: 150.w,
              child: Image.asset("assets/img/lost_connection.png", fit: BoxFit.cover),
            ),
            18.verticalSpace,
            Text(
              'Lost Connection Check Your Connetion and Try Again!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy-Bold',
                fontSize: 24.sp,
              ),
            ),
            18.verticalSpace,
            MaterialButton(
              height: 36.h,
              padding: EdgeInsets.zero,
              minWidth: MediaQuery.of(context).size.width * 0.5,
              color: AppColors.c2AA64C,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              onPressed: () async {
                ref.read(connectionVm).checkConnection(context);
              },
              child: Text(
                'Check Connect!',
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
    );
  }
}
