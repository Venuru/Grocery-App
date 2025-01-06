class UserModel {
  String uid;
  String name;
  String email;
  String img;

  UserModel(this.uid, this.name, this.email, this.img);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'img': img,
    };
  }

  // bind json data to user model
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      map['uid'] as String,
      map['name'] as String,
      map['email'] as String,
      map['img'] as String,
    );
  }
}
