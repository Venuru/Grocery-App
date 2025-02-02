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
}