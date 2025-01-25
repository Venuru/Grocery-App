import 'package:grocery_app/models/product_model.dart';

class CartItemModel {
  String id;
  int productAmount;
  double subTotal;
  ProductModel productModel;

  CartItemModel({required this.id, required this.productAmount, required this.subTotal, required this.productModel});
  
  // bind json data to user model
  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      productAmount: map['productAmount'] as int,
      subTotal: map['subTotal'] as double,
      productModel: ProductModel.fromJson(map['productModel'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'productAmount': productAmount,
      'subTotal': subTotal,
      'productModel': productModel.toJson(),
    };
  }
}
