import 'package:admin_panel/screens/All-Categories-Screen.dart';
import 'package:admin_panel/screens/All-Products-Screen.dart';
import 'package:admin_panel/screens/main_screen.dart';
import 'package:admin_panel/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/All-Orders-Screen.dart';
import '../screens/All-Users-Screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key
      });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

   class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser;



  String username = "User";
  String firstLetter = "U";

  @override
     void initState(){
    super.initState();
  }

  @override
     Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(top: Get.height / 25),
            child: Drawer(
              backgroundColor: AppConstant.appSecondaryColor,
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                )),

                child: Wrap(
                  runSpacing: 10,

                  children: [
                    user != null ?
                    Padding(
                      padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 20),
                        child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                            username.toString(),
                            style: TextStyle(color: AppConstant.appTextColor),
                        ),

                            subtitle: Text(
                              AppConstant.appVersion,
                              style: TextStyle(color: Colors.grey),
                                ),

                            leading: CircleAvatar(
                               radius: 22.0,
                               backgroundColor: AppConstant.appMainColor,
                                 child: Text(
                                 firstLetter,
                                 style: TextStyle(color: AppConstant.appTextColor),
                               ),
                            ),
                        ),
                    )
                              : Padding(
                                    padding: EdgeInsets.symmetric(
                                     horizontal: 10, vertical: 20),

                                        child: ListTile(
                                           titleAlignment: ListTileTitleAlignment.center,
                                            title: Text(
                                              "Guest",
                                               style: TextStyle(color: AppConstant.appTextColor),
                                        ),

                                          subtitle: Text(
                                           AppConstant.appVersion,
                                           style: TextStyle(color: Colors.grey),
                                        ),

                                           leading: CircleAvatar(
                                           radius: 22.0,
                                           backgroundColor: AppConstant.appMainColor,
                                              child: Text(
                                                 "G",
                                                  style: TextStyle(color: AppConstant.appTextColor),
                                           ),
                                          ),
                                     ),
                                  ),
                    const Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.offAll(() => MainScreen());
                        },
                        title: Text(
                          "Home",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(() => AllUsersScreen());
                        },
                        title: Text(
                          "Users",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.to(() => AllOrdersScreen());
                        },
                        title: Text(
                          "Orders",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.back();
                          Get.to(() => AllProductsScreen());
                        },
                        title: Text(
                          "Products",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.production_quantity_limits,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: () async {
                          Get.back();
                          EasyLoading.show(status: "Please Wait..");
                          //Get.offAll(() => MainScreen());
                          Get.to(()=> AllCategoriesScreen());
                          //await sendMessage();
                          EasyLoading.dismiss();
                        },
                        title: Text(
                          "Categories",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.category,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.offAll(() => MainScreen());
                        },
                        title: Text(
                          "Contact",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0),
                      child: ListTile(
                        onTap: (){
                          Get.offAll(() => MainScreen());
                        },
                        title: Text(
                          "Reviews",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        leading: Icon(
                          Icons.reviews,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
    );
  }
}


//
//   Widget build(BuildContext context) {
//     return Padding(padding: EdgeInsets.only(top: Get.height / 25),
//       child: Drawer(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           )
//         ),
//
//         child: Wrap(
//           runSpacing: 10,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//               child: ListTile(
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Hanzala', style: TextStyle(color: AppConstant.appTextColor),),
//                 subtitle: Text('Version: 1.0.1', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: CircleAvatar(
//                   radius: 22.0,
//                   backgroundColor: AppConstant.appMainColor,
//                   child: Text('H', style: TextStyle(color: AppConstant.appTextColor),),
//                 ),
//               ),
//             ),
//             Divider(
//               indent: 10.0,
//               endIndent: 10.0,
//               thickness: 1.5,
//               color: Colors.grey,
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0),
//               child: ListTile(
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Home', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: Icon(Icons.home, color: AppConstant.appTextColor),
//                 trailing: Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0),
//               child: ListTile(
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Products', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: Icon(Icons.production_quantity_limits, color: AppConstant.appTextColor),
//                 trailing: Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0),
//               child: ListTile(
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Orders', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: Icon(Icons.shopping_bag, color: AppConstant.appTextColor),
//                 trailing: Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
//                 onTap: (){},
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0),
//               child: ListTile(
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Contact', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: Icon(Icons.help, color: AppConstant.appTextColor),
//                 trailing: Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0),
//               child: ListTile(
//                 onTap: () async {},
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Logout', style: TextStyle(color: AppConstant.appTextColor),),
//                 leading: Icon(Icons.logout, color: AppConstant.appTextColor),
//                 trailing: Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: AppConstant.appSecondaryColor,
//       ),
//     );
//   }
// }
