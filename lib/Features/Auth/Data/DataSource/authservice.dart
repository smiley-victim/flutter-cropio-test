import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/Core/Get_it/get_it.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  Future<void> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> anonymousLogin();
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> verifyEmail(String email);
  Stream<void> getUser();
}

class AuthServiceImpl implements AuthService {


  @override
  Future<void> login(String email, String password) async {}



  @override
  Future<void> register(String name, String email, String password) async {
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://back.hk4crprasad.co/auth/signup'));
    request.fields
        .addAll({'username': name, 'email': email, 'password': password});
    request.files.add(await http.MultipartFile.fromPath('profile_image',
        'postman-cloud:///1ef732c0-409c-4880-8de2-35301d2e7dc0'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  

  @override
  Future<void> forgotPassword(String email) async {}

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
  
  @override
  Future<void> anonymousLogin() {
    // TODO: implement anonymousLogin
    throw UnimplementedError();
  }
  
  @override
  Stream<void> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  
}
