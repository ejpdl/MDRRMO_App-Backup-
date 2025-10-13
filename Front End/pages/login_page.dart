import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


import '../widgets/styles.dart';
import '../widgets/custom_AppBar.dart';
import '../widgets/custom_TextFields.dart';
import '../widgets/custom_Buttons.dart';

import '../services/auth_services.dart';

class LogInPage extends StatefulWidget {

  const LogInPage({ Key? key }) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _checkBox = false;

  Future<void> _login() async {

    final user = _usernameController.text.trim();
    final pass = _passwordController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

     final result = await AuthService.login(user, pass);

    if(result == "Login Successful"){

      Navigator.pushNamed(context, '/dashboard_page');

    }else{

      ScaffoldMessenger.of(context).showSnackBar(
      
        SnackBar(content: Text(result ?? 'Error')),

      );

    }

  }

  
  late TapGestureRecognizer _tapRecognizer;

  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/register_page');
      };
  }

  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
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

                padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    // custom_RichText("Welcome Back, ", "Cyrus"),
                    const Text("Welcome", style: AppTextStyles.welcomeTitle),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    const Text("Login to continue,", style: AppTextStyles.subheadingTitle),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    CustomTextFields(
                      label: "Username",
                      controller: _usernameController,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

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

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    Padding(

                      padding: EdgeInsets.only(right: 10.0),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          Flexible(
                            child: Row(
                            
                              mainAxisSize: MainAxisSize.min,
                            
                              children: [
                            
                                Checkbox(
                                  value: _checkBox,
                                  onChanged: (bool? newValue) {
                            
                                    setState(() {
                            
                                      _checkBox = newValue!;
                            
                                    });
                            
                                  },
                            
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  activeColor: Color(0xFF0C092B),
                                  checkColor: Colors.white,
                                ),
                            
                                Flexible(
                                  child: const Text(
                                    "Remember Me",
                                    style: AppTextStyles.regularBoldText,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                            
                              ],
                            
                            ),
                          ),

                          AppWidth(10.0),

                          Flexible(
                            child: const Text(
                              "Forgot Password?",
                              style: AppTextStyles.regularText,
                              textAlign: TextAlign.right,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],

                      ),

                    ),

                    AppHeight(50.0),

                    CustomButtons(

                      text: "Login",
                      color: AppColors.defaultColor,
                      backgroundColor: Color(0xFF0C092B),
                      fontSize: 15.0,
                      height: 60.0,
                      onPressed: _login, 
                      // () {Navigator.pushNamed(context, '/dashboard_page');},//

                    ),

                    AppHeight(10.0),

                    Center(

                      child: Padding(

                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                            ),
                            children: [
                              TextSpan(
                                text: "Do not have an account? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFF0C092B),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: _tapRecognizer,
                              ),
                            ],
                          ),
                        ),

                      ),

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