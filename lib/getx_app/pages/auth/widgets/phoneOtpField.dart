import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneOtpField extends StatelessWidget {
  const PhoneOtpField(
      {Key? key,
      required this.onCompleted,
      required this.timer,
      required this.digit})
      : super(key: key);
  final void Function(String)? onCompleted;
  final int timer;
  final int digit;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                Text(
                  "Enter $digit digit OTP",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          OTPTextField(
            length: digit,
            width: MediaQuery.of(context).size.width - 34,
            fieldWidth: 58,
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: Colors.grey,
              borderColor: Colors.black,
            ),
            style: TextStyle(fontSize: 17, color: Colors.black26),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: onCompleted,
            onChanged: (val){
              print("Changing: $val");
            },
            // onCompleted: (pin) {
            //   print("Completed: " + pin);
            //   setState(() {
            //     smsCode = pin;
            //   });
            // },

          ),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: "Send OTP again in ",
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
              TextSpan(
                text: "00:$timer",
                style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
              ),
              TextSpan(
                text: " sec ",
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
