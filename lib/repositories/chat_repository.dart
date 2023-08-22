import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/chat_room.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class ChatRepository {
  Future<void> sendMessage(String chatRoomId, Message message) async {
    await chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      chatRoomsRef
          .doc(chatRoomId)
          .collection('messages')
          .doc(value.id)
          .update({'id': value.id});
    });
  }

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> checkAndCreateChatRoom(
      String userId, String name, String imgUrl) async {
    List<String> ids = [userId, 'admin'];
    ids.sort();
    String id = ids.join('_');
    final QuerySnapshot existingRooms =
        await chatRoomsRef.where('id', isEqualTo: id).get();

    if (existingRooms.docs.isEmpty) {
      final ChatRoom roomData = ChatRoom(
          id: id, name: name, imgUrl: imgUrl, createdAt: DateTime.now());

      await chatRoomsRef.doc(id).set(roomData.toMap());
    } else {}
  }
}
