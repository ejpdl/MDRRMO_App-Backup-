import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_TextFields.dart';

import '../services/auth_services.dart';

Future<bool?> showEditDialog(BuildContext context) async {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();

  final currentUser = await AuthService.getUserInfo();

  if(currentUser != null) {

    _firstNameController.text = currentUser.firstname ?? '';
    _lastNameController.text = currentUser.lastname ?? '';
    _addressController.text = currentUser.address ?? '';
    _contactController.text = currentUser.contact ?? '';


  }

  Future<void> _updateProfile() async {

    final first = _firstNameController.text.trim();
    final last = _lastNameController.text.trim();
    final address = _addressController.text.trim();
    final contact = _contactController.text.trim();

    final result = await AuthService.updateUserInfo(first, last, address, contact);

    if (result == "Update Successful") {
      Navigator.of(context).pop(true); 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }

  }

  return showDialog<bool>(

    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {

      return LayoutBuilder(

        builder: (context, constraints) {

          return AlertDialog(

            backgroundColor: const Color(0xFF0C092B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: SingleChildScrollView(

              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),

              child: ConstrainedBox(

                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight * 0.9,
                  maxWidth: constraints.maxWidth * 0.85,
                ),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    AppHeight(15.0),

                    Text(
                      "Edit Profile",
                      textAlign: TextAlign.left,
                      style: AppTextStyles.appBarTitle2,
                    ),

                    AppHeight(15.0),

                    CustomTextFields(
                      controller: _firstNameController,
                      label: "First Name",
                      borderColor: Colors.white,
                    ),

                    AppHeight(15.0),

                    CustomTextFields(
                      controller: _lastNameController,
                      label: "Last Name",
                      borderColor: Colors.white,
                    ),

                    AppHeight(15.0),

                    CustomTextFields(
                      controller: _addressController,
                      label: "Address",
                      borderColor: Colors.white,
                    ),

                    AppHeight(15.0),

                    CustomTextFields(
                      controller: _contactController,
                      label: "Contact Number",
                      borderColor: Colors.white,
                    ),

                    AppHeight(25.0),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel", style: AppTextStyles.regularBoldText),
                        ),

                        AppWidth(10.0),

                        ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEA4D2E),
                          ),
                          child: const Text("Save", style: AppTextStyles.regularBoldText),
                        ),

                      ],
                      
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
