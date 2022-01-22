import 'package:firebase_messaging/firebase_messaging.dart';

class FireFcmService {
  static Future<String> getDeviceToken()async{
    return await FirebaseMessaging.instance.getToken()??"";
    // var token = await FirebaseMessaging.instance.getToken();
    // if(token!=null){
    //   return token;
    // }
    // return "";
  }
}