import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/record_voice_screen/record_voice_screen.dart';
import 'package:ecommerce_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => _chooseImage(),
                      child: const MyIcon(
                        icon: AppAssets.icCamera,
                      ),
                    ),
                  ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => _navigateRecordVoiceScreen(),
                      child: const MyIcon(
                        icon: AppAssets.icMic,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          MyIconButton(
              onPressed: () => _sendTextMessage(),
              icon: const MyIcon(
                icon: AppAssets.icSend,
              ),
              size: 50,
              color: AppColors.primaryColor)
        ],
      ),
    );
  }

  Future<void> _getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    if (!context.mounted) return;
    Navigator.of(context).pop();
    await ChatService().sendImageMessage(image.path);
  }

  Future<void> _getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (!context.mounted) return;
    Navigator.of(context).pop();
    await ChatService().sendImageMessage(image.path);
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
      final content = _messageController.text;
      _messageController.clear();
      await ChatService().sendTextMessage(content);
    }
  }

  _navigateRecordVoiceScreen() {
    Navigator.pushNamed(context, RecordVoiceScreen.routeName);
  }
}
