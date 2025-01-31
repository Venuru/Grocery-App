import 'package:animated_snack_bar/animated_snack_bar.dart';
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

      AlertHelper.showSnackBar(context, "Increased the product amount", type: AnimatedSnackBarType.success);

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

      AlertHelper.showSnackBar(context, "Added to the cart", type: AnimatedSnackBarType.success);

      Logger().w(_cartItems.length);
      
      notifyListeners();
    }
  }

  // calculate and get total cart item count
  int get getCartTotalItemCount {
    int temp = 0;

    // reading the cart item list and get the sum of amount values as the cart item count
    for (var i=0; i < _cartItems.length; i++) {
        temp += cartItems[i].productAmount;
    }
    return temp;
  }

  // calculate and get total price
  double get getCartTotalPrice {
    double temp = 0;

    // reading the cart item list and get the sum of subtotal values as the cart item total price
    for (var i=0; i < _cartItems.length; i++) {
        temp += cartItems[i].subTotal;
    }
    return temp;
  }

  // Increase the cart item amount
  void increaseCartItemAmount(String cartId) {
    // find the existing cart product item
    var temp = _cartItems.singleWhere((e) => e.id == cartId);

    // update the amount
    temp.productAmount ++;

    // calcualte the subtotal acording to the new amount
    temp.subTotal = temp.productAmount * double.parse(temp.productModel.productPrice);

    notifyListeners();
  }

  // decrease the cart item amount
  void decreaseCartItemAmount(String cartId) {
    // find the existing cart product item
    var temp = _cartItems.singleWhere((e) => e.id == cartId);

    // check whether amount is 1
    if (temp.productAmount == 1) {
      // if the amount is 1, remove the item from the cart
      removeCartItem(cartId);
    }else {
      // update the amount
      temp.productAmount --;

      // calcualte the subtotal acording to the new amount
      temp.subTotal = temp.productAmount * double.parse(temp.productModel.productPrice);

      notifyListeners();
    }
  }

  // remove the cart item by id
  void removeCartItem(String cartId) {
    // find the existing cart product item
    var temp = _cartItems.removeWhere((e) => e.id == cartId);

    notifyListeners();
  }
}