import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomDropDown extends StatelessWidget {

  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final String label;
  final String? value;
  final List<String> options;
  final TextStyle? customValueStyle;
  final TextStyle? customTextStyle;
  final void Function(String?)? onChanged;

const CustomDropDown({ 

  Key? key,
  this.width,
  required this.label,
  required this.value,
  required this.options,
  this.customValueStyle,
  this.customTextStyle,
  this.onChanged,
  this.contentPadding, 

}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(

      width: width ?? double.infinity,

      child: Column(
      
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
      
          if (label.isNotEmpty) ...[
            Text(label, style: customTextStyle ?? AppTextStyles.subheadingTitle),
            AppHeight(10.0),
          ],
      
          DropdownButtonFormField<String>(
      
            dropdownColor: const Color(0xFF1E1E1E),
            value: value,
            isExpanded: true,
            style: customValueStyle ?? const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            
            onChanged: onChanged,
            
      
            decoration: InputDecoration(
      
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              isDense: true,
      
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color(0xFF0C092B),
                  width: 1.5,
                ),
              ),
      
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color(0xFF0C092B),
                  width: 1.5,
                ),
              ),
      
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Color(0xFF040214),
                  width: 2.0,
                ),
              ),
      
            ),
      
            hint: Text(
      
              "Select $label",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
      
            ),
              
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF000000),
              size: 20.0,
            ),
      
            items: options.map((String val) {

              return DropdownMenuItem<String>(

                value: val,
                child: SizedBox(
                  child: Text(
                  
                    val,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                      color: Colors.white
                    ),
                  
                  ),
                ),
                
              );
            }).toList(),
      
          ),
        ],
      
      ),
    );
  }
}