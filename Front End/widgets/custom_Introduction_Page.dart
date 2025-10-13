import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomIntroductionPage extends StatelessWidget {

 final String backgroundImage;
 final List<Color> gradientColor;
 final String texts;

const CustomIntroductionPage({ 

  super.key,
  required this.backgroundImage,
  required this.gradientColor,
  required this.texts,

});

  @override
  Widget build(BuildContext context){
    return Stack(

      children: [

        Positioned.fill(

          child: Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),

        ),

        Positioned.fill(

          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: gradientColor,
                stops: const [0.6, 1.0],
              ),
            ),
          ),

        ),

        Center(

          child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 30.0),

            child: Text(
              texts,
              textAlign: TextAlign.left,
              style: AppTextStyles.heading,
            ),

          ),

        ),

      ],

    );
    
  }
}

