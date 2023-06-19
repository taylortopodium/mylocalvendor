import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/auth_data.dart';

class AuthRepository{

  late APIProvider _apiProvider;

  AuthRepository(){
    this._apiProvider = Get.find<APIProvider>();
  }


  Future<AuthData> registerUser(String name,String email,String mobileNo,String password,String countryCode) async {
    return _apiProvider.registerUser(name, email, mobileNo, password,countryCode);
  }

  Future<AuthData> loginUser(String email, String password, String loginType, String socialId, String name) async {
    return _apiProvider.loginUser(email, password, loginType, socialId, name);
  }


}