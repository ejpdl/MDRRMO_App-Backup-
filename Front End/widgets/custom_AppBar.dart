import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String text;
  final ImageProvider backgroundImage;
  final Widget? leading;

const CustomAppBar({ 

  Key? key,
  required this.text,
  required this.backgroundImage,
  this.leading

}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AppBar(

      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 125.0,
      title: Row(

        children: [

          leading ??
            CircleAvatar(
              backgroundImage: backgroundImage,
              radius: 25.0,
            ),

          SizedBox(width: 10.0),

          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: AppTextStyles.appBarTitle2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),

        ],

      ),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(125.0);

}