import 'package:flutter/material.dart';

import '../widgets/styles.dart';

class CustomSearchBar extends StatelessWidget {

  final String hintText;
  final ValueChanged<String>? onChanged;

const CustomSearchBar({ 
  
  Key? key,
  required this.hintText,
  this.onChanged,

}) : super(key: key);

  @override
  Widget build(BuildContext context){
  
      return SizedBox(

        height: 50.0,

        child: TextField(
        
          onChanged: onChanged,
          decoration: InputDecoration(
        
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            prefixIcon: const Icon(Icons.search, color: Colors.white, size: 20.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
        
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
        
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),

          ),
        
        ),
    );
  }
}