import 'package:flutfire/getx_app/constants/userState.dart';
import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutfire/getx_app/pages/home/home_view.dart';
import 'package:flutfire/getx_app/pages/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/home_view.dart';

class Wrapper extends GetView<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return HomeView();
      } else {
        return AuthView(); 
      }
    });
  }
}
