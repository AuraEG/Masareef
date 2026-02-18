import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/utils/spacing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(Icons.wallet, color: colorScheme.onSurface),
        horizontalSpace(15),
        Column(
          children: [
            Text(
              'Masareef',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              'Welcome back, Dude',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton.outlined(
          color: colorScheme.secondary,
          onPressed: () {
            // TODO: navigate to notification screen after implementing it.
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
      ],
    );
  }
}
