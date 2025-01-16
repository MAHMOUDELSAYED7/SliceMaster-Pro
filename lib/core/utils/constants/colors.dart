import 'package:flutter/material.dart';

abstract class ColorManager {
  const ColorManager._();
  static const Color orange = Color(0xffFF5B00);
  static const Color grey = Color(0xff666666);
  static const Color darkGrey = Color(0xff212121);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color offWhite2 = Color(0xffD9D9D9);
  static const Color red = Color(0xffEE0000);
  static const Color correct = Color(0xff25BD5D);
  static const Color offWhite = Color(0xffF4F4F4);
  static const Color trasnsparent = Colors.transparent;
}

abstract class ShadowManager {
  const ShadowManager._();

  static List<BoxShadow> shadow = [
    BoxShadow(
      color: ColorManager.black.withOpacity(0.25),
      offset: const Offset(10, 19),
      blurRadius: 20,
    ),
  ];
}
