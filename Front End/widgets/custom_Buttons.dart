import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color backgroundColor;
  final double fontSize;
  final double height;
  final double? width;

const CustomButtons({ 

  Key? key,
  required this.text,
  required this.onPressed,
  required this.color,
  required this.backgroundColor,
  required this.fontSize,
  required this.height, 
  this.width,

}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(

      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 7.0,
          backgroundColor: backgroundColor,
          minimumSize: Size(300.0, 50.0),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),

        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),

    );
  }
}

class CustomOutlinedButtons extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final double height;
  final double? width;
  final Color? borderColor;

const CustomOutlinedButtons({ 

  Key? key,
  required this.text,
  required this.onPressed,
  required this.color,
  required this.fontSize,
  required this.height,
  this.width,
  this.borderColor, 
  
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(

      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(

        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 7.0,
          minimumSize: Size(300.0, 50.0),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(
            color: borderColor ?? Color(0xFF0C092B),
            width: 2,
          ),
        ),

        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),

    );
  }
}