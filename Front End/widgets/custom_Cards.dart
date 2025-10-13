import 'package:flutter/material.dart';

import '../models/CustomInfo.dart';
class CustomCards extends StatelessWidget {
  final ContactInfo info;
  final double? width;
  final double? height;

  const CustomCards({Key? key, required this.info, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 170.0,
      height: height ?? 180.0,
      decoration: BoxDecoration(
        color: info.cardColor,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: info.alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: info.alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: info.alignRight
                ? [
                    Text(info.title,
                        style: TextStyle(
                          color: info.titleColor,
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(width: 10.0),
                    Image.asset(info.imagePath ?? 'assets/images/Logo.png', width: 28.0, height: 28.0),
                  ]
                : [
                    Image.asset(info.imagePath ?? 'assets/images/Logo.png', width: 28.0, height: 28.0),
                    const SizedBox(width: 10.0),
                    Text(info.title,
                        style: TextStyle(
                          color: info.titleColor,
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
          ),
          const SizedBox(height: 8.0),

          if (info.hotline != "/not required")
            contactRow(Icons.call, info.hotline, alignRight: info.alignRight),
          if (info.landline != "/not required")
            contactRow(Icons.phone_in_talk, info.landline, alignRight: info.alignRight),
          if (info.mobile != "/not required")
            contactRow(Icons.smartphone, info.mobile, alignRight: info.alignRight),
        ],
      ),
    );
  }

  Widget contactRow(IconData icon, String text, {required bool alignRight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: alignRight
            ? [
                Text(text, style: _textStyle()),
                const SizedBox(width: 6.0),
                Icon(icon, color: Colors.white, size: 22.0),
              ]
            : [
                Icon(icon, color: Colors.white, size: 22.0),
                const SizedBox(width: 6.0),
                Text(text, style: _textStyle()),
              ],
      ),
    );
  }

  TextStyle _textStyle() => const TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      );
}
