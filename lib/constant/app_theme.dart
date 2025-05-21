import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color whiteBackgroundColor = const Color(0xffffffff);
  static Color primaryColor = const Color(0xffffffff);
  static Color goldencolor = const Color.fromRGBO(164, 125, 37, 1);
  static Color blackColor = const Color(0xff040415);
  static Color lightTextColor = const Color.fromRGBO(77, 77, 77, 1);
  static Color darkTextColor = const Color.fromRGBO(0, 0, 0, 1);
  static Color backGround = const Color.fromRGBO(243, 242, 238, 1);
  static Color backGround2 = const Color.fromRGBO(241, 242, 246, 1);
  static Color bodyTextColor = const Color.fromRGBO(26, 26, 26, 1);
  static Color buttonBorder = const Color.fromRGBO(38, 130, 255, 1);
  static Color hintTextColor = const Color.fromRGBO(127, 127, 127, 1);
  static Color starColor = const Color.fromRGBO(255, 227, 2, 1);
  static Color whiteTextColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color lightHintTextColor = const Color.fromRGBO(166, 166, 166, 1);
}

class AppTextStyles {
  static  TextStyle headline1 =  GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
    static  TextStyle headline3 =  GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
 static  TextStyle headline2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static  TextStyle bodyText =  GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static  TextStyle lable =  GoogleFonts.montserrat(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: AppTheme.lightHintTextColor,
  );
static  TextStyle hintText =  GoogleFonts.montserrat(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: AppTheme.hintTextColor,
  );
  // Add more styles as needed
}
