import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutfire/getx_app/pages/auth/widgets/authSubmitButton.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth_controller.dart';
import 'widgets/phoneOtpField.dart';
import 'widgets/phoneTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneAuthView extends StatefulWidget {
  PhoneAuthView({Key? key}) : super(key: key);

  @override
  _PhoneAuthViewState createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/otp.jpg",
                  height: 300,
                  width: 300,
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => PhoneTextField(
                    controller: controller.phone,
                    wait: controller.wait.value,
                    onTap: controller.wait.value
                        ? null
                        : () async {
                            controller.sendOtp();
                            await Get.find<FirebaseAuthController>()
                                .verifyPhoneNumber(
                                    "+977 ${controller.phone.text}",
                                    controller.setData);
                          },
                    buttonName: controller.buttonName.value,
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // otpField(),
                Obx(
                  () => PhoneOtpField(
                    digit: 6,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                      controller.setSmsCode(pin);
                    },
                    timer: controller.start.value,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                AuthSubmitButton(
                  onPressed: () {
                    Get.find<FirebaseAuthController>().signInwithPhoneNumber(
                        controller.verificationIdFinal.value,
                        controller.smsCode.value);
                  },
                  icon: FontAwesomeIcons.solidThumbsUp,
                  name: "Submit",
                ),
                SizedBox(
                  height: 30,
                ),
                Text.rich(
                  TextSpan(
                      text: "Go Back".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.back();
                        }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
