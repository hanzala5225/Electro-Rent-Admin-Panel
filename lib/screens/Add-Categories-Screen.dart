import 'dart:io';

import 'package:admin_panel/models/Categories-Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/Get-Categories-Image-Controller.dart';
import '../controllers/Get-Products-Images-Controller.dart';
import '../services/Generate-Ids-Services.dart';
import '../utils/app_constant.dart';

class AddCategoriesScreen extends StatefulWidget {
  AddCategoriesScreen({super.key});

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}
class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  TextEditingController categoryNameController = TextEditingController();
  AddCategoriesImagesController addCategoriesImagesController =
  Get.put(AddCategoriesImagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Add Categories",
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
                    onPressed: () {
                      addCategoriesImagesController.showImagesPickerDialog();
                    },
                    child: const Text("Select Images"),
                  ),
                ],
              ),
            ),
            GetBuilder<AddCategoriesImagesController>(
              init: AddCategoriesImagesController(),
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
                              File(imageController.SelectedImages[index].path),
                              fit: BoxFit.cover,
                              height: Get.height / 4,
                              width: Get.width / 2,
                            ),
                            Positioned(
                              right: 10,
                              top: 0,
                              child: InkWell(
                                onTap: () {
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
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: categoryNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  hintText: "Category Name: ",
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
                EasyLoading.show(status: 'Uploading...');
                try {
                  await addCategoriesImagesController.uploadFunction(addCategoriesImagesController.SelectedImages);
                  print(addCategoriesImagesController.arrImagesUrl);
                  String categoryId = await GenerateIds().generateCategoryId();

                  CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: categoryId,
                    categoryImg: addCategoriesImagesController.arrImagesUrl[0],
                    categoryName: categoryNameController.text.trim(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  print(categoryId);

                  await FirebaseFirestore.instance.collection('categories').doc(categoryId).set(categoriesModel.toMap());

                  EasyLoading.showSuccess('Upload Complete!');
                } catch (e) {
                  EasyLoading.showError('Upload Failed');
                } finally {
                  EasyLoading.dismiss();
                }
              },
              child: Text("Upload"),
            )

          ],
        ),),
      ),
    );
  }
}
