import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/notification_data.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/normal_response.dart';
import '../model/wishlist_data.dart';

class NotificationRepository {
  late APIProvider _apiProvider;

  NotificationRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<NotificationData> getNotifications() async {
    return _apiProvider.getNotifications();
  }

  Future<NormalResponse> deleteNotification(String notificationId) async {
    return _apiProvider.deleteNotification(notificationId);
  }

}
