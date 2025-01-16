import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/extension/extension.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    this.title,
    this.onPressed,
    this.widget,
    this.size,
    this.fontSize,
    this.backgroundColor,
  });
  final String? title;
  final VoidCallback? onPressed;
  final Size? size;
  final Widget? widget;
  final double? fontSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: context.elevatedButtonTheme.style?.copyWith(
          fixedSize: WidgetStatePropertyAll(
            size ?? Size(context.width * 0.11, 34.h),
          ),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          overlayColor: WidgetStatePropertyAll(backgroundColor),
        ),
        onPressed: onPressed,
        child: widget ??
            Text(
              title ?? "",
            ));
  }
}
