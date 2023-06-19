import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/services/auth_service.dart';

import '../routes/app_routes.dart';


class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return !authService.isLoginn
        ? const RouteSettings(name: Routes.Splash) : const RouteSettings(name: Routes.Home);
  }
}
