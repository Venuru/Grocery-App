import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/admin_controller.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:logger/logger.dart';

class ProductProvider extends ChangeNotifier {

  final AdminController _adminController = AdminController();
    
  //------ Loader state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----- set Loader state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------- usermodel object to store user objects
  List<ProductModel> _products = [];
  
  List<ProductModel> get products => _products;

  //------- start fetch user data
  Future<void> startFetchProductList() async {
    try {
      // start the loader
      setLoading(true);
      await _adminController.fetchProductList().then(
        (value) {
          _products = value;
          notifyListeners();

          // stop the loader
          setLoading(false);
        }
      );
    }catch (e) {
      Logger().e(e);
      // stop the loader
      setLoading(false);
    }
  }

  //----------product details section
  
  // to store the selected product model
  late ProductModel _productModel;

  // get the selected product model
  ProductModel get productModel => _productModel;

  // set the product model when clicked on the product card
  set setProduct(ProductModel model) {
    _productModel = model;
    notifyListeners();
  }

  // get related products excluding the selected products
  List<ProductModel> get relatedProducts {
    List<ProductModel> temp = [];

    // reading the product list and return without already selected products
    for (var i=0; i < _products.length; i++) {
      if(_products[i].id != productModel.id) {
        temp.add(_products[i]);
      }
    }
    return temp;
  }
}