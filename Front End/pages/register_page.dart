import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_AppBar.dart';
import '../widgets/custom_TextFields.dart';
import '../widgets/custom_Buttons.dart';

import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;


  void _register() async {

    final firstname = _firstnameController.text.trim();
    final lastname = _lastnameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final address = _addressController.text.trim();
    final contact = _contactController.text.trim();

    if (firstname.isEmpty || lastname.isEmpty || address.isEmpty || contact.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

     if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

    final result = await AuthService.register(firstname, lastname, username, password, address, contact);

    if (result == "Registration Successful"){

      Navigator.pushNamed(context, '/login_page');

    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Error')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: true,

      appBar: CustomAppBar(
        text: "Municipal Disaster Risk Reduction \nand Management Office", 
        backgroundImage: const AssetImage("assets/images/Logo.png"),
      ),

      body: Container(

        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(gradient: AppGradientBackground.linearGradient),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Center(

              child: Padding(

                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text("Create Account", style: AppTextStyles.creatAccountTitle),

                    AppHeight(40.0),

                    CustomTextFields(
                      label: "First Name",
                      controller: _firstnameController,
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Last Name",
                      controller: _lastnameController,
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Address",
                      controller: _addressController,
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Contact Number",
                      controller: _contactController,
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Username",
                      controller: _usernameController,
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Password",
                      controller: _passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      togglePassword: () {

                        setState(() {

                          _obscurePassword = !_obscurePassword;

                        });

                      }
                    ),

                    AppHeight(20.0),

                    CustomTextFields(
                      label: "Confirm Password",
                      controller: _confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscureConfirmPassword,
                      togglePassword: () {

                        setState(() {

                          _obscureConfirmPassword = !_obscureConfirmPassword;

                        });

                      }
                    ),
                    
                    AppHeight(50.0),

                    CustomButtons(

                      text: "Sign Up",
                      color: AppColors.defaultColor,
                      backgroundColor: Color(0xFF0C092B),
                      fontSize: 15.0,
                      height: 60.0,
                      onPressed: _register,

                    ),

                  ],

                ),

              ),

            ),

          ),

        ),

      ),
      
    );
  }
}