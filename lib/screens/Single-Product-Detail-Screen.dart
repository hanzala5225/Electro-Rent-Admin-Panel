import 'package:admin_panel/models/Product-Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class SingleProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;
  SingleProductDetailScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          productModel.productName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Product Name", productModel.productName),
                    _buildDetailRow("Product Category", productModel.categoryName),
                    _buildDetailRow("Product Price", productModel.salePrice.isNotEmpty ? productModel.salePrice : productModel.rentPrice),
                    _buildDetailRow("Product Description", productModel.productDescription, isDescription: true),
                    _buildDetailRow("Is Sale", productModel.isSale ? "True" : "False"),
                    _buildImageRow("Product Images", productModel.productImages.cast<String>()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String detail, {bool isDescription = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            detail,
            style: TextStyle(fontSize: 16.0),
            // If it's the description, do not truncate
            maxLines: isDescription ? null : 3,
            overflow: isDescription ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImageRow(String title, List<String> images) {
    // Ensure we only take up to two images
    final limitedImages = images.length > 2 ? images.sublist(0, 2) : images;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: limitedImages.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildImageCircle(imageUrl),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCircle(String imageUrl) {
    return CircleAvatar(
      radius: 40.0,
      backgroundImage: NetworkImage(imageUrl),
      backgroundColor: Colors.transparent,
    );
  }
}
