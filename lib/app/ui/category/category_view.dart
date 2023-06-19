import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/category_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/bottom_navigation.dart';
import '../../model/categories_data.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    controller.getCategories(context);

    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: AppBottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: AppHeader(title: 'Category'),
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                  child: Obx(() => controller.isLoading.value
                      ? buildLoader()
                      : ListView.builder(
                          itemCount: controller.categoryList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.ProductView, arguments: {
                                  'title': controller.categoryList[index].name,
                                  'categoryId': controller.categoryList[index].id.toString(),
                                  'itemType': 'none'
                                });
                              },
                              child: buildItem(
                                  controller.categoryList[index].image,
                                  controller.categoryList[index].name,
                                  controller.categoryList[index].subCategory),
                            );
                          },
                        )))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
      String image, String heading, List<CategoriesDatum> subCategoriesList) {
    var subCategories = '';
    var listt = <String>[];
    for (int i = 0; i < subCategoriesList.length; i++)
      listt.add(subCategoriesList[i].name);

    subCategories = listt.join(', ');

    return Column(
      children: [
        Row(
          children: [
            // SvgPicture.asset('assets/images/$image.svg',width: getLargeTextFontSIze()*1.6,fit: BoxFit.cover,),
            Image.network(
              image,
              width: getLargeTextFontSIze() * 1.6,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addText(heading, getNormalTextFontSIze(), colorConstants.black,
                    FontWeight.bold),
                addText(subCategories, getSmallTextFontSIze(),
                    colorConstants.black, FontWeight.normal),
              ],
            )
          ],
        ),
        if (image != 'category')
          Divider(
            height: 4.h,
          )
      ],
    );
  }

  Widget buildLoader() {
    return Shimmer.fromColors(
      baseColor: colorConstants.lightGrey,
      highlightColor: colorConstants.shimmerColor,
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 6,
      ),
    );
  }
}
