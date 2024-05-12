import 'package:flutter/material.dart';
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
            // Button for Users
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllUsersScreen()),
                );
                showSnackbar(context, 'Users');
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                'Users',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppConstant.appMainColor),
              ),
            ),
            SizedBox(height: 20),
            // Button for Orders
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllOrdersScreen()),
                );
                showSnackbar(context, 'Orders');
              },
              icon: Icon(Icons.shopping_bag, color: Colors.white),
              label: Text(
                'Orders',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppConstant.appMainColor),
              ),
            ),
            SizedBox(height: 20),
            // Button for Products
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllProductsScreen()),
                );
                showSnackbar(context, 'Products');
              },
              icon: Icon(Icons.production_quantity_limits, color: Colors.white),
              label: Text(
                'Products',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppConstant.appMainColor),
              ),
            ),
            SizedBox(height: 20),
            // Button for Categories
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllCategoriesScreen()),
                // );
                // showSnackbar(context, 'Categories');
              },
              icon: Icon(Icons.category, color: Colors.white),
              label: Text(
                'Categories',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppConstant.appMainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $title Screen...'),
        backgroundColor: AppConstant.appMainColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
