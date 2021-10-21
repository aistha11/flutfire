import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutfire/getx_app/pages/auth/auth_controller.dart';
import 'package:flutfire/getx_app/pages/auth/signIn_view.dart';
import 'package:flutfire/getx_app/pages/auth/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends GetView<FirebaseAuthController> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.isSignIn.value
          ? SignInView(
              handleSignIn: (email, password) async {
                await controller.signIn(email, password);
              },
            )
          : SignupView(
              handleSignUp: (name, email, password) async {
                await controller.signUp(name, email, password);
              },
            ),
    );
  }
}
