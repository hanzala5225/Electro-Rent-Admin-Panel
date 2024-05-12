import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class CategoryDropDownController extends GetxController{
  RxList<Map<String,dynamic>> categories = <Map<String,dynamic>>[].obs;

  RxString ? selectedCategoryId;
  RxString ? selectedCategoryName;

  @override
  void onInit(){
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot
      = await FirebaseFirestore.instance.collection("categories").get();

      List<Map<String,dynamic>> categoriesList = [];
      querySnapshot.docs
          .forEach(
              (DocumentSnapshot<Map<String,dynamic>> document) {
        categoriesList.add({
          'categoryId': document.id,
          'categoryName': document['categoryName'],
          'categoryImg': document['categoryImg'],
        });
      });
      setCategoriesList(categoriesList);

      categories.value = categoriesList;
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
  }

  // set selected category
    void setSelectedCategory(String? categoryId){
      selectedCategoryId = categoryId?.obs;
      categoriesList.forEach((element) {
        if(element['categoryId'] == categoryId){
          setSelectedCategoryName(element['categoryName']);
        }
      });
      print('Value: ${selectedCategoryId}');
      print('Value: ${selectedCategoryName}');
      update();
    }

    Future<String?> getCategoryName(String? categoryId) async {
    try{
      DocumentSnapshot<Map<String,dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("categories").doc(categoryId).get();

      if(snapshot.exists){
        return snapshot.data()?["categoryName"];
      }
      else{
        return null;
      }
    }catch(e){
      Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondaryColor,
          colorText: AppConstant.appTextColor,);

      return null;
    }
  }
  // set selected category
  void setSelectedCategoryName(String? categoryName){
    selectedCategoryName = categoryName?.obs;
    update();
  }

  List<Map<String,dynamic>> categoriesList= [];
  void setCategoriesList(List<Map<String,dynamic>>  values){
    categoriesList = values;
    update();
  }
}