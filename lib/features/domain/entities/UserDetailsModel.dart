class UserDetailsModel {
  UserDetailsModel({
    this.id,
    this.fcmToken,
    this.fullName,
    this.imageUrl,
    this.email,
    this.username,
    this.follower,
    this.following,});

  UserDetailsModel.fromJson(dynamic json) {
    id = json['_id'];
    fcmToken = json['fcmToken'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    username = json['username'];
    follower = json['follower'] != null ? json['follower'].cast<String>() : [];
    following = json['following'] != null ? json['following'].cast<String>() : [];
  }
  String? id;
  String? fcmToken;
  String? fullName;
  String? imageUrl;
  String? email;
  String? username;
  List<String>? follower;
  List<String>? following;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fcmToken'] = fcmToken;
    map['fullName'] = fullName;
    map['imageUrl'] = imageUrl;
    map['email'] = email;
    map['username'] = username;
    map['follower'] = follower;
    map['following'] = following;
    return map;
  }

}