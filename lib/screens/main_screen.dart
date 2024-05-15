import 'package:admin_panel/screens/All-Categories-Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the Get package
import '../utils/app_constant.dart';
import '../widgets/Custom_Drawer.dart';
import 'All-Orders-Screen.dart';
import 'All-Products-Screen.dart';
import 'All-Users-Screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, 'Users', Icons.person, AllUsersScreen()),
            SizedBox(height: 20),
            buildButton(context, 'Orders', Icons.shopping_bag, AllOrdersScreen()),
            SizedBox(height: 20),
            buildButton(context, 'Products', Icons.production_quantity_limits, AllProductsScreen()),
            SizedBox(height: 20),
            buildButton(context, 'Categories', Icons.category, AllCategoriesScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, IconData icon, Widget? screen) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10),
        SizedBox(
          width: 190,
          height: 50, // Adjust the height as needed
          child: ElevatedButton.icon(
            onPressed: () {
              if (screen != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen),
                );
                Get.snackbar(
                  "PLEASE WAIT",
                  "Navigating to $title Screen...",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppConstant.appSecondaryColor,
                  colorText: AppConstant.appTextColor,
                  duration: Duration(seconds: 2),
                );
              } else {
                // Handle logic when screen is null
              }
            },
            icon: Icon(icon, color: Colors.white),
            label: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppConstant.appMainColor),
            ),
          ),
        ),
      ],
    );
  }
}
