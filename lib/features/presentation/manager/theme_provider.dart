
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utility/constants_color.dart';
import '../../../utility/constants_value.dart';
import '../../../utility/constants_text_style.dart';

class ThemeProvider with ChangeNotifier{

  ThemeMode appThemeMode = ThemeMode.system;


  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstantsColor.black,
    fontFamily: GoogleFonts.poppins().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppConstantsColor.blackLight,
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding),
      hintStyle: AppConstantTextStyle.formFieldHintTextStyle(),
    ),
    textTheme: TextTheme(
      titleLarge: AppConstantTextStyle.headingLargeBold_28(color: AppConstantsColor.white),
      titleMedium: AppConstantTextStyle.headingMediumSemiBold_28(color: AppConstantsColor.white),
      bodySmall: AppConstantTextStyle.bodySmall_18(color: AppConstantsColor.white.withOpacity(0.5))
    ),
  );

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppConstantsColor.white,

    fontFamily: GoogleFonts.poppins().fontFamily,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppConstantsColor.grayAsh.withOpacity(0.3),
      contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.constantsAppPadding),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
      ),
      hintStyle: AppConstantTextStyle.formFieldHintTextStyle(),
    ),

    textTheme: TextTheme(
        titleLarge: AppConstantTextStyle.headingLargeBold_28(color: AppConstantsColor.matteBlack),  
        titleMedium: AppConstantTextStyle.headingMediumSemiBold_28(color: AppConstantsColor.matteBlack),
        bodySmall: AppConstantTextStyle.bodySmall_18(color: AppConstantsColor.matteBlack.withOpacity(0.5))
    ),
  );

}

