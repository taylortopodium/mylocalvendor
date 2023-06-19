import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/preferences.dart';

class AuthService extends GetxService {
  final _box = GetStorage();
  late bool isLogin;
  late int steps;
  String? deviceToken;
  late bool isOnboarded;

  AuthService() {
    checkUserLogin();
  }

  Future init() async {}

  void checkUserLogin() {
    bool hasData = _box.hasData(SharedPref.isLogin);
    print("User Logged In =====> " + hasData.toString());
    if (hasData) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }



  Future removeUser() async {
    await _box.remove(SharedPref.isLogin);
    await _box.remove('mDateKey');
  }

  Future setUserLogin() async {
    await _box.write(SharedPref.isLogin, "true");
  }

  bool get isLoginn => isLogin;

}
