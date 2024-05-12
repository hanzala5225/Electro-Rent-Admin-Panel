import 'dart:io';

import 'package:admin_panel/controllers/Edit-Product-Controller.dart';
import 'package:admin_panel/models/Product-Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../controllers/Category-Dropdown-Controller.dart';
import '../controllers/Is-Sale-Controller.dart';
import '../utils/app_constant.dart';

class EditProductScreen extends StatefulWidget {
  ProductModel productModel;
  EditProductScreen({
    super.key,
    required this.productModel
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  IsSaleController isSaleController = Get.put(IsSaleController());

  CategoryDropDownController categoryDropDownController =
  Get.put(CategoryDropDownController());

  TextEditingController productNameController = TextEditingController();

  TextEditingController salePriceController = TextEditingController();

  TextEditingController rentPriceController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: widget.productModel),
        builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppConstant.appTextColor),
            backgroundColor: AppConstant.appMainColor,
            title: Text("Edit:  ${widget.productModel.productName}",
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
                                          controller.images[index].toString(), widget.productModel.productId);
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
                  GetBuilder<IsSaleController>(
                      init: IsSaleController(),
                      builder: (isSaleController) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    " Product On Sale ",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Switch(
                                    value: isSaleController.isSale.value,
                                    activeColor: AppConstant.appMainColor,
                                    onChanged: (value) {
                                      isSaleController.toggleIsSale(value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  //FORM FIELD
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: productNameController..text = widget.productModel.productName,
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
                    return isSaleController.isSale.value
                        ? Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appMainColor,
                        textInputAction: TextInputAction.next,
                        controller: salePriceController..text = widget.productModel.salePrice,
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
                    )
                        : SizedBox.shrink();
                  }),

                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: rentPriceController..text = widget.productModel.rentPrice,
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
                      controller: productDescriptionController..text = widget.productModel.productDescription,
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
                      EasyLoading.show(
                        status: 'Updating Product...',
                        indicator: CircularProgressIndicator(
                          color: AppConstant.appMainColor,
                        ),
                      );
                      ProductModel newProductModel = ProductModel(
                        productId: widget.productModel.productId,
                        categoryId: categoryDropDownController.selectedCategoryId.toString(),
                        productName: productNameController.text.trim(),
                        categoryName: categoryDropDownController.selectedCategoryName.toString(),
                        salePrice: salePriceController.text.isNotEmpty
                            ? salePriceController.text.trim()
                            : "",
                        rentPrice: rentPriceController.text.trim(),
                        deliveryTime: "",
                        isSale: isSaleController.isSale.value,
                        productImages: widget.productModel.productImages,
                        productDescription: productDescriptionController.text.trim(),
                        createdAt: widget.productModel.createdAt,
                        updatedAt: DateTime.now(),
                      );

                      await FirebaseFirestore.instance
                          .collection('products')
                          .doc(widget.productModel.productId)
                          .update(newProductModel.toMap());

                      EasyLoading.dismiss();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppConstant.appTextColor, backgroundColor: AppConstant.appMainColor,
                    ),
                    child: Text("Update"),
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

