import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';

class VoiceMessageItem extends StatefulWidget {
  const VoiceMessageItem({super.key, required this.message});
  final Message message;
  @override
  State<VoiceMessageItem> createState() => _VoiceMessageItemState();
}

class _VoiceMessageItemState extends State<VoiceMessageItem> {
  bool isPlaying = false;
  late final AudioPlayer player;
  late final UrlSource path;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isShowTime = false;
  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();
    path = UrlSource(widget.message.audioUrl);

    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        _position = const Duration();
      });
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userId = firebaseAuth.currentUser!.uid;
    final isUser = widget.message.senderId == userId;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showTime(),
      child: Container(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              constraints: BoxConstraints(maxWidth: size.width * 0.6),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      playPause();
                    },
                    child: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 32.0,
                      color: isUser
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 110,
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        await player.seek(Duration(seconds: value.toInt()));
                        setState(() {});
                      },
                      min: 0,
                      max: _duration.inSeconds.toDouble(),
                      inactiveColor: Colors.grey,
                      activeColor: isUser
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    (_duration - _position).toString().substring(2, 7),
                    style: TextStyle(
                        color: isUser
                            ? AppColors.primaryColor
                            : AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            !isShowTime
                ? const SizedBox()
                : Text(
                    widget.message.timestamp.formattedDateChat(),
                  )
          ],
        ),
      ),
    );
  }

  _showTime() {
    setState(() {
      isShowTime = !isShowTime;
    });
  }
}
