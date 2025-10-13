import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/styles.dart';
import '../widgets/custom_Buttons.dart';
import '../widgets/custom_Introduction_Page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({ Key? key }) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {

  final controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> introPages = [

    {

      "image": 'assets/images/Enhanced2.jpg',
      "text": "The MDRRMO of Candelaria, Quezon is responsible for ensuring the safety and resilience of the community by preparing for, responding to, and recovering from natural and man-made disasters.",
      "button": "Procceed" 

    },
    {

      "image": 'assets/images/Enhanced.jpg',
      "text":  "Aims to build a resilient and disaster-ready community through education, preparation, and rapid response. We work hand-in-hand with barangay officials, schools, and volunteers to create safer neighborhoods and minimize risks from natural and human-induced hazards.",
      "button": "I understand" 

    },
    {

      "image": 'assets/images/Enhanced3.jpg',
      "text": '"When danger strikes, we stand prepared, With every risk, the load is shared. MDRRMO leads the way, For a safer town, every day."',
      "button": "Get Started" 

    },

  ];

  void initState() {

    super.initState();
    controller.addListener(() {

      int newPage = controller.page?.round() ?? 0;
      if (newPage != currentIndex) {
        setState(() {
          currentIndex = newPage;
        });
      }

    });
  }

  void _handleButtonPress() {
    if (currentIndex == introPages.length - 1) {
      Navigator.pushNamed(context, '/landing_page');
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {

    controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          PageView.builder(

            controller: controller,
            itemCount: introPages.length,

            itemBuilder: (context, index){

              return CustomIntroductionPage(

                backgroundImage: introPages[index]["image"]!,
                gradientColor: [
                const Color(0xFF0C092B).withOpacity(0.7),
                const Color(0xFF737373).withOpacity(0.7),
                ],

                texts: introPages[index]["text"]!,

              );

            }

          ),

          Container(

            alignment: Alignment(0, 0.65),
            
            child: Padding(

              padding: EdgeInsets.all(20.0),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,

                children: [

                  SmoothPageIndicator(
                    controller: controller,
                    count: introPages.length,
                    effect: WormEffect(
                      spacing: 16.0,
                      dotColor: Color(0xFF595858),
                      activeDotColor: Color(0xFFEA4D2E),
                    ),

                  ),

                  AppHeight(40.0),

                  CustomButtons(

                    text: introPages[currentIndex]["button"]!,
                    backgroundColor: Color(0xFF0C092B),
                    color: Colors.white,
                    fontSize: 18.0,
                    height: 60.0,
                    onPressed: _handleButtonPress,

                  ),

                  AppHeight(30.0),

                ],

              ),

            ),

          ),

        ],

      ),

    );

  }
}