import 'package:admin_panel/models/Product-Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class SingleProductDetailScreen extends StatelessWidget {
  ProductModel productModel;
  SingleProductDetailScreen({
    super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(productModel.productName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
        children: [
          Card(
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Name"),
                      Container(
                        width: Get.width / 2,
                          child: Text(
                            productModel.productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Category"),
                      Container(
                        width: Get.width / 2,
                        child: Text(
                          productModel.categoryName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Price"),
                      Container(
                        width: Get.width / 2,
                        child: Text(
                          productModel.salePrice != "" ? productModel.salePrice : productModel.rentPrice,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Description"),
                      Container(
                        width: Get.width / 2,
                        child: Text(
                          productModel.productDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Is Sale"),
                      Container(
                        width: Get.width / 2,
                        child: Text(
                          productModel.isSale ? "True" : "False",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Images"),
                      Container(
                        width: Get.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildImageCircle(productModel.productImages[0]),
                          ],
                        ),
                        // Text(
                        //   productModel.productImages[0],
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 3,
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),),
    );
  }
  Widget _buildImageCircle(String imageUrl) {
    return CircleAvatar(
      radius: 40.0,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
