class Message {
  String id;
  String senderId;
  int timestamp;
  String content;

  //String senderName;

  Message(
      {required this.id,
      required this.senderId,
      required this.content,
      required this.timestamp});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          content: json['content'],
          senderId: json['senderId'],
          timestamp: json['timestamp'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "senderId": senderId,
      "timestamp": timestamp,
    };
  }
}
