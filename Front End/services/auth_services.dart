import 'dart:io'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/CustomInfo.dart';

class AuthService {

  // adb reverse tcp:3000 tcp:3000 (To Run The Server in the Mobile App)
  static const baseUrl = 'http://127.0.0.1:3000';

  static Future<String?> login(String username, String password) async {

    final res = await http.post(

      Uri.parse('$baseUrl/user/login'),
      headers: { 'Content-Type' : 'application/json' },
      body: jsonEncode({ 'username' : username, 'password' : password }),

    );

    final data = jsonDecode(res.body);

    if(res.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', data['token']);
      return "Login Successful";

    }else{

      return data['error'] ?? 'Login Error';

    }

  }

  static Future<String> register(String firstname, String lastname, String username, String password, String address, String contact) async {

    final res = await http.post(

      Uri.parse("$baseUrl/user/register"),
      headers: { 'Content-Type' : 'application/json' },
      body: jsonEncode({ 

        'firstname' : firstname, 
        'lastname' : lastname, 
        'username' : username, 
        'password' : password, 
        'address' : address, 
        'contact' : contact

      }),
      
    );

    final data = jsonDecode(res.body);

    if(res.statusCode == 200){

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', data['token']);
      return "Registration Successful";

    }else{

      return data['error'] ?? 'Registration Error';

    }

  }

  static Future<UserModel?> getUserInfo() async {

    final token = await getToken();

    final res = await http.get(

      Uri.parse("$baseUrl/user/profile"),
      headers: {

        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token',

      },

    );

    if(res.statusCode == 200){

      final data = jsonDecode(res.body);
      return UserModel.fromJson(data);

    }else{

      return null;

    }

  }

  static Future<String> updateUserInfo(String firstname, String lastname, String address, String contact) async {

    final token = await getToken();
    final res = await http.put(

      Uri.parse("$baseUrl/user/profile/edit"),
      headers: { 
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
      body: jsonEncode({

        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'contact': contact,

      }),

    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return "Update Successful";
    } else {
      return data['error'] ?? 'Update failed';
    }

  }

  static Future<String> submitReport({

    required String region,
    required String city,
    required String district,
    required String street,
    required String accident,
    // required String houseNo,
    // required String month,
    // required String day,
    // required String year,
    // required String hour,
    // required String minute,
    // required String ampm,
    File? photo,

  }) async {

    final token = await getToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/report/submit'),
    );

    // Headers with JWT
    request.headers['Authorization'] = 'Bearer $token';

    // Add text fields
    request.fields['region'] = region;
    request.fields['city'] = city;
    request.fields['district'] = district;
    request.fields['street'] = street;
    request.fields['type_of_accident'] = accident;
    // request.fields['house_no'] = houseNo;
    // request.fields['month'] = month;
    // request.fields['day'] = day;
    // request.fields['year'] = year;
    // request.fields['hour'] = hour;
    // request.fields['minute'] = minute;
    // request.fields['ampm'] = ampm;

    // Add photo if available
    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', photo.path));
    }

    // Send request
    final res = await request.send();
    final body = await res.stream.bytesToString();

    if (res.statusCode == 201) {
      return "Report submitted successfully!";
    } else {
      final data = jsonDecode(body);
      return data['error'] ?? "Error submitting report";
    }
  }


  static Future<List<ReportLogs>> getReports({String? sort, String? search}) async {

    final token = await getToken();

    Uri uri = Uri.parse("$baseUrl/report/logs");
    Map<String, String> params = {};
    
    if (sort != null && sort.isNotEmpty) params['sort'] = sort;
    if (search != null && search.isNotEmpty) params['search'] = search;

    if (params.isNotEmpty) {
      uri = uri.replace(queryParameters: params);
    }

    final response = await http.get(
      uri,
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        List data = jsonDecode(response.body);
        return data.map((json) => ReportLogs.fromJson(json)).toList();
      } catch (e) {
        print("JSON DECODE ERROR: $e");
        throw Exception("Failed to parse reports");
      }
    } else {
      throw Exception("Failed to load reports (code: ${response.statusCode})");
    }

  }

  static Future<String?> getToken() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');

  }

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    
  }

}


class ContactService {

  static const baseUrl = 'http://127.0.0.1:3000';

  static Future<List<ContactInfo>> getAllContacts() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    final res = await http.get(

      Uri.parse("$baseUrl/viewAll/contacts"),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
    );

    if(res.statusCode == 200){

      final List<dynamic> data = jsonDecode(res.body);

      return data.map((item) => ContactInfo.fromJson(item)).toList();

    }else{

      throw Exception('Failed to fetch contacts');

    }

  }

}



// Different use of tokens

// Save Token After login
// Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('jwt_token', token);
// }

// In Authenticated Request
// Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('jwt_token');
// }

// For API Request
// Future<void> getUserData() async {
//   final token = await getToken();
//   final response = await http.get(
//     Uri.parse('http://your-ip:3000/user/protected-endpoint'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     // Successfully retrieved data
//   } else {
//     // Token expired or invalid
//   }
// }

// Clear When Log out
// Future<void> logout() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.remove('jwt_token');
// }