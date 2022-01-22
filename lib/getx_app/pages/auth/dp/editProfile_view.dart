import 'dart:io';

import 'package:flutfire/getx_app/controllers/profileController.dart';
import 'package:flutfire/getx_app/models/dbUser.dart';
import 'package:flutfire/getx_app/pages/auth/dp/pickImage_View.dart';
import 'package:flutfire/getx_app/services/firebaseService.dart';
import 'package:flutfire/getx_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage; 

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  XFile? _imageFile;
  String imgUrl = "";

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();


  var uploading = false;
  

  dynamic _pickImageError;

  String? _retrieveDataError;

  late firebase_storage.Reference ref;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    name.text = Get.find<ProfileController>().dbUser.value.name;
    int? userNumber = Get.find<ProfileController>().dbUser.value.number;
    number.text = userNumber == null ? "" : userNumber.toString();
    imgUrl = Get.find<ProfileController>().dbUser.value.profilePhoto;
    super.initState();
  }


  void _chooseImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
        
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Widget _previewDP() {
    imgUrl = imgUrl.isEmpty
        ? "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
        : imgUrl;

    bool isFromNet = true;
    if (_imageFile == null || _imageFile!.path.isEmpty) {
      isFromNet = true;
    } else {
      isFromNet = false;
    }
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
            width: 4, color: Theme.of(context).scaffoldBackgroundColor),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 10))
        ],
        shape: BoxShape.circle,
        image: isFromNet
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "$imgUrl",
                ),
              )
            : null,
      ),
      child: isFromNet
          ? null
          : CircleAvatar(
              radius: 80,
              backgroundImage: Image.file(
                File(_imageFile!.path),
                fit: BoxFit.cover,
              ).image,
            ),
    );
  }

  Future uploadImg() async {
    if (_imageFile == null) {
      print("Image Not Selected\nReturning");
      return;
    }
    print("${Path.basename(_imageFile!.path)}");
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images/${Path.basename(_imageFile!.path)}');
      await ref.putFile(File(_imageFile!.path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgUrl = value;
          print(imgUrl);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _editProfile() async {
    print("-----Save To Firebase--------");
    print("Name: ${name.text}");
    print("Number: ${number.text}");
    print("ImageUrl: ${imgUrl}");
    try {
      print("-----Uploading Image");
      await uploadImg();
      DbUser dbUser = DbUser(
        name: name.text,
        number: Utils.strToInt(number.text),
        username: Get.find<ProfileController>().dbUser.value.username,
        profilePhoto: imgUrl,
        email: Get.find<ProfileController>().dbUser.value.email,
        deviceToken: Get.find<ProfileController>().dbUser.value.deviceToken,
      );
      await FirebaseService.updateProfile(dbUser);
    } catch (e) {
      print(e);
    }

    print("-----Done Save To Firebase--------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.green,
          )
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => PickImageView());
            },
            icon: Icon(
              Icons.info,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return _previewDP();
                          case ConnectionState.done:
                            return _previewDP();
                          default:
                            if (snapshot.hasError) {
                              return _previewDP();
                            } else {
                              return _previewDP();
                            }
                        }
                      },
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print("Change Image");
                              _chooseImage(ImageSource.gallery);
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField(
                  "Full Name", "Enter your Name", name, TextInputType.name),
              buildTextField(
                  "Number", "Enter your number", number, TextInputType.number),
              SizedBox(
                height: 35,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _editProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      TextEditingController? controller, TextInputType? keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
        ),
      ),
    );
  }
}
