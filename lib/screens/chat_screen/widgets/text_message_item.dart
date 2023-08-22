import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';

class TextMessageItem extends StatelessWidget {
  const TextMessageItem({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    final userId = firebaseAuth.currentUser!.uid;
    final isUser = message.senderId == userId;
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: size.width * 0.6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: isUser ? AppColors.greyColor : AppColors.primaryColor,
                borderRadius: isUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
            child: Text(
              message.content,
              style: AppStyles.bodyLarge.copyWith(
                  color:
                      isUser ? AppColors.primaryColor : AppColors.whiteColor),
            ),
          ),
          Text(
            message.timestamp.formattedDateChat(),
          )
        ],
      ),
    );
  }
}
