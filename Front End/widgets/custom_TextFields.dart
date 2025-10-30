import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomTextFields extends StatelessWidget {

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final Color? borderColor;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? togglePassword;

const CustomTextFields({ 
  
  super.key,
  required this.label,
  required this.controller,
  this.hintText,
  this.borderColor,
  this.isPassword = false,
  this.obscureText = false,
  this.togglePassword,

});

  @override
  Widget build(BuildContext context){
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: AppTextStyles.appBarTitle2,
        ),

        AppHeight(08.0),

        TextField(

          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.regularText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            hintText: hintText ?? 'Enter your $label',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontFamily: 'Inter',
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? Color(0xFF0C092B),
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? Color(0xFF050316),
                width: 2.0,
              ),
            ),

            suffixIcon: isPassword
            ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_sharp : Icons.visibility_sharp, color: Colors.grey,
              ),
              onPressed: togglePassword,
            )
            : null,

          ),

        ),

      ],

    );
  }
}