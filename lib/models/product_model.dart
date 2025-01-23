class ProductModel {
  String id;
  String productName;
  String productDec;
  String productPrice;
  String productImg;

  ProductModel(this.id, this.productName, this.productDec, this.productPrice, this.productImg);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productDec': productDec,
      'productPrice': productPrice,
      'productImg' : productImg,
    };
  }

  // bind json data to user model
  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      map['id'] as String,
      map['productName'] as String,
      map['productDec'] as String,
      map['productPrice'] as String,
      map['productImg'] as String,
    );
  }
}
