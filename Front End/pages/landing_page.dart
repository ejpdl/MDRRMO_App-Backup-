import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_Buttons.dart';

class LandingPage extends StatelessWidget {
const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      extendBody: true,

      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 125.0,
        centerTitle: true,
        title: SizedBox(

          width: MediaQuery.of(context).size.width * 0.9,

          child: const Text(
          
            "Municipal Disaster Risk Reduction \nand Management Office",
          
            textAlign: TextAlign.center,
            style: AppTextStyles.appBarTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, 
          
          ),
        ),

      ),

      body: Container(

        decoration: BoxDecoration(
          gradient: AppGradientBackground.linearGradient,
        ),

        child: Center(

          child: Padding(

            padding: EdgeInsets.fromLTRB(16.0, 190.0, 16.0, 16.0), 

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Image.asset(
                  'assets/images/Logo.png',
                  width: 240,
                  height: 240,
                  fit: BoxFit.contain,
                ),

                AppHeight(40.0),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    "Hello, Welcome",
                    style: AppTextStyles.welcomeTitle,
                  ),
                ),

                AppHeight(15.0),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const Text(
                    "Preparedness Today, Safety Tomorrow",
                    style: AppTextStyles.welcomeSubTitle,
                  ),
                ),

                AppHeight(70.0),

                CustomButtons(
                  text: "Log In",
                  backgroundColor: Color(0xFF0C092B),
                  color: AppColors.defaultColor,
                  fontSize: 17.0,
                  height: 60.0,
                  width: 320.0,
                  onPressed: (){
                    Navigator.pushNamed(context, '/login_page');
                  },
                ),

                AppHeight(20.0),

                CustomOutlinedButtons(
                  text: "Register",
                  color: AppColors.defaultColor,
                  fontSize: 17.0,
                  height: 60.0,
                  width: 320.0,
                  onPressed: (){
                    Navigator.pushNamed(context, '/register_page');
                  },
                ),

              ],

            ),


          ),

        ),

      ),
    );
  }
}