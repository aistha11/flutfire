import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutfire/getx_app/models/dbUser.dart';
import 'package:flutfire/getx_app/services/firebaseService.dart';
import 'package:flutfire/getx_app/utilities/utils.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  Rx<DbUser> dbUser = Rx<DbUser>(
    DbUser(
      name: "No Name",
      username: "nomail",
      number: null,
      profilePhoto: "",
      email: "nomail@gmail.com",
    ),
  );

  getDbUser(String username)async{
    dbUser.bindStream(FirebaseService.streamDbUserById(username));
    // dbUser.value = await FirebaseService.getDbUserById(username);
    print("DbUser: ${dbUser.value.name}");
    update();
  }

  @override
  void onInit() {
    String username = Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    getDbUser(username);
    super.onInit();
  }
}