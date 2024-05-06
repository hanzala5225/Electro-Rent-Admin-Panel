class CartModel{
  final String productId;
  final String categoryId;
  final String productName;
  final String categoryName;
  final String salePrice;
  final String rentPrice;
  final String deliveryTime;
  final bool isSale;
  final List productImages;
  final String productDescription;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int productQuantity;
  final double productTotalPrice;

CartModel({
  required this.productId,
  required this.categoryId,
  required this.productName,
  required this.categoryName,
  required this.salePrice,
  required this.rentPrice,
  required this.deliveryTime,
  required this.isSale,
  required this.productImages,
  required this.productDescription,
  required this.createdAt,
  required this.updatedAt,
  required this.productQuantity,
  required this.productTotalPrice,
});

  Map<String, dynamic> toMap(){
    return {
      'productId': productId,
      'categoryId': categoryId,
      'productName': productName,
      'categoryName': categoryName,
      'salePrice': salePrice,
      'rentPrice': rentPrice,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'productImages': productImages,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
    };
  }

  // creating a UserModel instance from a JSON map
  factory CartModel.fromMap(Map<String, dynamic> json){
    return CartModel(
      productId: json['productId'],
      categoryId: json['categoryId'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      salePrice: json['salePrice'],
      rentPrice: json['rentPrice'],
      deliveryTime: json['deliveryTime'],
      isSale: json['isSale'],
      productImages: json['productImages'],
      productDescription: json['productDescription'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
    );
  }
}
