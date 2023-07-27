class UserDetailsModel {
  UserDetailsModel({
      this.id, 
      this.fcmToken, 
      this.fullName, 
      this.email, 
      this.username,});

  UserDetailsModel.fromJson(dynamic json) {
    id = json['_id'];
    fcmToken = json['fcmToken'];
    fullName = json['fullName'];
    email = json['email'];
    username = json['username'];
  }
  String? id;
  String? fcmToken;
  String? fullName;
  String? email;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fcmToken'] = fcmToken;
    map['fullName'] = fullName;
    map['email'] = email;
    map['username'] = username;
    return map;
  }

}