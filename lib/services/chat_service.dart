import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/chat_room.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/chat_util.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatService {
  final String chatRoomId = FirebaseAuth.instance.currentUser!.uid;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> sendTextMessage(String content) async {
    final String messageId =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    Message message = Message(
        id: messageId,
        senderId: userId,
        content: content.trim(),
        imageUrl: '',
        audioUrl: '',
        isRead: false,
        type: MessageType.text,
        timestamp: DateTime.now());
    await chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  Future<void> sendImageMessage(List<XFile> images) async {
    final String info =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    for (int i = 0; i < images.length; i++) {
      final messageId = info + i.toString();
      final imageFile = File(images[i].path);
      final compressImageFile = await ChatUtil().compressImage(imageFile);
      try {
        final storageRef =
            FirebaseStorage.instance.ref().child('chat/chat_img');
        final task = await storageRef
            .child(
                '${userId + DateTime.now().millisecondsSinceEpoch.toString()}.jpg')
            .putFile(compressImageFile);
        final linkImage = await task.ref.getDownloadURL();
        Message message = Message(
            id: messageId,
            senderId: userId,
            content: '',
            imageUrl: linkImage,
            audioUrl: '',
            isRead: false,
            type: MessageType.image,
            timestamp: DateTime.now());
        await chatRoomsRef
            .doc(chatRoomId)
            .collection('messages')
            .doc(messageId)
            .set(message.toMap());
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> sendVoiceMessage(String filePath) async {
    final String messageId =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('chat/chat_voice');
      final task = await storageRef
          .child(
              '$userId${DateTime.now().millisecondsSinceEpoch.toString()}.mp3')
          .putFile(File(filePath));
      final linkAudio = await task.ref.getDownloadURL();
      Message message = Message(
          id: messageId,
          senderId: userId,
          content: '',
          imageUrl: '',
          audioUrl: linkAudio,
          isRead: false,
          type: MessageType.voice,
          timestamp: DateTime.now());
      await chatRoomsRef
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot> getMessages() {
    return chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> checkAndCreateChatRoom(String name, String imgUrl) async {
    final QuerySnapshot existingRooms =
        await chatRoomsRef.where('id', isEqualTo: chatRoomId).get();

    if (existingRooms.docs.isEmpty) {
      final ChatRoom roomData = ChatRoom(
          id: chatRoomId,
          name: name,
          imgUrl: imgUrl,
          createdAt: DateTime.now());

      await chatRoomsRef.doc(chatRoomId).set(roomData.toMap());
    } else {}
  }

  void markMessageAsRead(String messageId) {
    final messageRef =
        chatRoomsRef.doc(chatRoomId).collection('messages').doc(messageId);
    messageRef.update({
      'isRead': true,
    });
  }
}
