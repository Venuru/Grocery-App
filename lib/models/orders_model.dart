import 'package:grocery_app/models/cart_item_model.dart';
import 'package:grocery_app/models/user_model.dart';

class OrderModel {
  String id;
  UserModel userModel;
  double total;
  List<CartItemModel> items;
  String orderStatus;

  OrderModel({
    required this.id,
    required this.userModel,
    required this.total,
    required this.items,
    required this.orderStatus,
  });

  // bind json data to user model
  OrderModel.fromJson(Map<String, dynamic> json) 
      : id = json['id'],
        userModel = UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
        total = (json['total'] as num).toDouble(),
        items = (json['items'] as List<dynamic>).map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)).toList(),
        orderStatus = json['orderStatus'];
}