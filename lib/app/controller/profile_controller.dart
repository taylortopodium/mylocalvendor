import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../model/profile_data.dart';
import '../repository/profile_repository.dart';
import '../routes/app_routes.dart';

class ProfileController extends GetxController {
  final desc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type...";

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController aboutMeController;
  final showEmail = false.obs;
  final showPhone = false.obs;

  final isLoading = true.obs;
  final isUpdating = false.obs;
  late ProfileRepository profileRepository;
  // late ProfileData profileData;
  final imageUrl = ''.obs;
  final picker = ImagePicker();
  final imagePicked = false.obs;
  final pickedFile = XFile('').obs;

  var uuid = new Uuid();
  String _sessionToken = new Uuid().toString();
  List<dynamic> placeList = [].obs;
  var focusNode = FocusNode();
  final canshowSuggestions = false.obs;

  final List<String> coountryCodes = ['+91'];
  final selectedCode = '+1'.obs;


  late ProfileDatum profileDatum;

  ProfileController() {
    profileRepository = ProfileRepository();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    aboutMeController = TextEditingController();
    getProfileDetails();
  }

  @override
  void onInit() {
    super.onInit();
    addressController.addListener(() {
      if (canshowSuggestions.value) _onChanged();
    });

  }



  void _onChanged() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getLocationResults(addressController.text);
  }

  void getLocationResults(String input) async {
    // String kPLACES_API_KEY = 'AIzaSyBlfRyMth9TRd84Y104-cbfBR6MFMe-Cy4';
    String kPLACES_API_KEY = '';
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    print(request);
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      // print(response.body);
      placeList.assignAll(json.decode(response.body)['predictions']);
    } else {
      throw Exception('Failed to load predictions');
    }
  }



  void getProfileDetails() async {
    try {
      isLoading.value = true;
      ProfileData profileData2 = await profileRepository.getProfileDetails();
      profileDatum = profileData2.data;
      setEditTexts();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError){
        print(e.response!.data);
        Get.snackbar('', e.response!.data['msg']);
      }

      else
        print(e.toString());
        Get.snackbar('', e.toString());
    }
  }

  void setEditTexts() {
    nameController.text = profileDatum.name.toString();
    emailController.text = profileDatum.email.toString();
    if(profileDatum.mobileNo.toString() == 'null') phoneController.text = '';
    else phoneController.text = profileDatum.mobileNo.toString();

    if(profileDatum.address.toString() == 'null') addressController.text = '';
    else addressController.text = profileDatum.address.toString();


    cityController.text = profileDatum.city.toString();
    if(profileDatum.about.toString() == 'null') aboutMeController.text = '';
    else aboutMeController.text = profileDatum.about.toString();
    // aboutMeController.text = profileDatum.about.toString();
    imageUrl.value = profileDatum.image.toString();
    if(profileDatum.country_code.toString() == '') selectedCode.value = '+1';
    else selectedCode.value = profileDatum.country_code.toString();
  }

  imgFromGallery() async {
    pickedFile.value = (await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20))!;
    imagePicked.value = true;
  }

  imgFromCamera() async {
    pickedFile.value =
        (await picker.pickImage(source: ImageSource.camera, imageQuality: 20))!;
    imagePicked.value = true;
  }

  void updateProfile(BuildContext context) async {
    try {
      isUpdating.value = true;
      NormalResponse normalResponse = await profileRepository.updateProfile(
          nameController.text.trim(),
          emailController.text.trim(),
          phoneController.text.trim(),
          addressController.text.trim(),
          cityController.text.trim(),
          aboutMeController.text.trim(),
          File(pickedFile.value.path),
          selectedCode.value
      );
      isUpdating.value = false;
      Get.find<HomeController>().currentAddress.value = addressController.text;
      storeValue(SharedPref.address, addressController.text);
      Get.back();
      getProfileDetails();
    } catch (e) {
      isUpdating.value = false;
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }

  void deactivateAccount(BuildContext context) async {
    try {
      NormalResponse normalResponse =
          await profileRepository.deactivateAcccount();
      GetStorage().remove(SharedPref.isLogin);
      GetStorage().remove(SharedPref.authToken);
      GetStorage().remove(SharedPref.userId);
      Get.offAllNamed(Routes.Login);
      showSnackbar(context, normalResponse.msg);
    } catch (e) {
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }


  void deletAccount(BuildContext context) async {
    try {
      NormalResponse normalResponse =
      await profileRepository.deletAccount();
      GetStorage().remove(SharedPref.isLogin);
      GetStorage().remove(SharedPref.authToken);
      GetStorage().remove(SharedPref.userId);
      Get.offAllNamed(Routes.Login);
      showSnackbar(context, normalResponse.msg);
    } catch (e) {
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }

}
