import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/normal_response.dart';
import '../model/order_Details_data.dart';
import '../model/orders_data.dart';
import '../model/wishlist_data.dart';

class OrderRepository{

  late APIProvider _apiProvider;

  OrderRepository(){
    _apiProvider = Get.find<APIProvider>();
  }


  Future<OrdersData> getOrders() async {
    return _apiProvider.getOrders();
  }

  Future<OrdersData> getVendorOrders() async {
    return _apiProvider.getVendorOrders();
  }

  Future<NormalResponse> addReview(String productID,String rating,String review,bool isVendor) async {
    return _apiProvider.addReview(productID, rating, review, isVendor);
  }

  Future<OrderDetailsData> getOrderDetails(String orderId) async {
    return _apiProvider.getOrderDetails(orderId);
  }


}