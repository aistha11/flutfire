import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutfire/getx_app/controllers/profileController.dart';
import 'package:flutfire/getx_app/models/dbUser.dart';
import 'package:flutfire/getx_app/pages/auth/dp/profile_view.dart';
import 'package:flutfire/getx_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: ListView(
            children: [
              Column(
                children: [
                  DrawerProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  Utils.getDivider(),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text("Profile"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Get.to(() => ProfileView());
                    },
                  ),
                  ListTile(
                    title: Text("Sign Out"),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Get.find<FirebaseAuthController>().signOut();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerProfile extends StatelessWidget {
  // final DbUser user = DbUser(
  //     name: "Bijay Stha",
  //     username: "asdfasdfasdf",
  //     profilePhoto: "",
  //     email: "hello@gml");

  @override
  Widget build(BuildContext context) {
    // final String email = Get.find<FirebaseAuthController>().user!.email!;
    return GetX<ProfileController>(
      builder: (controller) {
        DbUser user = controller.dbUser.value;
        return Container(
          child: Row(
            children: [
              user.profilePhoto != ""
                  ? CircleAvatar(
                      radius: 40,
                      foregroundImage:
                          CachedNetworkImageProvider(user.profilePhoto),
                    )
                  : Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellowAccent,
                      ),
                      child: Center(
                        child: Text(
                          Utils.getInitials(user.name),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // color: UniversalVariables.lightBlueColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: Text(
                      "${user.name}",
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "${user.email}",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
