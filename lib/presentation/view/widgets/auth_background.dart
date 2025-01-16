import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/images.dart';
import '../../../core/utils/extension/extension.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageManager.authBackground,
            width: context.width,
            height: context.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 45.h,
            top: 45.h,
            right: context.width * 0.06,
            child: Container(
              width: context.width / 3,
              decoration: BoxDecoration(
                boxShadow: ShadowManager.shadow,
                color: ColorManager.offWhite2.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
