import 'dart:io'; 
import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_AppBar.dart';
import '../widgets/custom_DropDown.dart';
import '../widgets/custom_ImagePicker.dart';
import '../widgets/custom_TextFields.dart';
import '../widgets/custom_Buttons.dart';

import '../services/auth_services.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({ Key? key }) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  File? _pickedImage;

  String? selectedDistrict;

  String? selectedTypeOfAccident;

  // String? selectedMonth;
  // String? selectedDay;
  // String? selectedYear;
  
  // String? selectedHour;
  // String? selectedMinute;
  // String? selectedAm_Pm;

  final streetController = TextEditingController();
  final houseController = TextEditingController();

  File? pickedImage;

  final List<String> districtOptions = [

    "Poblacion",
    "Buenavista East", 
    "Buenavista West", 
    "Bukal Norte", 
    "Bukal Sur", 
    "Kinatihan I", 
    "Kinatihan II", 
    "Malabanban Norte", 
    "Malabanban Sur", 
    "Mangilag Norte", 
    "Mangilag Sur", 
    "Masalukot I", 
    "Masalukot II", 
    "Masalukot III", 
    "Masalukot IV", 
    "Masalukot V", 
    "Masin Norte", 
    "Masin Sur", 
    "Mayabobo", 
    "Pahinga Norte", 
    "Pahinga Sur", 
    "San Andres", 
    "San Isidro", 
    "Sta. Catalina Norte", 
    "Sta. Catalina Sur", 

  ];

  final List<String> accidentOptions = [

    "Motorcycle Accident",
    "Pedestrian Accident",
    "Four Wheels Accident",
    "Earthquake Accident",
    "Flood Accident",
    "Fire Accident",

  ];

  // final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  // final days = List.generate(31, (i) => '${i + 1}');

  // final List<String> years = ['2021', '2022', '2023', '2024', '2025'];

  // final hours = List.generate(12, (i) => '${i + 1}');
  // final minutes = List.generate(59, (i) => '${i + 1}');

  // final List<String> am_pm = ['AM', 'PM'];


  Future<void> _submitReport() async {

    final district = selectedDistrict;
    final accident = selectedTypeOfAccident;

    // final month = selectedMonth;
    // final day = selectedDay;
    // final year = selectedYear;
    // final hour = selectedHour;
    // final minute = selectedMinute;
    // final ampm = selectedAm_Pm;

    final street = streetController.text.trim();

    // final houseNo = houseController.text.trim();

    if (district == null || accident == null || street.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    final result = await AuthService.submitReport(
      region: "Quezon",          
      city: "Candelaria",
      district: district,
      street: street,
      accident: accident,
      // houseNo: houseNo,
      // month: month,
      // day: day,
      // year: year,
      // hour: hour,
      // minute: minute,
      // ampm: ampm,
      photo: _pickedImage,
      
    );

    if (result == "Report submitted successfully!") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your report has been submitted.")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }

  }

  Future<void> _showConfirmationDialog() async {

  final bool? confirm = await showDialog<bool>(

    context: context,
    barrierDismissible: false,

    builder:(BuildContext context){

      return AlertDialog(

        backgroundColor: const Color(0xFF0C092B),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),

        content: SingleChildScrollView(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              AppHeight(15.0),

              const Text(

                "Confirmation",
                style: AppTextStyles.appBarTitle2,
                textAlign: TextAlign.center,

              ),

              AppHeight(15.0),

              const Text(

                "By proceeding, you hereby confirm that all information you entered is true and accurate to the best of your knowledge.",
                style: AppTextStyles.regularText,
                textAlign: TextAlign.center,

              ),

              AppHeight(25.0),

              Row(

                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                 
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      "Go Back",
                      style: AppTextStyles.regularBoldText,
                    ),
                  ),

                  AppHeight(10.0),

                  ElevatedButton(

                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA4D2E),
                    ),

                    child: const Text(
                      "Proceed",
                      style: AppTextStyles.regularBoldText,
                    ),

                  ),

                ],

              ),

            ],

          ),

        ),

      );

    },

  );


  if(confirm == true){

    _submitReport();

  }
  
}




  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: true,

      appBar: CustomAppBar(
        text: "Municipal Disaster Risk Reduction \nand Management Office", 
        backgroundImage: const AssetImage("assets/images/Logo.png"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {Navigator.pop(context);},
        ),
      ),

      body: Container(

        decoration: BoxDecoration(gradient: AppGradientBackground.linearGradient),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Center(
            
              child: Padding(

                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    
                    Align(

                      alignment: Alignment.centerLeft,

                      child: Text("Report an Incident", style: AppTextStyles.welcomeTitle),

                    ),

                    AppHeight(30.0),

                    Align(

                      alignment: Alignment.centerLeft,
                      child: Text("Where it happened?", style: AppTextStyles.regular20),

                    ),

                    AppHeight(40.0),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Upload Photo",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            CustomImagePicker(
                              customHeight: 48.0,
                              onImagePicked: (file) {
                                _pickedImage = file; 
                              },
                            ),

                          ],

                        ),

                        AppWidth(10.0),

                        Expanded(
                          child: CustomDropDown(
                            width: 160.0,
                            label: "Region",
                            value: "Quezon",
                            options: const ["Quezon"],
                            onChanged: null,
                          ),
                        ),

                      ],

                    ),

                    AppHeight(30.0),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Expanded(
                          child: CustomDropDown(
                            width: 160.0,
                            label: "City",
                            value: "Candelaria",
                            options: const ["Candelaria"],
                            onChanged: null,
                          ),
                        ),

                        AppWidth(10.0),

                        Expanded(
                          child: CustomDropDown(
                            width: 160.0,
                            label: "District/Brgy.",
                            value: selectedDistrict,
                            options: districtOptions,
                            onChanged: (val) => setState(() => selectedDistrict = val),
                          ),
                        ),

                      ],

                    ),

                    AppHeight(30.0),

                    CustomTextFields(

                      label: "Street",
                      hintText: "#35 Sitio Showlook",
                      controller: streetController,
                      
                    ),

                    AppHeight(30.0),

                    CustomDropDown(
                        
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        label: "Type of Accident",
                        value: selectedTypeOfAccident,
                        options: accidentOptions,
                        onChanged: (val) => setState(() => selectedTypeOfAccident = val),
                        
                    ),


                    AppHeight(50.0),

                    CustomButtons(
                      text: "Submit Report",
                      backgroundColor: AppColors.subheading,
                      fontSize: 15.0,
                      color: AppColors.defaultColor,
                      height: 60.0,
                      onPressed: _showConfirmationDialog,
                      // _submitReport
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