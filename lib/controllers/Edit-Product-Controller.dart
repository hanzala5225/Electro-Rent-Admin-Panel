import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/Product-Model.dart';
import '../utils/app_constant.dart';

class EditProductController extends GetxController{
  ProductModel productModel;
  EditProductController({
    required this.productModel
});
  RxList<String> images = <String>[].obs;

  @override
  void onInit(){
    super.onInit();
    getRealTimeImages();
  }

  void getRealTimeImages(){
    FirebaseFirestore.instance
        .collection('products')
        .doc(productModel.productId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if(snapshot.exists){
        final data = snapshot.data() as Map<String, dynamic>?;
        if(data != null && data['productImages'] != null){
          images.value = List<String>.from(data['productImages'] as List<dynamic>);
          update();
        }
      }
    });
  }

  Future DeleteImagesFromStorage(String imageUrl) async{
    final FirebaseStorage storage = FirebaseStorage.instance;
    try{
      Reference reference = storage.refFromURL(imageUrl);
      await reference.delete();
    } catch(e){

      Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondaryColor,
          colorText: AppConstant.appTextColor
      );
    }
  }
}