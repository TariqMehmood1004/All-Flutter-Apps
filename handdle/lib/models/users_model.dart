import 'dart:convert';
import 'dart:math';

class ChatUserModel {
  ChatUserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.about = "Hey, I'm using Handdle!",
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.pushToken,
  }) : image = getRandomImage();

  late String id;
  late String name;
  late String phoneNumber;
  late String about;
  late String image;
  late String createdAt;
  late String lastActive;
  late bool isOnline;
  late String pushToken;

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    about = json['about'] ?? '';
    image = json['image'] ?? getRandomImage() ?? '';
    createdAt = json['createdAt'] ?? '';
    lastActive = json['lastActive'] ?? '';
    isOnline = json['isOnline'] ?? '';
    pushToken = json['pushToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['about'] = about;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['lastActive'] = lastActive;
    data['isOnline'] = isOnline;
    data['pushToken'] = pushToken;
    return data;
  }

  static String getRandomImage() {
    const List<String> randomImages = [
      "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1605993439219-9d09d2020fa5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1525357816819-392d2380d821?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1522228115018-d838bcce5c3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzB8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1474176857210-7287d38d27c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzd8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1519456264917-42d0aa2e0625?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDF8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDh8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTB8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1555437761-09b788333c79?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1534564533601-4d3e3d9fd229?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    ];

    final random = Random();
    final index = random.nextInt(randomImages.length);
    return randomImages[index];
  }

  static ChatUserModel fromJsonSnapshot(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ChatUserModel.fromJson(json);
  }
}
