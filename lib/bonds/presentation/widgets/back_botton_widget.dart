import 'package:flutter/material.dart';
import 'package:ultra/gen/assets.gen.dart';
import 'package:ultra/utils/app_colors.dart';
import 'package:ultra/utils/constants.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const BackButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          height: 36,
          width: 36,
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey, width: 0.5),
            boxShadow: appBoxShadows,
          ),
          child: Assets.icons.icBack.svg(),
        ),
      ),
    );
  }
}
