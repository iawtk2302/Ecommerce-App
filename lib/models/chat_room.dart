class ChatRoom {
  final String id;
  final String name;
  final String imgUrl;
  final DateTime createdAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.createdAt,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> data) {
    return ChatRoom(
      id: data['id'],
      name: data['name'] ?? '',
      imgUrl: data['imgUrl'],
      createdAt: data['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'imgUrl': imgUrl,
      'createdAt': createdAt,
    };
  }
}
