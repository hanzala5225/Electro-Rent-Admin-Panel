import 'dart:io';

import 'package:admin_panel/controllers/Edit-Product-Controller.dart';
import 'package:admin_panel/models/Product-Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                    onTap: (){},
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

