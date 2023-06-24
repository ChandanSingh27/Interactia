import 'package:flutter/material.dart';
import 'package:taskhub/utility/constants_color.dart';

class AppConstantTextStyle{
  static TextStyle headingLargeBold_28({required Color color}) => TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color
  );

  static TextStyle headingMediumSemiBold_28({required Color color}) => TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: color
  );

  static TextStyle bodySmall_18({required Color color}) => TextStyle(
      fontSize: 14,
      color: color
  );
  
  static TextStyle formFieldTextStyleBlack() => TextStyle(
      fontSize: 14,
      color: AppConstantsColor.black.withOpacity(0.7)
  );
  static TextStyle formFieldTextStyleWhite() => TextStyle(
      fontSize: 14,
      color: AppConstantsColor.white.withOpacity(0.7)
  );
  static TextStyle formFieldHintTextStyle() => TextStyle(
      fontSize: 14,
      color: AppConstantsColor.appTextLightShadeColor
  );
  static TextStyle passwordFormFieldTextStyle() => TextStyle(
      fontSize: 18,
      color: AppConstantsColor.appTextLightShadeColor
  );

}