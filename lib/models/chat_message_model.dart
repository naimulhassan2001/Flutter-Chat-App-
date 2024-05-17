class ChatMessageModel {
  final String time;
  final String message;
  final String image;
  final bool isMe;
  final bool isNotice;

  ChatMessageModel({
    required this.time,
    required this.message,
    required this.image,
    required this.isMe,
    this.isNotice = false,
  });
}