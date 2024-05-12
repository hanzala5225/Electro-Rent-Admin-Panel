import 'dart:io';

import 'package:admin_panel/controllers/Edit-Product-Controller.dart';
import 'package:admin_panel/models/Product-Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../controllers/Category-Dropdown-Controller.dart';
import '../utils/app_constant.dart';

class EditProductScreen extends StatelessWidget {
  ProductModel productModel;
  EditProductScreen({
    super.key,
    required this.productModel
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: productModel),
        builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppConstant.appTextColor),
            backgroundColor: AppConstant.appMainColor,
            title: Text("Edit:  ${productModel.productName}",
              style: const TextStyle(color: AppConstant.appTextColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: Get.height / 3.5,
                      child: GridView.builder(
                          itemCount: controller.images.length,
                          physics: const BouncingScrollPhysics(),

                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),

                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                CachedNetworkImage(
                                    imageUrl: controller.images[index],
                                  fit: BoxFit.contain,
                                  height: Get.height / 5.5,
                                  width: Get.width / 2,
                                  placeholder: (context, url) => Center(
                                    child: CupertinoActivityIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  child: InkWell(
                                    onTap: () async{
                                      EasyLoading.show();
                                      await controller.deleteImagesFromStorage(
                                        controller.images[index].toString(),
                                      );
                                      await controller.deleteImagesFromFireStore(
                                          controller.images[index].toString(), productModel.productId);
                                      EasyLoading.dismiss();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppConstant.appMainColor,
                                      child: Icon(
                                        Icons.close,
                                        color: AppConstant.appTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                       ),
                    ),
                  ),
          GetBuilder<CategoryDropDownController>(
            init: CategoryDropDownController(),
            builder: (categoryDropDownController) {
              return SingleChildScrollView( // Wrap with SingleChildScrollView
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: categoryDropDownController.selectedCategoryId?.value,
                            items: categoryDropDownController.categories
                                .map<DropdownMenuItem<String>>((category) {
                              return DropdownMenuItem<String>(
                                value: category['categoryId'], // Assuming 'categoryId' is the unique identifier
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        category["categoryImg"].toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(category['categoryName']),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedValue) async {
                              categoryDropDownController.setSelectedCategory(selectedValue);
                            },
                            hint: Text("Select Product Category"),
                            isExpanded: true,
                            elevation: 10,
                            underline: SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

