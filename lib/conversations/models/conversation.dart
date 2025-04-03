class Conversation {
  final String id;
  final String name;
  final String clientId;
  final String lastMessage;
  final String avatarUrl;
  final String time;
  final bool isRead;
  final int unreadCount;

  Conversation({
    required this.id,
    required this.name,
    required this.clientId,
    required this.lastMessage,
    required this.avatarUrl,
    required this.time,
    required this.isRead,
    required this.unreadCount,
  });

  factory Conversation.fromJsonWithId({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return Conversation(
      id: id,
      name: json['name'] as String,
      clientId: json['clientId'] as String,
      lastMessage: json['lastMessage'] as String,
      avatarUrl: json['avatarUrl'] as String,
      time: json['time'] as String,
      isRead: json['isRead'] as bool,
      unreadCount: json['unreadCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'clientId': clientId,
      'lastMessage': lastMessage,
      'avatarUrl': avatarUrl,
      'time': time,
      'isRead': isRead,
      'unreadCount': unreadCount,
    };
  }
}
