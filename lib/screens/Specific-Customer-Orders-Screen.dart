import 'package:admin_panel/models/Order-Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_constant.dart';
import 'Check-Single-Order-Screen.dart';

class SpecificCustomerOrderScreen extends StatefulWidget {
  String docId;
  String customerName;
  SpecificCustomerOrderScreen({
    super.key,
    required this.docId,
    required this.customerName
  });

  @override
  State<SpecificCustomerOrderScreen> createState() => _SpecificCustomerOrderScreenState();
}

class _SpecificCustomerOrderScreenState extends State<SpecificCustomerOrderScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppConstant.appTextColor),
          backgroundColor: AppConstant.appMainColor,
          title: Text(widget.customerName,
            style: const TextStyle(
              color: AppConstant.appTextColor),),
        ),

      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("orders").doc(widget.docId).collection('confirmOrders')
              .orderBy("createdAt", descending: true)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError){
              return Container(
                child: Center(
                  child: Text("Error Occured While Fetching Orders..!!"),
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
                  child: Text("No Orders Found..!!"),
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

                  String orderDocId = data.id;

                  OrderModel orderModel = OrderModel(
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
                      productQuantity: data['productQuantity'],
                      productTotalPrice: data['productTotalPrice'],
                      customerId: data['customerId'],
                      status: data['status'],
                      customerName: data['customerName'],
                      customerPhone: data['customerPhone'],
                      customerAddress: data['customerAddress'],
                      customerDeviceToken: data['customerDeviceToken']
                  );


                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: () => Get.to(
                            () => CheckSingleOrderScreen(
                          docId: snapshot.data!.docs[index].id,
                          orderModel: orderModel,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      leading: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppConstant.appSecondaryColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                              orderModel.productImages[0],
                              errorListener: (err) {
                                print("Error Loading Image");
                                Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderModel.customerName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            orderModel.productName,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: (){
                          showBottomSheet(
                            userDocId: widget.docId,
                            orderModel: orderModel,
                            orderDocId: orderDocId,
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 26,
                          color: Colors.grey,
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

  void showBottomSheet({
    required String userDocId,
    required OrderModel orderModel,
    required String orderDocId,
  }) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Order Options",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Show loading indicator
                  Get.dialog(
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false, // Prevent dismissing dialog on tap outside
                  );

                  // Simulate delay for demonstration
                  await Future.delayed(Duration(seconds: 2));

                  // Hide loading indicator
                  Get.back();

                  // Update status
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(userDocId)
                      .collection('confirmOrders')
                      .doc(orderDocId)
                      .update({'status': false});

                  // Show success message
                  Get.snackbar(
                    'Success!',
                    'Order has been marked as Pending',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Mark as Pending",
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Show loading indicator
                  Get.dialog(
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false, // Prevent dismissing dialog on tap outside
                  );

                  // Simulate delay for demonstration
                  await Future.delayed(Duration(seconds: 2));

                  // Hide loading indicator
                  Get.back();

                  // Update status
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(userDocId)
                      .collection('confirmOrders')
                      .doc(orderDocId)
                      .update({'status': true});

                  // Show success message
                  Get.snackbar(
                    'Success!',
                    'Order has been marked as Delivered',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Mark as Delivered",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
