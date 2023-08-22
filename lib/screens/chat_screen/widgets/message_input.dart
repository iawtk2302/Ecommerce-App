import 'dart:io';

import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_ink_well.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/repositories/chat_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatefulWidget {
  const MessageInput(
      {super.key, required this.userId, required this.chatRoomId});
  final String userId;
  final String chatRoomId;
  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.greyColor, width: 2)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => _chooseImage(),
                      icon: const Icon(
                        Icons.camera_alt,
                      )),
                  Container(
                    width: 2,
                    height: 40,
                    color: AppColors.greyColor,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 12),
                          border: InputBorder.none,
                          hintText: 'Type message...'),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => _sendTextMessage(),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.send,
                color: AppColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final temp = File(image.path);
    Navigator.of(context).pop();
    final storageRef = FirebaseStorage.instance.ref().child('chat/chat_img');
    final task = await storageRef
        .child('${widget.userId + DateTime.now().toString()}.jpg')
        .putFile(temp);
    final linkImage = await task.ref.getDownloadURL();
    Message message = Message(
        id: '',
        senderId: widget.userId,
        content: '',
        imageUrl: linkImage,
        audioUrl: '',
        type: MessageType.image,
        timestamp: DateTime.now());
    ChatRepository().sendMessage(widget.chatRoomId, message);
  }

  Future<void> _getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final temp = File(image.path);
    Navigator.of(context).pop();
    final storageRef = FirebaseStorage.instance.ref().child('chat/chat_img');
    final task = await storageRef
        .child('${widget.userId + DateTime.now().toString()}.jpg')
        .putFile(temp);
    final linkImage = await task.ref.getDownloadURL();
    Message message = Message(
        id: '',
        senderId: widget.userId,
        content: '',
        imageUrl: linkImage,
        audioUrl: '',
        type: MessageType.image,
        timestamp: DateTime.now());
    ChatRepository().sendMessage(widget.chatRoomId, message);
  }

  _chooseImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          width: size.width,
          height: size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Image',
                style: AppStyles.displayMedium
                    .copyWith(color: AppColors.primaryColor),
              ),
              InkWell(
                onTap: () => _getImageCamera(),
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Take A Photo',
                      style: AppStyles.labelMedium
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _getImageGallery(),
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Choose From Library',
                      style: AppStyles.labelMedium
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _sendTextMessage() async {
    if (_messageController.text.isNotEmpty) {
      Message message = Message(
          id: '',
          senderId: widget.userId,
          content: _messageController.text.trim(),
          imageUrl: '',
          audioUrl: '',
          type: MessageType.text,
          timestamp: DateTime.now());
      _messageController.clear();
      await ChatRepository().sendMessage(widget.chatRoomId, message);
    }
  }
}
