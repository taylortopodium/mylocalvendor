import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/chat_controller.dart';
import 'package:my_local_vendor/app/controller/vendor_chat_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../../routes/app_routes.dart';

class VendorChats extends GetView<VendorChatController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              AppHeader(title: 'Vendor Chats'),
              SizedBox(height: 20,),
              Expanded(child: Obx(() => controller.isLoading.value ? buildLoader() :

                  controller.chatList.length == 0 ? Center(
                    child: addText('No Chats Found', getHeadingTextFontSIze(), colorConstants.black, FontWeight.normal),
                  ) :

              ListView.builder(
                itemCount: controller.chatList.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.ProductView, arguments: {
                      //   'title': controller.categoryList[index].name,
                      //   'categoryId': controller.categoryList[index].id.toString(),
                      //   'itemType': 'none'
                      // });

                      Get.toNamed(Routes.ChatView,
                      arguments: {
                        'id' : controller.chatList[index].id.toString(),
                        'name' : controller.chatList[index].name.toString(),
                        'image' : controller.chatList[index].image.toString(),
                      }
                      );

                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: colorConstants.lightGrey.withOpacity(0.2),
                        borderRadius: getCurvedBorderRadius()
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: getBorderRadiusCircular(),
                            child: Image.network(controller.chatList[index].image,width: 50,height: 50,fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 20,),
                          addText(controller.chatList[index].name, getSubheadingTextFontSIze(), colorConstants.black, FontWeight.normal)
                        ],
                      ),
                    )
                  );
                },
              )

              ))
            ],
          ),
        ),
      ),
    );
  }

}