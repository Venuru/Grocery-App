import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/admin_controller.dart';
import 'package:grocery_app/providers/home/product_provider.dart';
import 'package:grocery_app/utils/helpers/alert_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AdminProvider extends ChangeNotifier {
  
  // admin controller
  final AdminController _adminController = AdminController();

  // productName textField controller
  final TextEditingController _productName = TextEditingController();

  TextEditingController get productName => _productName;

  // productDecription textField controller
  final TextEditingController _productDesc = TextEditingController();

  TextEditingController get productDesc => _productDesc;

  // productPrice textField controller
  final TextEditingController _productPrice = TextEditingController();

  TextEditingController get productPrice => _productPrice;

  //------ Loader state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //----- set Loader state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

    // start the signup process
  Future<void> startSaveProductData(BuildContext context) async {
    try {
        // start the loader
        setLoading(true);
        //start creating the user
        await _adminController.saveProductData(_productName.text, _productDesc.text, _productPrice.text, _productImage).then(
          (value) => {
            // cleatr the controllers
            _productName.clear(),
            _productDesc.clear(),
            _productPrice.clear(),
            _productImage = File(""),

            Provider.of<ProductProvider>(context, listen: false).startFetchProductList(),

            //stop the loader
            setLoading(false),
            AlertHelper.showAlert(context, "Save Product ", "product successfully created", dialogType: DialogType.success)
          }
        );
    } catch (e) {
      Logger().e(e);
      
      setLoading(false);
      AlertHelper.showAlert(context, "Save Product Error", "Server error");
    }
  }

  //------ pick and upload product image

  // image picture object
  final ImagePicker picker = ImagePicker();

  // file object to store picked file
  File _productImage = File("");

  // get picked file
  File get productImage => _productImage;

  // Pick an image function
  Future<void> pickProductImage(BuildContext context) async {
    try{
      final XFile? pickFile = await picker.pickImage(source: ImageSource.camera);

      Logger().w(pickFile?.path);

      // check if the user has picked a file or not
      if (pickFile != null) {
        _productImage = File(pickFile.path);

        notifyListeners();

      }else {
        Logger().w("No image selected");
      }
    }catch (e) {
      Logger().e(e);
    }
  }
}