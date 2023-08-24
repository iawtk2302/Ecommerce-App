import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/services/chat_service.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shimmer/shimmer.dart';

class ImageMessageItem extends StatefulWidget {
  const ImageMessageItem({super.key, required this.message});
  final Message message;

  @override
  State<ImageMessageItem> createState() => _ImageMessageItemState();
}

class _ImageMessageItemState extends State<ImageMessageItem> {
  @override
  void initState() {
    ChatService().markMessageAsRead(widget.message.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = firebaseAuth.currentUser!.uid;
    final isUser = widget.message.senderId == userId;
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => _onPressImage(),
            child: CachedNetworkImage(
              imageUrl: widget.message.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                constraints:
                    const BoxConstraints(maxWidth: 200, minHeight: 100),
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
          ),
          Text(
            widget.message.timestamp.formattedDateChat(),
          )
        ],
      ),
    );
  }

  void _onPressImage() {
    showDialog(
      context: context,
      builder: (BuildContext innerContext) {
        Size size = MediaQuery.of(context).size;
        return Builder(
          builder: (_) {
            return Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  color:
                      Colors.black.withOpacity(0.6), // Adjust opacity as needed
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: AppColors.whiteColor,
                        )),
                    IconButton(
                        onPressed: () {
                          downloadFile(widget.message.imageUrl);
                        },
                        icon: const Icon(
                          Icons.download,
                          color: AppColors.whiteColor,
                        )),
                  ],
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.imageUrl,
                    ),
                  ),
                )),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> downloadFile(String url) async {
    final dio = Dio();
    try {
      var response = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
          quality: 100, name: widget.message.id);
      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (e) {
      // Handle errors, e.g., network errors, file not found on the server, etc.
      log('Error downloading file: $e');
    }
  }
}
