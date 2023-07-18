class ChatUserModel {
  ChatUserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.about,
    required this.image,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.pushToken,
  });
  late final String id;
  late final String name;
  late final String phoneNumber;
  late final String about;
  late final String image;
  late final String createdAt;
  late final String lastActive;
  late final bool isOnline;
  late final String pushToken;

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['email'];
    about = json['about'];
    image = json['image'];
    createdAt = json['createdAt'];
    lastActive = json['lastActive'];
    isOnline = json['isOnline'];
    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = phoneNumber;
    data['about'] = about;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['lastActive'] = lastActive;
    data['isOnline'] = isOnline;
    data['pushToken'] = pushToken;
    return data;
  }
}
