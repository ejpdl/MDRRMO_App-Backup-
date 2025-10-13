import 'package:flutter/material.dart';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import '../widgets/styles.dart';
import '../widgets/custom_AppBar.dart';
import '../widgets/custom_Buttons.dart';

import '../pages/contacts_page.dart';
import '../pages/account_page.dart';
import '../pages/about_page.dart';
import '../pages/logs_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 2;

  final List<Widget> _pages = [
    
    ContactsPage(),
    LogsPage(),
    DashboardHome(), 
    AccountPage(),
    AboutPage(),
    
  ];

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

        child: SafeArea(child: _pages[_selectedIndex]),
        
      ),


      bottomNavigationBar: SizedBox(
        
        child: CurvedNavigationBar(
          index: _selectedIndex,
          backgroundColor: Colors.transparent,
          color: Color(0xFF0C092B),
          animationDuration: Duration(milliseconds: 300),
          items: [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.call,
                color: AppColors.defaultColor,
              ),
              label: 'Contacts',
              labelStyle: AppTextStyles.navbarLabel,
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.description,
                color: AppColors.defaultColor,
              ),
              label: 'Logs',
              labelStyle: AppTextStyles.navbarLabel,
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home_filled,
                color: AppColors.defaultColor,
              ),
              label: 'Home',
              labelStyle: AppTextStyles.navbarLabel,
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.account_circle,
                color: AppColors.defaultColor,
              ),
              label: 'Account',
              labelStyle: AppTextStyles.navbarLabel,
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.info_rounded,
                color: AppColors.defaultColor,
              ),
              label: 'About',
              labelStyle: AppTextStyles.navbarLabel,
            ),
          ],
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),

    );
  }
}

class DashboardHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Center(

      child: Padding(

        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        
        child: Column(

          children: [

            Container(

              alignment: Alignment.center,

              width: 270,
              height: 270,

              decoration: BoxDecoration(

                shape: BoxShape.circle,
                color: Color(0xFF0C092B),
                border: Border.all(
                  color: Colors.white, 
                  width: 08.0
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

              child: Text(
                "Get Help!",
                textAlign: TextAlign.center,
                style: TextStyle(

                  color: Color(0xFFEA4D2E),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 40.0,

                ),
              ),

            ),

            AppHeight(50.0),

            CustomButtons(
              text: "Report an Incident",
              onPressed: () {
                Navigator.pushNamed(context, '/report_page');
              },
              backgroundColor: Color(0xFFEA4D2E),
              fontSize: 15.0,
              height: 60.0,
              width: 200.0,
              color: AppColors.defaultColor,
            ),

            AppHeight(50.0),

          ],

        ),

      ),

    );

  }

}