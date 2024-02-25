import 'package:customerlist_app/app/modules/splash/view/splash_view.dart';
import 'package:customerlist_app/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.light(
                  background: Colors.grey.shade50,
                  primary: Colors.grey.shade500,
                  secondary: Colors.blue.shade50,
                  tertiary: Colors.white,
                  inversePrimary: Colors.grey.shade900,
                ),
                scaffoldBackgroundColor: Colors.white,
              ),
              home: const SplashView(),
              initialBinding: ControllerBinder());
        });
  }
}
