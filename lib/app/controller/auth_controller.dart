// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_local_vendor/app/model/auth_data.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController registerName;
  late TextEditingController registerEmail;
  late TextEditingController registerMobile;
  late TextEditingController registerPassword;
  late TextEditingController registerConfrmPassword;
  late AuthRepository authRepository;
  final isLoading = false.obs;

  final hideLoginPassword = true.obs;
  final hideSignUpPassword = true.obs;
  final hideSignUpCPassword = true.obs;
  final List<String> coountryCodes = ['+91'];
  final selectedCode = '+1'.obs;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  AuthController() {
    authRepository = AuthRepository();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    registerName = TextEditingController();
    registerEmail = TextEditingController();
    registerMobile = TextEditingController();
    registerPassword = TextEditingController();
    registerConfrmPassword = TextEditingController();
  }

  void registerUser(BuildContext context) async {
    try {
      isLoading.value = true;
      AuthData authData = await authRepository.registerUser(
        registerName.text.trim(),
        registerEmail.text.trim(),
        registerMobile.text.trim(),
        registerPassword.text.trim(),
        selectedCode.value,
      );
      showSnackbar(context, 'Account created successfully');
      storeValue(SharedPref.isLogin, 'true');
      storeValue(SharedPref.userId, authData.data.id.toString());
      storeValue(SharedPref.authToken, authData.token.toString());
      storeValue(SharedPref.address, authData.data.address.toString());
      Get.toNamed(Routes.Home);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data['msg']);
      } else
        showSnackbar(context, e.toString());
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void loginUser(BuildContext context, String email, String password,
      String loginType, String socialId, String name) async {
    try {
      isLoading.value = true;
      AuthData authData = await authRepository.loginUser(
          email, password, loginType, socialId, name);
      storeValue(SharedPref.isLogin, 'true');
      storeValue(SharedPref.userId, authData.data.id.toString());
      storeValue(SharedPref.authToken, authData.token.toString());
      storeValue(SharedPref.address, authData.data.address.toString());
      Get.toNamed(Routes.Home);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        if (loginType == '201') showSnackbar(context, e.response!.data['msg']);
        // if (loginType == '201') showSnackbar(context, e.response!.data);
        print(e.response!.data['msg']);
      } else
        showSnackbar(context, e.toString());
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  AccessToken? _accessToken;

  Future<void> appleSignIn(BuildContext context) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      final AuthorizationCredentialAppleID result =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);

      if (kDebugMode) {
        print('user id ${result.userIdentifier}');
        print('credentials : $result');
      }

      loginUser(context, result.email ?? "", '', '205',
          result.userIdentifier.toString(), result.givenName.toString());
    }
  }

  Future<void> fbLogin(BuildContext context) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken;
        print(
          _accessToken!.toJson(),
        );
        final userData = await FacebookAuth.instance.getUserData();
        // _fbUserData = userData;
        // checkSocialLogin(context, 'facebook', userData['email'], _accessToken.toString());
        loginUser(context, userData['email'], '', '204',
            _accessToken.toString(), userData['name']);
      } else {
        print(result.status);
        print(result.message);
      }
    } else {
      showSnackbar(context, "No internet Connection");
    }
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    if (await ConnectivityWrapper.instance.isConnected) {
      try {
        isLoading.value = true;
        final result = await _googleSignIn.signIn();
        print("Google result $result");
        print("Google auth Token" + result!.serverAuthCode.toString());
        loginUser(context, result.email, '', '203',
            result.serverAuthCode.toString(), result.displayName.toString());
        isLoading.value = false;
      } catch (error) {
        isLoading.value = false;
        // showSnackbar(context, error.toString());
        print(error);
      }
    } else {
      isLoading.value = false;
      showSnackbar(context, "No internet Connection");
    }
  }
}
