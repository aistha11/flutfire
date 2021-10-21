import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/instanceBinding.dart';
import 'routes/app_pages.dart';

class MyGetApp extends StatelessWidget {
  const MyGetApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FlutFire",
      debugShowCheckedModeBanner: false,
      initialBinding: InstanceBinding(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}