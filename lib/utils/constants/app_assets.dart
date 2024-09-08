class AppAssets {

  String imgName;
  String iconName;

  AppAssets({required this.imgName, required this.iconName});
  
  // Store all the icons/ images path used insdie the app here.
  static String getImgName(String imgName) {
    return "assets/images/$imgName";
  }

  static String getIconName(String iconName) {
    return "assets/icons/$iconName";
  }
}