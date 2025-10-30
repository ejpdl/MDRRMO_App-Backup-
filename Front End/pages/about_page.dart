import 'package:flutter/material.dart';

import '../widgets/custom_AboutPage.dart';

class AboutPage extends StatelessWidget {
const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(

      child: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 02.0),

        child: SingleChildScrollView(
          
          child: Column(
          
            children: [
          
              CustomAboutPage(
                
                title: "Purpose of the App",
                imagePath: "assets/icons/octicon--goal-16.png",
                bullets: [
          
                  "Disseminate real-time alerts and advisories during emergencies such as typhoons, floods, earthquakes, fires, and other accidents.",
          
                  "Enable easy access to emergency contact numbers, monitoring of reports, and detailed reportings.",
          
                  "Serve as a tool for reporting incidents or hazards within the municipality.",
          
                ],
                paragraph:
                 "Through this platform, MDRRMO empowers the community to respond effectively and safely during disasters, ensuring a well-informed and disaster-resilient Candelaria.",
              
              ),
          
              CustomAboutPage(
          
                title: "Data Privacy Notice",
                imagePath: "assets/icons/material-symbols--privacy-tip-rounded.png",
                bullets: [
          
                  "This app collects minimal personal information only when necessary, such as when submitting incident reports or enabling location-based alerts.",
          
                  "All data gathered is handled in accordance with the Data Privacy Act of 2012 (Republic Act No. 10173).",
          
                  "Any information shared through the app is used solely for public safety and emergency response purposes.",
                
                ],
                paragraph:
                 "MDRRMO ensures that your data will not be sold, shared, or misused under any circumstances.",
              
              ),
          
            ],
          
          ),
        ),

      ),

    );
  }
}