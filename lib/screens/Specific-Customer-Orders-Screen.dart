import 'package:admin_panel/models/Order-Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_constant.dart';

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
                    child: ListTile(
                      onTap: () => Get.to(
                              ()=> SpecificCustomerOrderScreen(
                              docId: snapshot.data!.docs[index]['uId'],
                              customerName: snapshot.data!.docs[index]['customerName']
                          )),

                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appSecondaryColor,
                        backgroundImage: CachedNetworkImageProvider(
                          orderModel.productImages[0],
                          errorListener: (err){
                            print("Error Loading Image");
                            Icon(Icons.error);
                          },
                        ),
                      ),
                      title: Text(orderModel.customerName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(orderModel.productName),
                      //trailing: Icon(Icons.edit),
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
