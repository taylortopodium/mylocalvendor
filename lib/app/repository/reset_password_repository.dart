import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/auth_data.dart';
import '../model/normal_response.dart';

class ResetPasswordRepository{

  late APIProvider _apiProvider;

  ResetPasswordRepository(){
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<NormalResponse> checkEmail(String email) async {
    return _apiProvider.checkEmail(email);
  }

  Future<NormalResponse> updatePassword(String email,String password) async {
    return _apiProvider.updatePassword(email, password);
  }



}