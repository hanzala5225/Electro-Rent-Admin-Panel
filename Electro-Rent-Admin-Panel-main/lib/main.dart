import 'dart:typed_data';

import 'package:admin_panel/screens/main_screen.dart';
import 'package:admin_panel/utils/app_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    _loadModel();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appMainName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }

  Future<void> _loadModel() async {
    try {
      ByteData modelData = await rootBundle.load('assets/best.pt');
      if (modelData != null) {
        print('Model loaded successfully');
      } else {
        print('Error: Model file not found or could not be loaded');
      }
    } catch (e) {
      print('Error loading model: $e');
    }
  }
}