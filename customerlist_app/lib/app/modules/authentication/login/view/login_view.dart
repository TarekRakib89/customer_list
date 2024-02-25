import 'package:customerlist_app/app/modules/authentication/login/controller/auth_controller.dart';
import 'package:customerlist_app/app/modules/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailEController = TextEditingController();
  final TextEditingController _passwordEController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  void dispose() {
    super.dispose();
    _emailEController.dispose();
    _passwordEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email, password and login button
            textFieldAndButtonMethod,
          ],
        ),
      ),
    );
  }

  Widget get textFieldAndButtonMethod {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailEController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your email";
              }
              return null;
            },
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Email",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordEController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your password";
              }
              return null;
            },
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Password",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final bool result = await _authController.login(
                    _emailEController.text.trim(), _passwordEController.text);
                if (result) {
                  Get.to(
                    () => const HomeView(),
                  );
                } else {
                  Get.showSnackbar(GetSnackBar(
                    message: _authController.errorMessage,
                    duration: const Duration(seconds: 2),
                    isDismissible: true,
                  ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
