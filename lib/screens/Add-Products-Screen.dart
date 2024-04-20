import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/Category-Dropdown-Controller.dart';
import '../controllers/Get-Products-Images-Controller.dart';
import '../utils/app_constant.dart';
import '../widgets/Dropdown-Categories-Widget.dart';

class AddProductsScreen extends StatelessWidget {
  AddProductsScreen({super.key});

  AddProductImagesController addProductImagesController =
  Get.put(AddProductImagesController());

  CategoryDropDownController categoryDropDownController =
  Get.put(CategoryDropDownController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Add Products",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Images"),
                    ElevatedButton(
                        onPressed: (){
                          addProductImagesController.showImagesPickerDialog();
                        },
                        child: const Text("Select Images"))
                  ],
                ),
              ),
        
              // show Images
              GetBuilder<AddProductImagesController>(
                init: AddProductImagesController(),
                builder: (imageController) {
                  return imageController.SelectedImages.length > 0
                      ? Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: Get.height / 3.0,
        
                       child: GridView.builder(
                         itemCount: imageController.SelectedImages.length,
                           physics: const BouncingScrollPhysics(),
        
                           gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10,
                           ),
        
                           itemBuilder: (BuildContext context, int index) {
                             return Stack(
                               children: [
                                 Image.file(
                                   File(imageController
                                       .SelectedImages[index].path),
                                   fit: BoxFit.cover,
                                   height: Get.height / 4,
                                   width: Get.width / 2,
                                 ),
                                 Positioned(
                                   right: 10,
                                   top: 0,
                                   child: InkWell(
                                     onTap: (){
                                       imageController.removeImages(index);
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
                           }),
                  )
                      : SizedBox.shrink();
                },
              ),

              //show categories drop down widget
              DropDownCategoriesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
