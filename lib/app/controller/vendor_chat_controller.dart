import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/chat_list_data.dart';

import '../repository/chat_repository.dart';

class VendorChatController extends GetxController {

  final isLoading = false.obs;
  late ChatRepository chatRepository;
  final chatList = <ChatListDatum>[].obs;

  VendorChatController() {
    chatRepository = ChatRepository();

  }

  @override
  void onInit(){
    super.onInit();
    getChatList();
  }


  void getChatList() async {
    try {
      isLoading.value = true;
      ChatListData chatListData = await chatRepository.getChatList();
      chatList.assignAll(chatListData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        Get.snackbar('', e.response!.data['msg']);
        print(e.response!.data);
      } else {
        Get.snackbar('', e.toString());
        print(e.toString());
      }
    }
  }
}