import 'dart:developer';

import 'package:customerlist_app/app/data/models/response_data.dart';
import 'package:customerlist_app/app/data/services/network_caller.dart';
import 'package:customerlist_app/app/modules/authentication/login/view/login_view.dart';
import 'package:customerlist_app/util/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static String? token;
  String _errorMessage = '';
  bool _loader = false;

  String get errorMessage => _errorMessage;
  bool get loader => _loader;

  Future<bool> login(email, password) async {
    bool isSuccess = false;
    _loader = true;
    update();
    try {
      final ResponseData response =
          await NetworkCaller().getRequestWithoutToken(
        Urls.sentEmailOtp(email, password),
      );

      if (response.isSuccess && response.responseData["Token"] != null) {
        token = response.responseData["Token"];
        log(token.toString());
        saveToken(token!);
        isSuccess = true;
        update();
        return isSuccess;
      } else {
        _errorMessage = response.errorMessage;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
    return isSuccess;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
  }

  Future<void> initialize() async {
    token = await _getToken();
  }

  Future<bool> isLoggedIn() async {
    await initialize();
    return token != null;
  }

  bool get isTokenNotNull => token != null;

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }

  static Future<void> goToLogin() async {
    Get.to(() => const LoginView());
  }
}
