
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utility/constants_color.dart';
import '../../../utility/constants_value.dart';
import '../../../utility/text_style.dart';

class ThemeProvider with ChangeNotifier{

  ThemeMode appThemeMode = ThemeMode.system;


  ThemeData darkTheme = ThemeData(
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
      hintStyle: AppConstantTextStyle.formFieldTextStyle(),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppConstantsColor.white
      )
    ),
  );

  ThemeData lightTheme = ThemeData(

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
      hintStyle: AppConstantTextStyle.formFieldTextStyle(),
    ),

    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppConstantsColor.matteBlack
        )
    ),
  );

}

