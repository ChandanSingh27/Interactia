import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_color.dart';

class AppConstantTextStyle{
  static TextStyle headingSemiBold_20() => const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.white
    );
  static TextStyle textFormFieldStyle() => TextStyle(
      fontSize: 12,
      color: AppConstantsColor.appTextLightShadeColor
  );

}