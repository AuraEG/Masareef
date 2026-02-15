import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/utils/spacing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.wallet, color: AppColor.white),
        horizontalSpace(15),
        Column(
          children: [
            Text(
              'Masareef',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
            Text(
              'Welcome back, Dude',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: AppColor.green,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton.outlined(
          color: AppColor.green,
          onPressed: () {
            // TODO: navigate to notification screen after implemint it.
          },
          icon: Icon(Icons.notifications_active_outlined),
        ),
      ],
    );
  }
}
