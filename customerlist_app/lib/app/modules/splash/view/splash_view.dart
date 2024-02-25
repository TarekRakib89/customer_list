import 'package:customerlist_app/app/modules/authentication/login/controller/auth_controller.dart';
import 'package:customerlist_app/app/modules/authentication/login/view/login_view.dart';
import 'package:customerlist_app/app/modules/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthController authController = Get.find<AuthController>();
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    await Get.find<AuthController>().initialize();
    if (authController.isTokenNotNull) {
      Get.offAll(const HomeView());
    } else {
      Get.offAll(const LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
