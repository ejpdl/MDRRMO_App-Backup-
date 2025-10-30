import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTableRow extends StatelessWidget {

  final String location;
  final String date;
  final String time;
  final String status;
  final TextStyle textStyle;
  final bool isHeader;

  const CustomTableRow({

    Key? key,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.textStyle,
    this.isHeader = false,

  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFF0C092B);
      case 'accepted':
        return const Color(0xFFEA4D2E);
      case 'denied':
        return const Color(0xFFBBA9A9);
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String date) {
  try {
    final parsedDate = DateFormat("MMMM d, yyyy").parse(date); 
    
    return DateFormat("MMM d, yyyy").format(parsedDate).toUpperCase(); 
  } catch (e) {
    return date;
  }
}

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final dynamicFontSize = screenWidth * 0.035;

    return Row(

      children: [

        Expanded(

          child: Text(

            location,
            style: textStyle.copyWith(fontSize: dynamicFontSize),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

        ),

        const SizedBox(width: 8.0),

        Expanded(

          child: Text(

            isHeader ? date : _formatDate(date),
            style: textStyle.copyWith(fontSize: dynamicFontSize),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,

          ),

        ),

        const SizedBox(width: 8.0),

        Expanded(

          child: Text(

            time,
            style: textStyle.copyWith(fontSize: dynamicFontSize),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,

          ),

        ),

        const SizedBox(width: 8.0),

        Expanded(

          child: isHeader
              ? Text(
                  status,
                  style: textStyle.copyWith(fontSize: dynamicFontSize),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenWidth * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: dynamicFontSize,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
        ),
      ],
    );
  }
}
