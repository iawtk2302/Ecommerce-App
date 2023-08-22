import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageMessageItem extends StatefulWidget {
  const ImageMessageItem({super.key, required this.message});
  final Message message;

  @override
  State<ImageMessageItem> createState() => _ImageMessageItemState();
}

class _ImageMessageItemState extends State<ImageMessageItem> {
  @override
  Widget build(BuildContext context) {
    final userId = firebaseAuth.currentUser!.uid;
    final isUser = widget.message.senderId == userId;
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CachedNetworkImage(
            imageUrl: widget.message.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              constraints: const BoxConstraints(maxWidth: 200, minHeight: 100),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: const Color(0xFFF5F5F5),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 200, minHeight: 100),
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),
            ), // Loading placeholder
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)), // Error widget
          ),
          Text(
            widget.message.timestamp.formattedDateChat(),
          )
        ],
      ),
    );
  }
}
