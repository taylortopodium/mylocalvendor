import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/notification_data.dart';
import '../repository/notification_repository.dart';

class NotificationController extends GetxController {
  late NotificationRepository notificationRepository;
  final isLoading = false.obs;
  final notificationList = <Datum>[].obs;

  NotificationController() {
    notificationRepository = NotificationRepository();
  }

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  void getNotifications() async {
    try {
      isLoading.value = true;
      NotificationData notificationData =
          await notificationRepository.getNotifications();
      notificationList.assignAll(notificationData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        print('Upper ===  ' + e.response!.data);
      } else {
        print('Lower ===  ' + e.toString());
      }
    }
  }


 void deleteNotification(BuildContext context,int index,String id)async{
   try {
     NormalResponse response = await notificationRepository.deleteNotification(id);
     showSnackbar(context, response.msg);
     getNotifications();
   } catch (e) {
     if (e is DioError) {
       print('Upper ===  ' + e.response!.data);
       showSnackbar(context, e.response!.data);
     } else {
       print('Lower ===  ' + e.toString());
       showSnackbar(context, e.toString());
     }
   }
 }

}
