import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/controllers/file_upload_controller.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:logger/logger.dart';

class AdminController {
    // create a collection reference called products
  CollectionReference products = FirebaseFirestore.instance.collection('users');

  // file upload controller
  final FileUploadController _fileUploadController = FileUploadController();

  // ------- save prodcuts data in cloud firestore
  Future<void> saveProductData(String productName, String productDec, String productPrice, File file) async {

    // first upload the file and get download url to product image
    final String downloadUrl = await _fileUploadController.uploadFile(file, "productImages");

    if(downloadUrl != "") {
    // getting a unique id
    String id = products.doc().id;

    // Call the prodcuts's CollectionReference to add a new prodcuts
    return products
      .add({
          'uid': id,
          'productName': productName,
          'productDec': productDec,
          'productPrice': productPrice,
          'productImg' : downloadUrl,
        }
      )
      .then((value) => Logger().i("Product Added"))
      .catchError((error) => Logger().e("Failed to Product user: $error"));
    }else{
      Logger().e("download url is empty");
    }
  }

  // fetch product data from cloudfirestore
  Future<List<ProductModel>> fetchProductList() async {
    try {
      // firebase query that find and fetch products list
      QuerySnapshot querySnapshot = await products.get();

      Logger().w(querySnapshot.docs.length);

      // product list
      List<ProductModel> ProductList = [];

      for (var e in querySnapshot.docs) {
        // mapping to product model
        ProductModel model = ProductModel.fromJson(e.data() as Map<String, dynamic>);

        // adding to the list
        ProductList.add(model);
      }

      return ProductList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}