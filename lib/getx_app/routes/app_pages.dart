import 'package:flutfire/getx_app/pages/wrapper.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WRAPPER;

  static final routes = [
    GetPage(
      name: Routes.WRAPPER,
      page: () => Wrapper(),
    ),
  ];
}

