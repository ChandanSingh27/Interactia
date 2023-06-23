import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_color.dart';

class AppConstantTextStyle{
  static TextStyle headingSemiBold_28() => const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white
    );
  static TextStyle formFieldTextStyle() => TextStyle(
      fontSize: 14,
      color: AppConstantsColor.appTextLightShadeColor
  );
  static TextStyle passwordFormFieldTextStyle() => TextStyle(
      fontSize: 18,
      color: AppConstantsColor.appTextLightShadeColor
  );

}