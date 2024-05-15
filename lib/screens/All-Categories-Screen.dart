import 'package:admin_panel/models/Categories-Model.dart';
import 'package:admin_panel/screens/Add-Categories-Screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_constant.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "All Categories",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        actions: [
          GestureDetector(
            onTap: ()=> Get.to(() => AddCategoriesScreen()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("categories")
              // .orderBy("createdAt", descending: true)
              .snapshots(),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError){
              return Container(
                child: Center(
                  child: Text("Error Occured While Fetching Categories..!!"),
                ),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if(snapshot.data!.docs.isEmpty){
              return Container(
                child: Center(
                  child: Text("No Category Found..!!"),
                ),
              );
            }
            if(snapshot.data != null){
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final data = snapshot.data!.docs[index];

                  CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: data['categoryId'],
                      categoryImg: data['categoryImg'],
                      categoryName: data['categoryName'],
                      createdAt: data['createdAt'],
                      updatedAt: data['updatedAt'],
                  );

                  return
                    SwipeActionCell(
                      key: ObjectKey(categoriesModel.categoryId), /// this key is necessary
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                            title: "delete",
                            onTap: (CompletionHandler handler) async {
                              await Get.defaultDialog(
                                title: "Delete Product",
                                content: Text("Are You Sure You Want To Delete This Product??"),
                                textCancel: "Cancel",
                                textConfirm: "Delete",
                                contentPadding: EdgeInsets.all(10.0),
                                confirmTextColor: Colors.white,
                                onCancel: () {},
                                onConfirm: () async {
                                  Get.back();
                                  EasyLoading.show(status: "Please Wait....");

                                  // await deleteImagesFromFirebase(
                                  //   productModel.productImages,
                                  // );
                                  // await FirebaseFirestore.instance
                                  //     .collection('products')
                                  //     .doc(productModel.productId)
                                  //     .delete();
                                  EasyLoading.dismiss();
                                },
                                buttonColor: Colors.blue,
                                cancelTextColor: Colors.black,
                              );
                            },
                            color: Colors.blue),
                      ],
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppConstant.appSecondaryColor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppConstant.appSecondaryColor.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),

                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: CachedNetworkImageProvider(
                                categoriesModel.categoryImg[0],
                                errorListener: (err) {
                                  print("Error Loading Image");
                                  Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            categoriesModel.categoryName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(categoriesModel.categoryId),

                          trailing: GestureDetector(
                            onTap: () {

                            },
                            child: Icon(Icons.edit_outlined),
                          ),
                        ),
                      ),
                    );
                },
              );
            }
            return Container();
          }
      ),
    );
  }
}
