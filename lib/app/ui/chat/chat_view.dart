import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/chat_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: colorConstants.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: getBorderRadiusCircular(),
                      child: Image.network(controller.otherUserImage.value,
                          fit: BoxFit.cover,
                          width: getLargeTextFontSIze() * 1.6,
                          height: getLargeTextFontSIze() * 1.6),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addText(
                            controller.otherUserName.value,
                            getNormalTextFontSIze(),
                            colorConstants.black,
                            FontWeight.bold),
                        // addText('Online', getSmallTextFontSIze(), colorConstants.greyTextColor, FontWeight.normal),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      // controller.canChat.value = !controller.canChat.value;
                      controller.blockUnblockUser(
                          controller.otherUserID.value.toString());
                    },
                    child: Obx(() => addText(
                        controller.isUserBlocked.value ? 'Unblock' : 'Block',
                        getSmallTextFontSIze(),
                        colorConstants.black,
                        FontWeight.bold)))
              ],
            ),
          ),
          const Divider(),
          Expanded(child: buildChat()),
          Obx(() => Column(
                children: [
                  if (controller.isMeBlocked.value &&
                      controller.isUserBlocked.value)
                    addText(
                        'You both have blocked each other',
                        getNormalTextFontSIze(),
                        colorConstants.black,
                        FontWeight.normal),
                  if (controller.isMeBlocked.value)
                    addText(
                        'You have been blocked by ${controller.otherUserName.toString()}',
                        getNormalTextFontSIze(),
                        colorConstants.black,
                        FontWeight.normal),
                  if (controller.isUserBlocked.value)
                    addText(
                        'You have blocked ${controller.otherUserName.toString()}',
                        getNormalTextFontSIze(),
                        colorConstants.black,
                        FontWeight.normal),
                  if (!controller.isMeBlocked.value &&
                      !controller.isUserBlocked.value)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: colorConstants.lightGrey, width: 0.5),
                          borderRadius: getBorderRadiusCircular()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.showEmoji.value =
                                  !controller.showEmoji.value;
                            },
                            child: SvgPicture.asset('assets/images/smile.svg',
                                height: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            // inputFormatters: [CapitalCaseTextFormatter()],
                            maxLines: 100,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            controller: controller.chatController,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(fontSize: getNormalTextFontSIze()),
                            decoration: InputDecoration(
                                hintText: 'Type your text here...'.tr,
                                hintStyle: TextStyle(
                                    fontSize: getNormalTextFontSIze(),
                                    color: colorConstants.greyTextColor
                                        .withOpacity(0.8)),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                // contentPadding: EdgeInsets.zero,
                                border: InputBorder.none),
                          )),
                          GestureDetector(
                            onTap: () {
                              if (controller.chatController.text
                                  .trim()
                                  .isNotEmpty) {
                                controller.sendMessage(
                                    controller.otherUserID.value,
                                    controller.chatController.text.trim());
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/images/send.svg',
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Offstage(
              offstage: controller.showEmoji.value,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                    textEditingController: controller.chatController,
                    onEmojiSelected: (Category category, Emoji emoji) {
                      // _onEmojiSelected(emoji);
                    },
                    onBackspacePressed: () {},
                    config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.black,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.black,
                        progressIndicatorColor: Colors.black,
                        backspaceColor: Colors.black,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.black,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recent',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget buildChat() {
    return Obx(() => controller.isLoading.value
        ? buildLoader()
        : ListView.builder(
            itemCount: controller.messageList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  children: [
                    Align(
                      alignment:
                          (controller.messageList[index].senderId.toString() ==
                                  getValue(SharedPref.userId)
                              ? Alignment.topRight
                              : Alignment.topLeft),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: controller.messageList[index].senderId
                                      .toString() ==
                                  getValue(SharedPref.userId)
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                          color: (controller.messageList[index].senderId
                                      .toString() ==
                                  getValue(SharedPref.userId)
                              ? Colors.black
                              : Colors.grey.shade200),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: addText(
                            controller.messageList[index].body,
                            getNormalTextFontSIze(),
                            controller.messageList[index].senderId.toString() ==
                                    getValue(SharedPref.userId)
                                ? colorConstants.white
                                : colorConstants.black,
                            FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment:
                          (controller.messageList[index].senderId.toString() ==
                                  getValue(SharedPref.userId)
                              ? Alignment.topRight
                              : Alignment.topLeft),
                      child: addText(
                          controller
                              .getTime(controller.messageList[index].createdAt),
                          getSmallestTextFontSIze(),
                          colorConstants.greyTextColor,
                          FontWeight.normal),
                    ),
                  ],
                ),
              );
            },
          ));
  }
}
