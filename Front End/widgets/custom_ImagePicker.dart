import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {

  final double? customWidth;
  final double? customHeight;
  final ValueChanged<File?> onImagePicked;

const CustomImagePicker({ 

  Key? key,
  this.customWidth,
  this.customHeight, 
  required this.onImagePicked,

}) : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {

  File? _selectedImage;

  @override
  Widget build(BuildContext context){
    return GestureDetector(

      onTap: () async {
        
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);

        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
          });
          widget.onImagePicked(_selectedImage);
        }
      },

      child: Container(

        width: widget.customWidth ?? 150,
        height: widget.customHeight ?? 55,
        margin: const EdgeInsets.only(top: 10), 

        decoration: BoxDecoration(

          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(0.05),

        ),

        
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            
            _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      _selectedImage!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.upload_file, color: Colors.white),

            const SizedBox(width: 10),

            const Text(

              "Upload Photo",
              style: TextStyle(color: Colors.white),

            ),
            
          ],
        ),
      ),
    );
  }
}

 

