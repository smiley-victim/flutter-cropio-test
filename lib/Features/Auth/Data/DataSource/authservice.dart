import 'dart:convert';
import 'dart:developer';
// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  Future<void> login(String email, String password);
  Future<void> register(String name, String email, String password);
  // Future<Session> anonymousLogin();
  //Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> verifyEmail(String email);
  // Stream<Session> getUser();
}

class AuthServiceImpl implements AuthService {
  final String baseUrl = 'https://beta-api.cropio.in';
  //final Account account = servicelocator.get<Account>();

  @override
  Future<String> login(String email, String password) async {
    log(email);
    log(password);
    try {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login/'));

    // Adding fields as form-data
    request.fields['email'] = email;
    request.fields['password'] = password;

    // Sending the request
      var response = await request.send();
      log("${response.statusCode}");

      if (response.statusCode == 200) {
        debugPrint('Login successful');
        return "Login Successfully";
      } else {
        debugPrint('Login failed: ${response.statusCode}');
        Map<String,dynamic> messageMap=jsonDecode(await response.stream.bytesToString());
        return messageMap["error"] ?? messageMap["non_field_errors"][0];
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      return e.toString();
    }
  }



  // @override
  // Future<void> logout() {
  //   return account.deleteSession(sessionId: 'current');
  // }

  @override
  Future<String> register(String name, String email, String password) async {
    log(email);
    log(password);
    log(name);
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': name,
          'email': email,
          'password': password,
        }),
      );
      log("${response.statusCode}");
        Map<String,dynamic> messageMap=jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('User registered successfully: ${response.body}');
        return messageMap["message"];
      } else {
        debugPrint('Registration failed: ${response.body}');
        return messageMap["email"][0];
      }
    } catch (e) {
      debugPrint('Error during registration: $e');
      return e.toString();
    }
  }

  // @override
  // Stream<Session> getUser() {
  //   return servicelocator
  //       .get<Account>()
  //       .getSession(sessionId: 'current')
  //       .asStream();
  // }

  @override
  Future<String> forgotPassword(String email) async {
    log(email);

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/forgot-password/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );
      log("${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Password Change Email has been sent');
        Map<String,dynamic> messageMap=jsonDecode(response.body);
        return messageMap["message"];
      } else {
        debugPrint('Password change process has been failed ${response.body}');
        return 'Password change process has been failed ${response.body}';
      }
    } catch (e) {
      debugPrint('Error during Password Change: $e');
      return e.toString();
    }
  }

  @override
  Future<void> verifyEmail(String email) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer i'
    };
    var request = http.Request(
        'POST', Uri.parse('https://beta-api.cropio.in/verify-email/'));
    request.body = '''https:''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  // @override
  // Future<Session> anonymousLogin() {
  //   // TODO: implement anonymousLogin
  //   throw UnimplementedError();
  // }
}
