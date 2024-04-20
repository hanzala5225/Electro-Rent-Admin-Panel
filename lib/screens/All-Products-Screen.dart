import 'package:admin_panel/models/Product-Model.dart';
import 'package:admin_panel/screens/Single-Product-Detail-Screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../controllers/Get-Products-Length-Controller.dart';
import '../utils/app_constant.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final GetProductsLengthController _getProductsLengthController = Get.put(GetProductsLengthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppConstant.appTextColor),
          backgroundColor: AppConstant.appMainColor,
          title: Obx(() {
            return Text(
              'Products (${_getProductsLengthController.productsCollectionLength.toString()})',
              style: TextStyle(color: AppConstant.appTextColor),);
          })
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .orderBy("createdAt", descending: true)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError){
              return Container(
                child: Center(
                  child: Text("Error Occured While Fetching Products..!!"),
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
                  child: Text("No Products Found..!!"),
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

                  ProductModel productModel = ProductModel(
                      productId: data['productId'],
                      categoryId: data['categoryId'],
                      productName: data['productName'],
                      categoryName: data['categoryName'],
                      salePrice: data['salePrice'],
                      rentPrice: data['rentPrice'],
                      deliveryTime: data['deliveryTime'],
                      isSale: data['isSale'],
                      productImages: data['productImages'],
                      productDescription: data['productDescription'],
                      createdAt: data['createdAt'],
                      updatedAt: data['updatedAt'],
                  );

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: () => Get.to(
                              () => SingleProductDetailScreen(productModel: productModel)),
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
                            productModel.productImages[0],
                            errorListener: (err) {
                              print("Error Loading Image");
                              Icon(Icons.error);
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        productModel.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(productModel.categoryName),
                      trailing: Icon(Icons.edit),
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

