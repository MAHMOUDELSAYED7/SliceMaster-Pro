import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/extension/extension.dart';

class AuthHeadline extends StatelessWidget {
  const AuthHeadline({
    super.key,
    this.firstText,
    this.secondText,
    this.smallText = false,
  });
  final String? firstText;
  final String? secondText;
  final bool? smallText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText ?? 'Welcome',
          style: context.textTheme.displayLarge
              ?.copyWith(fontSize: smallText == true ? 5.8.sp : null),
        ),
        Text(
          secondText ?? ' back',
          style: context.textTheme.bodyLarge
              ?.copyWith(fontSize: smallText == true ? 5.8.sp : null),
        ),
      ],
    );
  }
}
