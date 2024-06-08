class ChatListModel {
  String sId;
  List participants;
  String name;
  String type;
  String creator;
  String image;
  String sender;
  String message;
  String createdAt;
  String updatedAt;
  num iV;

  ChatListModel(
      {required this.sId,
        required this.participants,
        required this.name,
        required this.type,
        required this.creator,
        required this.image,
        required this.message,
        required this.sender,
        required this.createdAt,
        required this.updatedAt,
        required this.iV});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    String sId = json['_id'] ?? "";
    List participants = json['participants'] ?? [];
    String name = json['name'] ?? "";
    String type = json['type'] ?? "";
    String creator = json['creator'] ?? "";
    String image = json['image'] ?? "";
    Map lastMessage = json['lastMessage'] ?? {};
    String sender = lastMessage.isNotEmpty ? lastMessage['sender'] ?? "" : "";
    String message = lastMessage.isNotEmpty ? lastMessage['message'] ?? "" : "";
    String createdAt = json['createdAt'] ?? "";
    String updatedAt = json['updatedAt'] ?? "";
    num iV = json['__v'] ?? 0;

    return ChatListModel(
        image: image,
        createdAt: createdAt,
        creator: creator,
        iV: iV,
        message: message,
        name: name,
        participants: participants,
        sender: sender,
        sId: sId,
        type: type,
        updatedAt: updatedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'participants': participants,
      'name': name,
      'type': type,
      'creator': creator,
      'image': image,
      'lastMessage': {
        'sender': sender,
        'message': message
      },
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
