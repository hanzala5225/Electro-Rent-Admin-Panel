import 'package:uuid/uuid.dart';

class GenerateIds{
  String generateProductId(){
    String formattedProductId;
    String uuid = Uuid().v4();

    //customize id generating

    formattedProductId = "Electro-Rent-${uuid.substring(0, 5)}";

    return formattedProductId;
  }
  String generateCategoryId(){
    String formattedCategoryId;
    String uuid = Uuid().v4();

    //customize id generating

    formattedCategoryId = "Electro-Rent-${uuid.substring(0, 5)}";

    return formattedCategoryId;
  }
}
