import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/model/chat_list_data.dart';
import 'package:my_local_vendor/app/model/message_data.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';

import '../repository/chat_repository.dart';

class ChatController extends GetxController {


  late TextEditingController chatController;

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ].obs;

  final blockText = 'Block'.obs;
  // final canChat = true.obs;
  final showEmoji = true.obs;
  final isLoading = true.obs;
  late ChatRepository chatRepository;
  final messageList = <MessageDatum>[].obs;

  final otherUserID = ''.obs;
  final otherUserName = ''.obs;
  final otherUserImage = ''.obs;
  Timer? timer;

  final isMeBlocked = false.obs;
  final isUserBlocked = false.obs;

  ChatController() {
    chatRepository = ChatRepository();
    chatController = TextEditingController();
  }

  @override
  void onInit(){
    super.onInit();
    otherUserID.value = Get.arguments['id'] as String;
    otherUserName.value = Get.arguments['name'] as String;
    otherUserImage.value = Get.arguments['image'] as String;
    getChatList(otherUserID.value);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getChatList(otherUserID.value));
    print('User id is ${otherUserID.value}');
  }

  @override
  void onClose(){
    super.onClose();
    timer!.cancel();
  }


  void getChatList(String otherUSerId) async {
    try {
      MessageData messageData = await chatRepository.getMessages(otherUSerId);
      messageList.assignAll(messageData.data.data);
      isMeBlocked.value = messageData.data.is_receiver_blocked;
      isUserBlocked.value = messageData.data.is_sender_blocked;
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


  void sendMessage(String otherUSerId,String messsage) async {
    try {
      MessageData messageData = await chatRepository.sendMessage(otherUSerId,messsage);
      messageList.assignAll(messageData.data.data);
      chatController.clear();
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

  void blockUnblockUser(String otherUSerId) async {
    try {
      NormalResponse normalResponse = await chatRepository.blockUnblockUser(otherUSerId);
      isUserBlocked.value = !isUserBlocked.value;
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



  String getTime(String time){
    DateTime dateTime = DateTime.parse(time);
    // return '${dateTime.hour}:${dateTime.minute}';
    return DateFormat('hh:mm a').format(dateTime);
  }

}

  class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
  }