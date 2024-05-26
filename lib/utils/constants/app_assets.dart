class AppAssets {

  String imgName;

  AppAssets({required this.imgName});
  
  // Store all the icons/ images path used insdie the app here.
  static String getImgName(String imgName) {
    // ignore: unused_local_variable
    return "assets/images/$imgName";
  }
}