import 'dart:io';

import 'package:admin_panel/models/Product-Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/Category-Dropdown-Controller.dart';
import '../controllers/Get-Products-Images-Controller.dart';
import '../controllers/Is-Sale-Controller.dart';
import '../services/Generate-Ids-Services.dart';
import '../utils/app_constant.dart';
import '../widgets/Dropdown-Categories-Widget.dart';

class AddProductsScreen extends StatelessWidget {
  AddProductsScreen({super.key});

  AddProductImagesController addProductImagesController =
  Get.put(AddProductImagesController());

  CategoryDropDownController categoryDropDownController =
  Get.put(CategoryDropDownController());

  IsSaleController isSaleController = Get.put(IsSaleController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController rentPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

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
        physics: BouncingScrollPhysics(),
        child: Container(
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

              //IS SALE METHOD CALLED HERE
              GetBuilder<IsSaleController>(
                  init: IsSaleController(),
                  builder: (isSaleController){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" Product On Sale ",
                                style: TextStyle(fontSize: 17),),
                              Switch(
                                value: isSaleController.isSale.value,
                                activeColor: AppConstant.appMainColor,
                                onChanged: (value){
                                  isSaleController.toggleIsSale(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),

              //FORM FIELD
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintText: "Product Name: ",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Obx(() {
                return isSaleController.isSale.value? Container(
                  height: 65,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    cursorColor: AppConstant.appMainColor,
                    textInputAction: TextInputAction.next,
                    controller: salePriceController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: "Sale Price: ",
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ): SizedBox.shrink();
              },
              ),

              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: rentPriceController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintText: "Rent Price: ",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: productDescriptionController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintText: "Product Description: ",
                    hintStyle: TextStyle(fontSize: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  try{
                    EasyLoading.show();
                    await addProductImagesController
                        .uploadFunction(addProductImagesController.SelectedImages);
                    print(addProductImagesController.arrImagesUrl);
                    print('Category Name: ${categoryDropDownController.selectedCategoryName}');

                    String productId = await GenerateIds().generateProductId();

                    ProductModel productModel = ProductModel(
                      productId: productId,
                      categoryId: categoryDropDownController.selectedCategoryId.toString(),
                      productName: productNameController.text.trim(),
                      categoryName: categoryDropDownController.selectedCategoryName.toString(),
                      salePrice: salePriceController.text!= "" ? salePriceController.text.trim() : "",
                      rentPrice: rentPriceController.text.trim(),
                      deliveryTime: "",
                      isSale: isSaleController.isSale.value,
                      productImages: addProductImagesController.arrImagesUrl,
                      productDescription: productDescriptionController.text.trim(),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    await FirebaseFirestore.instance
                        .collection("products")
                        .doc(productId)
                        .set(productModel.toMap(),
                    );

                    EasyLoading.dismiss();
                  }
                  catch(e){
                    Get.snackbar(
                        "Error",
                        "$e",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appSecondaryColor,
                        colorText: AppConstant.appTextColor
                    );
                  }
                },
                child: Text("Upload Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}