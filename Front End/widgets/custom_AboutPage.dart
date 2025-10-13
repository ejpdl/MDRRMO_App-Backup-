import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomAboutPage extends StatelessWidget {

  final String title;
  final String imagePath;
  final List<String> bullets;
  final String paragraph;

const CustomAboutPage({ 
  
  Key? key,
  required this.title,
  required this.imagePath,
  required this.bullets,
  required this.paragraph,

}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(

      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [

            CircleAvatar(

              backgroundImage: AssetImage(imagePath),
              radius: 25.0,
              backgroundColor: Colors.transparent,

            ),

            AppWidth(10.0),

            Expanded(child: Text(title, overflow: TextOverflow.visible, softWrap: true, maxLines: 2, style: AppTextStyles.welcomeTitle)),

          ],

        ),

        AppHeight(10.0),

        ...bullets.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text("> $item", style: AppTextStyles.aboutParagraph, softWrap: true,),
        )),

        Text(paragraph, textAlign: TextAlign.justify, style: AppTextStyles.aboutParagraph, softWrap: true),

        AppHeight(30.0),

      ],

    );
  }
}