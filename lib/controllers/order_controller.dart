import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/cart_item_model.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:logger/logger.dart';

class OrderController {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

    // ------- save order details in cloud firestore
    Future<String> saveOrder(UserModel userModel, double total, List<CartItemModel> items) async {

      // getting a unique id
      String id = orders.doc().id;

      // temporary list
      var list = [];

      // read the cart items list and add items to a dynamic list
      // because we can only store dynamic type arrays in firestore
      for (var i=0; i<items.length; i++) {
        list.add(items[i].toJson());
      }

      // Call the orders's CollectionReference to add a new order
      return orders
        .doc(id)
        .set({
            'id': id,
            'userModel': userModel.toJson(),
            'total': total,
            'items': list,
            'orderStatus' : "pending",
          })
          .then((value) {
            Logger().i("Order Created");
            return "Success";
          })
          .catchError((error) {
            Logger().e("Failed to create the order: $error");
            return "$error";
          }
        );
    }

    // fetch product data from cloudfirestore
  Future<List<OrderModel>> fetchOrderList(String uid) async {
    try {
      // firebase query that find and fetch products list
      QuerySnapshot querySnapshot = await orders.where("user.uid", isEqualTo: uid).get();

      Logger().w(querySnapshot.docs.length);

      // Order list
      List<OrderModel> orderList = [];

      for (var e in querySnapshot.docs) {
        // mapping to order model
        OrderModel model = OrderModel.fromJson(e.data() as Map<String, dynamic>);

        // adding to the list
        orderList.add(model);
      }

      return orderList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}