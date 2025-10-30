import 'package:flutter/material.dart';


class AppGradientBackground {

  static const linearGradient = LinearGradient(

    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
    Color(0xB30C092B),
    Color(0xB3737373),
    ],
    stops: [0.6, 1.0],

  );

}

class AppColors {

  static const title = Color(0xFFEA4D2E);
  static const defaultColor = Colors.white;
  static const heading = Color(0xFF455A64);
  static const subheading = Color(0xFF0C092B);

}

class AppTextStyles {

  static const heading = TextStyle(

    color: AppColors.title,
    fontSize: 25.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const appBarTitle = TextStyle(

    color: AppColors.defaultColor,     
    fontSize: 20.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const welcomeTitle = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 25.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const welcomeSubTitle = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 15.0,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,

  );

  static const subheadingTitle = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 15.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const appBarTitle2 = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 17.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const regularText = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 15.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

  static const ProfileText = TextStyle(

    color: Color(0x88FFFFFF),
    fontSize: 15.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

  static const regularBoldText = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 15.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const creatAccountTitle = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 30.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,

  );

  static const navbarLabel = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 10.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

  static const aboutParagraph = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 12.0,
    height: 2.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

  static const regular20 = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 20.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

  static const logsText = TextStyle(

    color: AppColors.defaultColor,
    fontSize: 12.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,

  );

}

Widget custom_RichText(String title, String subtitle) {

  return RichText(

    text: TextSpan(

      style: AppTextStyles.welcomeTitle,

      children: [

        TextSpan(
          text: title,
          style: TextStyle(color: AppColors.defaultColor) 
        ),

        TextSpan(
          text: subtitle,
          style: TextStyle(color: AppColors.subheading) 
        ),

      ],

    ),

  );

}


Widget AppWidth(double width) {

  return SizedBox(width: width);

}

Widget AppHeight(double height) {

  return SizedBox(height: height);

}
