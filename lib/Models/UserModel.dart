class UserModel {
  String? email;
  String? password;
  late String uId;
  String? name;

  UserModel({
    this.email,
    required this.name,
    this.password,
    this.uId = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'uId': uId,
    };
  }

  UserModel.fromJson(Map<String, dynamic> Json) {
    email = Json['email'];

    name = Json['name'];
    password = Json['password'];
    uId = Json['uId'];
  }
}
