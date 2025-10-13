import 'package:flutter/material.dart';

import '../pages/introduction_page.dart';
import '../pages/landing_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/contacts_page.dart';
import '../pages/account_page.dart';
import '../pages/about_page.dart';
import '../pages/report_page.dart';
import '../pages/logs_page.dart';

void main() => runApp(MaterialApp(

  debugShowCheckedModeBanner: false,

  initialRoute: '/',

  routes: {

    '/': (context) => const IntroductionPage(),
    '/landing_page': (context) => const LandingPage(),
    '/login_page': (context) => const LogInPage(),
    '/register_page': (context) => const RegisterPage(),
    '/dashboard_page': (context) => const DashboardPage(),
    '/contacts_page': (context) => const ContactsPage(),
    '/account_page': (context) => const AccountPage(),
    '/about_page': (context) => const AboutPage(),
    '/report_page': (context) => const ReportPage(),
    '/logs_page': (context) => const LogsPage(),


  },

));