import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/order_controller.dart';
import 'package:grocery_app/models/cart_item_model.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/providers/auth/auth_providers.dart';
import 'package:grocery_app/providers/home/cart_provider.dart';
import 'package:grocery_app/screens/main/cart/widgets/bottom_section.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  // order controller object
  final OrderController _orderController = OrderController();

  //------ creating order Loader state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----- set Loader state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // start creating the order
  Future<void> startCreateOrder(BuildContext context) async {
    try {
      // get cart item list
      List<CartItemModel> items = Provider.of<CartProvider>(context, listen: false).cartItems;

      // get userModel
      UserModel userModel = Provider.of<AuthProviders>(context, listen: false).userModel!;

      // get cart total
      double cartTotal = Provider.of<CartProvider>(context, listen: false).getCartTotalPrice;

      // first check whether the cart item list is not empty
      if(items.isNotEmpty) {
        // start the loader
        setLoading(true);

        await _orderController.saveOrder(userModel, cartTotal, items).then(
          (value) => {
            if (value == "Success") {
              // stop thh loader
              setLoading(false),

              // show sucess dialog box
              showDialog(
                context: context,
                builder: (context) {
                  return const DialogBoxContainer();
                },
              )
            }else {
              // stop thh loader
              setLoading(false),

              AlertHelper.showAlert(context, "Error", value)
            }
          }
        );
      }else {
        // stop thh loader
        setLoading(false);
        AlertHelper.showAlert(context, "Error", "You must add some item to the cart first");
      }

    } catch (e) {
      // stop thh loader
      setLoading(false);
      Logger().e(e);
    }
  }

  // fetch created Orders

  //------ creating order Loader state
  final bool _isFetchingOrders = false;

  bool get isFetchingOrders => _isLoading;

  //----- set Loader state
  void setIsFetchingOrders(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //-------store orider list
  List<OrderModel> _orders = [];
  
  List<OrderModel> get orders => _orders;

  //------- start fetch order data
  Future<void> startGetOrder(BuildContext context) async {
    try {
      // get userModel
      UserModel userModel = Provider.of<AuthProviders>(context, listen: false).userModel!;

      // start the loader
      setIsFetchingOrders(true);
      await OrderController().fetchOrderList(userModel.uid).then(
        (value) {
          _orders = value;
          notifyListeners();

          // stop the loader
          setIsFetchingOrders(false);
        }
      );
    }catch (e) {
      Logger().e(e);
      // stop the loader
      setIsFetchingOrders(false);
    }
  }
}