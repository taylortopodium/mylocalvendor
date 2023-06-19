import 'dart:io';

import 'package:get/get.dart';

import '../model/normal_response.dart';
import '../model/profile_data.dart';
import '../provider/api_provider.dart';

class ProfileRepository {
  late APIProvider _apiProvider;

  ProfileRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<ProfileData> getProfileDetails() async {
    return _apiProvider.getProfileDetails();
  }

  Future<NormalResponse> updateProfile(String name, String email, String mobile,
      String address, String city, String about, File image,String country_code) async {
    return _apiProvider.updateProfile(
        name, email, mobile, address, city, about, image,country_code);
  }


  Future<NormalResponse> deactivateAcccount() async {
    return _apiProvider.deactivateAcccount();
  }

  Future<NormalResponse> deletAccount() async {
   return _apiProvider.deletAccount();
  }



}
