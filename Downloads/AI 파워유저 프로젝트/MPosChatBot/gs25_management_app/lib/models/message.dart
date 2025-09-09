class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? id;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.id,
  });

  factory Message.user(String text) {
    return Message(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  factory Message.bot(String text) {
    return Message(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'id': id,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
      id: json['id'],
    );
  }
}