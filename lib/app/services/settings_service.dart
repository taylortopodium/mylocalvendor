import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'translation_service.dart';

class SettingsService extends GetxService {

  late GetStorage _box;

  SettingsService() {
    _box = new GetStorage();
  }

  Future<SettingsService> init() async {
    return this;
  }


  Locale getLocale() {
    String? _locale = GetStorage().read<String>('language');
    if (_locale == null || _locale.isEmpty) {
      // _locale = 'pt_BR';
      _locale = 'en_US';
    }
    return Get.find<TranslationService>().fromStringToLocale(_locale);
  }

}
