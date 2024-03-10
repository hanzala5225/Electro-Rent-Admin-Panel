import 'package:admin_panel/models/Order-Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class CheckSingleOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;
  CheckSingleOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel
  });

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCircle(String imageUrl) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: NetworkImage(imageUrl),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: Colors.grey[400],
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           iconTheme: const IconThemeData(color: AppConstant.appTextColor),
           backgroundColor: AppConstant.appMainColor,
           title: Text('Order Details',
             style: const TextStyle(
             color: AppConstant.appTextColor),),
         ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                      'Category:',
                      orderModel.categoryName,
                    ),
                    _buildDetailItem(
                      'Product Name:',
                      orderModel.productName,
                    ),
                    _buildDetailItem(
                      'Total Price:',
                      orderModel.productTotalPrice.toString(),
                    ),
                    _buildDetailItem(
                      'Quantity:',
                      orderModel.productQuantity.toString(),
                    ),
                    _buildDetailItem(
                      'Description:',
                      orderModel.productDescription,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildImageCircle(orderModel.productImages[0]),
                          _buildImageCircle(orderModel.productImages[2]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildDivider(),
              Text(
                'Customer Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(
                      'Name:',
                      orderModel.customerName,
                    ),
                    _buildDetailItem(
                      'Phone:',
                      orderModel.customerPhone,
                    ),
                    _buildDetailItem(
                      'Address:',
                      orderModel.customerAddress,
                    ),
                    _buildDetailItem(
                      'ID:',
                      orderModel.customerId,
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              SizedBox(height: 20),
              _buildDetailItem(
                'Product ID:',
                orderModel.productId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
