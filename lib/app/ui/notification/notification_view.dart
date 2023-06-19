import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/notification_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getNotifications();
        },
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      addText('Notifications', getHeadingTextFontSIze(),
                          colorConstants.black, FontWeight.w600),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: colorConstants.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                    child: Obx(() => controller.isLoading.value
                        ? buildLoader()
                        : controller.notificationList.length == 0 ? Center(
                      child: addText("You don't have any notifications", getHeadingTextFontSIze(), colorConstants.black, FontWeight.w500),
                    ) : ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.notificationList.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        controller.deleteNotification(context,index, controller.notificationList[index].id.toString());
                                      },

                                      backgroundColor: colorConstants.lightGrey,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_rounded,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20), bottomLeft: Radius.circular(0)),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: colorConstants.white,
                                          borderRadius: getCurvedBorderRadius(),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 6.h,
                                                    height: 6.h,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      getBorderRadiusCircular(),
                                                      child: Image.network(
                                                        controller
                                                            .notificationList[
                                                        index]
                                                            .sender
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(width: 60.w,
                                                      child: addText(
                                                          controller
                                                              .notificationList[
                                                          index]
                                                              .description,
                                                          getSmallTextFontSIze(),
                                                          colorConstants.black,
                                                          FontWeight.w600),),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      addText(
                                                          controller
                                                              .notificationList[
                                                          index]
                                                              .timeToCreate,
                                                          getSmallTextFontSIze() -
                                                              1,
                                                          colorConstants
                                                              .greyTextColor,
                                                          FontWeight.w600),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider()
                                            ],
                                          ),
                                        ))),
                              );
                            },
                          )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
