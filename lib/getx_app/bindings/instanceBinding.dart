import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:get/get.dart';

class InstanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
  }
}
