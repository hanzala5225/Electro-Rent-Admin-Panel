import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_constant.dart';
import '../widgets/Custom_Drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName, style: const TextStyle(color: AppConstant.appTextColor),),
        centerTitle: true,
        // actions: [
        //   GestureDetector(
        //     onTap: () => Get.to(() => CartScreen()),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Icon(Icons.shopping_cart),
        //     ),
        //   ),
        // ],
      ),
      // calling Drawer Widget
      drawer: const DrawerWidget(),

      // body: SingleChildScrollView(
      //   physics: BouncingScrollPhysics(),
      //   child: Container(
      //     child: Column(
      //       children: [
      //         SizedBox(height: Get.height / 90.0,),
      //
      //         // calling banners Widget
      //         BannerWidget(),
      //
      //         // calling heading Widget
      //         HeadingWidget(
      //           headingTitle: "Categories..",
      //           headingSubTitle: "According to your budget",
      //           onTap: () => Get.to(() => AllCategoriesScreen()),
      //           buttonText: "See More >",
      //         ),
      //
      //         // calling categories Widget
      //         CategoriesWidget(),
      //
      //         // calling heading Widget
      //         HeadingWidget(
      //           headingTitle: "Flash Sale..",
      //           headingSubTitle: "According to your budget",
      //           onTap: () => Get.to(() => AllFlashSaleProductsScreen()),
      //           buttonText: "See More >",
      //         ),
      //
      //         // calling flash-sale Widget
      //         FlashSaleWidget(),
      //
      //
      //         // calling heading Widget
      //         HeadingWidget(
      //           headingTitle: "Popular Products..",
      //           headingSubTitle: "According to your budget",
      //           onTap: () => Get.to(() => AllProductsScreen()),
      //           buttonText: "See More >",
      //         ),
      //
      //         AllProductsWidget(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}