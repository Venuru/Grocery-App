import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart_item_model.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:logger/logger.dart';

class CartProvider extends ChangeNotifier {
  // cart counter
  int _counter = 1;

  // get counter
  int get counter => _counter;

  // increase the cart counter
  void increaseCounter() {
    _counter++;
    notifyListeners();
  }

  // decrease the cart counter
  void decreaseCounter() {
    if (_counter != 1) {
      _counter--;
      notifyListeners();
    }
  }

  // clear the amount
  void clearAmount() {
    _counter = 1;
    notifyListeners();
  }

  // Add to cart

  // cartItem list
  List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  // intialize add to cart functionality
  void addToCart(ProductModel productModel, BuildContext context) {

    // first check whether adding product is already in the cart item list
    if(_cartItems.any((e) => e.id == productModel.id)) {
      // if product is already in the cart item list, increase the quantity of the existing product

      // find the existing cart product item
      var temp = _cartItems.singleWhere((e) => e.id == productModel.id);

      // update the amount
      temp.productAmount += _counter;

      // calcualte the subtotal acording to the new amount
      temp.subTotal = temp.productAmount * double.parse(productModel.productPrice);

      // clear the amount
      clearAmount();

      AlertHelper.showAlert(context, 'Success', "Increased the product amount", dialogType: DialogType.success);

      notifyListeners();
    }else{
      _cartItems.add(
        CartItemModel(
          id: productModel.id, 
          productAmount: _counter, 
          subTotal: _counter + double.parse(productModel.productPrice), 
          productModel: productModel
        )
      );
    
      // clear the amount
      clearAmount();

      AlertHelper.showAlert(context, 'Success', "Added to the cart", dialogType: DialogType.success);

      Logger().w(_cartItems.length);
      
      notifyListeners();
    }
  }
}