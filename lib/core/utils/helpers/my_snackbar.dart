import 'package:flutter/material.dart';
import '../../../core/utils/extension/extension.dart';

import '../constants/colors.dart';

void customSnackBar(BuildContext context,
    [String? message, Color? color, int? seconds]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: context.width / 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: Duration(seconds: seconds ?? 2),
      backgroundColor: (color ?? ColorManager.orange).withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          message ?? "there was an error please try again later!",
          style: context.textTheme.displayMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      )));
}
