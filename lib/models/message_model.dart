class MessageModel {
  String sId;
  String chat;
  String message;
  String sender;
  String name;
  String image;
  String messageType;
  String createdAt;
  String updatedAt;

  MessageModel({
    required this.sId,
    required this.chat,
    required this.message,
    required this.sender,
    required this.name,
    required this.image,
    required this.messageType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String sId = json['_id'] ?? "";
    String chat = json['chat'] ?? "";
    String message = json['message'] ?? "";
    String sender = json['sender']['_id'] ?? "";
    String messageType = json['messageType'] ?? "";
    String createdAt = json['createdAt'] ?? "";
    String updatedAt = json['updatedAt'] ?? "";
    String name = json['name'] ?? "";
    String image = json['image'] ?? "";


    return MessageModel(sId: sId,
        chat: chat,
        message: message,
        sender: sender,
        name: name,
        image: image,
        updatedAt: updatedAt,
        createdAt: createdAt,
        messageType: messageType);
  }
}
