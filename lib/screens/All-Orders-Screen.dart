import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_constant.dart';
import 'Specific-Customer-Orders-Screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text("All Orders",
          style: const TextStyle(
              color: AppConstant.appTextColor),),

      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("orders")
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
                        child: Text(data['customerName'][0],
                          style: const TextStyle(
                            color: AppConstant.appTextColor),),
                    ),
                        title: Text(data['customerName'], style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(data['customerPhone']),
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
