import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/extension/extension.dart';
import '../utils/constants/colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.onSaved,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.keyboardType,
    this.icon,
    this.title,
    this.obscureText,
    this.initialValue,
    this.validateWithoutText,
    this.onChanged,
  });
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? obscureText;
  final String? initialValue;
  final bool? validateWithoutText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.2,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
          child: title != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      style: context.textTheme.displaySmall,
                    ),
                    Text(
                      ' *',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 4.sp,
                        height: 0.5,
                      ),
                    ),
                  ],
                )
              : null,
        ),
        TextFormField(
          initialValue: initialValue,
          style: context.textTheme.displaySmall,
          cursorColor: ColorManager.orange,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText ?? false,
          validator: validateWithoutText == true
              ? (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                }
              : validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return title?.isNotEmpty ?? false
                          ? "$title cannot be empty"
                          : "Field cannot be empty";
                    } else {
                      return null;
                    }
                  },
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onChanged: onChanged,
          decoration: InputDecoration(
            errorStyle: validateWithoutText == true
                ? context.textTheme.displaySmall?.copyWith(fontSize: 0)
                : null,
            isCollapsed: true,
            isDense: true,
            hintText: hintText,
            enabledBorder: context.inputDecoration.enabledBorder,
            focusedBorder: context.inputDecoration.focusedBorder,
            errorBorder: context.inputDecoration.errorBorder,
            focusedErrorBorder: context.inputDecoration.focusedErrorBorder,
          ),
        )
      ]),
    );
  }
}
