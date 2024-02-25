import 'package:customerlist_app/app/modules/authentication/login/controller/auth_controller.dart';
import 'package:customerlist_app/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
  }
}
