import 'package:flutter/material.dart';

class ContactInfo {

  final String title;
  final String hotline;
  final String landline;
  final String mobile;
  final String? imagePath;
  final Color? cardColor;
  final Color? titleColor;
  final bool alignRight;

  const ContactInfo({

    required this.title,
    required this.hotline,
    required this.landline,
    required this.mobile,
    this.imagePath,
    this.cardColor,
    this.titleColor,
    this.alignRight = false,

  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {

    return ContactInfo(

      title: json['office_name'] ?? 'Unknown',
      hotline: json['hotline'] ?? '/not required',
      landline: json['landline'] ?? '/not required',
      mobile: json['phone_number'] ?? '/not required',
      imagePath: "../assets/images/Logo.png",

    );

  }

}

class UserModel {

  final String firstname;
  final String lastname;
  final String address;
  final String contact;

  UserModel({ 
    
    required this.firstname, 
    required this.lastname,
    required this.address, 
    required this.contact
  
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(

      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      contact: json['contact'],

    );

  }

}

class ReportLogs {

  final String location;
  final String date;
  final String time;
  final String status;

  ReportLogs({

    required this.location,
    required this.date,
    required this.time,
    required this.status,

  });

  factory ReportLogs.fromJson(Map<String, dynamic> json) {

    return ReportLogs(

      location: json['location'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',

    );

  }

}