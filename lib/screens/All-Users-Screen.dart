import 'package:admin_panel/models/user_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_constant.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppConstant.appTextColor),
            backgroundColor: AppConstant.appMainColor,
            title: Text("All Users",
              style: const TextStyle(color: AppConstant.appTextColor),
            ),
          ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .orderBy("createdOn", descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError){
            return Container(
              child: Center(
                child: Text("Error Occured While Fetching Category..!!"),
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
                child: Text("No Users Found..!!"),
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

                UserModel userModel = UserModel(
                    uId: data['uId'],
                    username: data['username'],
                    email: data['email'],
                    phone: data['phone'],
                    userImg: data['userImg'],
                    userDeviceToken: data['userDeviceToken'],
                    country: data['country'],
                    userAddress: data['userAddress'],
                    street: data['street'],
                    isAdmin: data['isAdmin'],
                    isActive: data['isActive'],
                    createdOn: data['createdOn']
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      backgroundImage: CachedNetworkImageProvider(
                        userModel.userImg,
                        errorListener: (err){
                          print("Error Loading Image");
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(userModel.username),
                    subtitle: Text(userModel.email),
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
