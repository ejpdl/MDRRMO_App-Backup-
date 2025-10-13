import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';


class CustomProfileEdit extends StatefulWidget {

  final String? imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  final Color iconColor;
  final Color circleColor;

const CustomProfileEdit({ 
  
  Key? key,
  this.imagePath,
  required this.onClicked,
  this.isEdit = false,
  required this.iconColor,
  required this.circleColor,
  
}) : super(key: key);

  @override
  State<CustomProfileEdit> createState() => _CustomProfileEditState();
}

class _CustomProfileEditState extends State<CustomProfileEdit> {

  File? _selectedImage;

  Future<void> _pickImage() async {

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      setState(() {

        _selectedImage = File(image.path);

      });
    }

  }

  @override
  Widget build(BuildContext context){

    return Center(

      child: Container(

        decoration: BoxDecoration(

          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, 
            width: 04.0
          ),

          boxShadow: [
            
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(5, 5),
            ),
          
          ],
        ),

        child: Stack(
        
          children: [
            
            buildImage(),
        
            Positioned(
            
              bottom: 0, 
              right: 10, 
              child: buildEditIcon(),
            
            ),
          
          ],
        
        ),
      ),

    );
    
  }

  Widget buildImage() {

    return ClipOval(

      child: Material(

        color: Colors.transparent,

        child: Ink.image(
      
          image: _selectedImage != null
          ? FileImage(_selectedImage!) as ImageProvider
          : (widget.imagePath != null
              ? AssetImage(widget.imagePath!)
              : const AssetImage('assets/images/Logo.png')
            ),
          fit: BoxFit.cover,
          width: 200.0,
          height: 200.0,
          child: InkWell(onTap: _pickImage), 
        
        ),

      ),

      

    );

  }

  Widget buildEditIcon() => buildCircle(

    color: Colors.white,
    all: 3,

    child: buildCircle(
    
      color: widget.circleColor,
      all: 8,
      child: Icon(
    
        widget.isEdit ? Icons.add_a_photo : Icons.edit,
        color: widget.iconColor,
        size: 20.0,
    
      ),
    
    ),
  );

  Widget buildCircle({required Widget child, required double all, required Color color,}) => 
  ClipOval(

    child: Container(
    
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    
    
    ),

  );
  
}


  