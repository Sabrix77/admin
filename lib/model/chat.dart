class Chat {
  String id;
  String name;
  String? lastContent;
  String? timeStamp;

  Chat({required this.id, required this.name, this.lastContent, this.timeStamp});

  Chat.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          lastContent: json['lastContent'],
          timeStamp: json['timeStamp']
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "lastContent": lastContent,
      "timeStamp":timeStamp
    };
  }
}
