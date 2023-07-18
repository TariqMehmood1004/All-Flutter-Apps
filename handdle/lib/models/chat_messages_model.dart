enum Type {
  text,
  image,
  audio,
}

Type getTypeFromJson(Map<String, dynamic> json) {
  String typeString = json['type'].toString();

  if (typeString == Type.image.toString()) {
    return Type.image;
  } else if (typeString == Type.audio.toString()) {
    return Type.audio;
  } else {
    return Type.text;
  }
}

class MessagesModel {
  MessagesModel({
    required this.fromId,
    required this.toId,
    required this.msg,
    required this.sentTime,
    required this.readTime,
    required this.type,
  });

  late String fromId;
  late String toId;
  late String msg;
  late String sentTime;
  late String readTime;
  late Type type;

  MessagesModel.fromJson(Map<String, dynamic> json) {
    fromId = json['fromId'].toString();
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    sentTime = json['sentTime'].toString();
    readTime = json['readTime'].toString();
    type = getTypeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['toId'] = toId;
    data['msg'] = msg;
    data['sentTime'] = sentTime;
    data['readTime'] = readTime;
    data['type'] = type.name;
    return data;
  }
}
