import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_constant.dart';

class AddProductImagesController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> SelectedImages = <XFile>[].obs;
  final RxList<String> arrImagesUrl = <String>[].obs;

  final FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<void> showImagesPickerDialog() async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if(androidDeviceInfo.version.sdkInt <= 32){
      status = await Permission.storage.request();
    }
    else{
      status = await Permission.mediaLibrary.request();
    }

    if(status == PermissionStatus.granted){
      Get.defaultDialog(
        title: "Choose Image",
        middleText: "Do You Want To Pick Image From Camera Or Gallery??",
        actions: [
          ElevatedButton(
              onPressed: (){
                SelectImages("Camera");
              }, child: Text("Camera"),
          ),
          ElevatedButton(
              onPressed: (){
                SelectImages("Gallery");
              }, child: Text("Gallery"),
          ),
        ]
      );
    }
    if(status == PermissionStatus.denied){
      print("Error... Please Allow Permissions For Further Usage");
      openAppSettings();
    }
    if(status == PermissionStatus.permanentlyDenied){
      print("Error... Please Allow Permissions For Further Usage");
      openAppSettings();
    }
  }

  Future<void> SelectImages(String type) async {
    List<XFile> imgs = [];
    if(type == "Gallery"){
      try{
        imgs = await _picker.pickMultiImage(imageQuality: 85);
        update();
      }catch(e){
        Get.snackbar(
            "Error",
            "$e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondaryColor,
            colorText: AppConstant.appTextColor
        );
      }
    }else{
      final img =
           await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);

      if(img != null){
        imgs.add(img);
        update();
      }
    }

    if(imgs.isNotEmpty){
      SelectedImages.addAll(imgs);
      update();
      print(SelectedImages.length);
    }
  }

  void removeImages(int index){
    SelectedImages.removeAt(index);
    update();
  }
}

