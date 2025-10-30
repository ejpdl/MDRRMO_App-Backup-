import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../widgets/styles.dart';
import '../widgets/custom_Buttons.dart';
import '../widgets/custom_ShowDialog.dart';
import '../widgets/custom_ProfileEdit.dart';

import '../models/CustomInfo.dart';

import '../services/auth_services.dart';

class AccountPage extends StatefulWidget {

const AccountPage({ Key? key }) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  UserModel? user;

  @override
  void initState() {

    super.initState();
    loadUserData();

  }

  Future<void> loadUserData() async {

    final userData = await AuthService.getUserInfo();
    setState(() {

      user = userData;

    });

  } 

  @override
  Widget build(BuildContext context){
    return Center(

      child: Padding(

        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),

        child: user == null
        ? CircularProgressIndicator()
        : Column(

          children: [

            Align(

              alignment: Alignment.centerLeft,

              child: Text(
                "Profile Settings",
                style: AppTextStyles.welcomeTitle,
              ),

            ),

            AppHeight(40.0),

            CustomProfileEdit(

              imagePath: 'assets/images/placeholder.jpg',
              onClicked: () async {

                final image = await ImagePicker().pickImage(source: ImageSource.gallery);

              },
              isEdit: true,
              iconColor: Colors.red,
              circleColor: Color(0xFF0C092B),

            ),

            AppHeight(30.0),

            Center(

              child: Text(
                "${user!.firstname} ${user!.lastname}", 
                style: AppTextStyles.welcomeTitle,
                textAlign: TextAlign.center,
              ),

            ),

            AppHeight(20.0),

            Center(

              child: Text(
                "${user!.address}", 
                style: AppTextStyles.ProfileText,
                textAlign: TextAlign.center,
              ),

            ),
            
            AppHeight(10.0),

            Center(
              
              child: Text(
                "${user!.contact}", 
                style: AppTextStyles.ProfileText,
                textAlign: TextAlign.center,
              ),
            ),

            AppHeight(30.0),

            Wrap(

              spacing: 15.0, 
              runSpacing: 10.0,
              alignment: WrapAlignment.center,

              children: [

                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 160.0),
                  child: CustomButtons(
                  
                    text: "Edit Profile",
                    color: Colors.white,
                    backgroundColor: Color(0xFF0C092B),
                    fontSize: 15.0,
                    height: 50.0,
                    onPressed: () async {
                      final updated = await showEditDialog(context);
                      if(updated == true) {
                        loadUserData();
                      }
                    },
                  
                  ),
                ),

                ConstrainedBox(
                   constraints: BoxConstraints(maxWidth: 160.0),
                  child: CustomOutlinedButtons(
                  
                    text: "Log Out",
                    color: Colors.white,
                    borderColor: Color(0xFF651505),
                    fontSize: 15.0,
                    height: 50.0,
                    onPressed: () async { 
                      await AuthService().logout();
                      Navigator.pushNamed(context, '/login_page'); 
                    },
                  
                  ),
                ),

              ],  

            ),

          ],

        ),

      ),

    );
  }
}