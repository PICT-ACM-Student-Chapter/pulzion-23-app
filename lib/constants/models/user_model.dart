class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? college;
  String? year;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.college,
      this.year,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    mobileNumber = json["mobile_number"];
    college = json["college"];
    year = json["year"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["email"] = email;
    data["mobile_number"] = mobileNumber;
    data["college"] = college;
    data["year"] = year;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

// Creating a singleton class for user token
class UserToken {
  String? token;

  UserToken._privateConstructor();

  static final UserToken _instance = UserToken._privateConstructor();

  factory UserToken() {
    return _instance;
  }
}
