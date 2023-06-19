import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/auth_data.dart';
import '../model/chat_list_data.dart';
import '../model/message_data.dart';
import '../model/normal_response.dart';

class ChatRepository {
  late APIProvider _apiProvider;

  ChatRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<ChatListData> getChatList() async {
    return _apiProvider.getChatList();
  }

  Future<MessageData> getMessages(String otherUSerId) async {
    return _apiProvider.getMessages(otherUSerId);
  }

  Future<MessageData> sendMessage(String receverId, String message) async {
   return _apiProvider.sendMessage(receverId, message);
  }

  Future<NormalResponse> blockUnblockUser(String otherUSerId) async {
    return _apiProvider.blockUnblockUser(otherUSerId);
  }

}
