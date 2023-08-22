import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VoiceMessageItem extends StatefulWidget {
  const VoiceMessageItem({super.key, required this.message});
  final Message message;
  @override
  State<VoiceMessageItem> createState() => _VoiceMessageItemState();
}

class _VoiceMessageItemState extends State<VoiceMessageItem> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _durationInSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed || state == PlayerState.stopped) {
        setState(() {
          _isPlaying = false;
          _durationInSeconds = 0;
          _timer?.cancel();
        });
      }
    });
  }

  Future<void> _playAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _timer?.cancel();
      });
    } else {
      await _audioPlayer.play(UrlSource(
          'https://firebasestorage.googleapis.com/v0/b/ecommerce-app-b5380.appspot.com/o/chat%2Fchat_voice%2Fy2mate.is%20-%20JACK%20J97%20X%C3%93A%20T%C3%8AN%20ANH%20%C4%90I%20Official%20Music%20Video%20Album26%20-mA-UxOle3YQ-48k-1692691214.mp3?alt=media&token=80990a61-2ddf-465a-bac5-aa15b7c865aa'));
      final duration = await _audioPlayer.getDuration();
      setState(() {
        _isPlaying = true;
        _durationInSeconds = duration!.inSeconds ~/ 1000;
        _startCountdownTimer();
      });
    }
  }

  void _startCountdownTimer() {
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_durationInSeconds > 0) {
          _durationInSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      color: Colors.red,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              // final storage = FirebaseStorage.instance;
              // final ref = storage.refFromURL(
              //     "https://firebasestorage.googleapis.com/v0/b/ecommerce-app-b5380.appspot.com/o/chat%2Fchat_voice%2Fy2mate.is%20-%20JACK%20J97%20X%C3%93A%20T%C3%8AN%20ANH%20%C4%90I%20Official%20Music%20Video%20Album26%20-mA-UxOle3YQ-48k-1692691214.mp3?alt=media&token=80990a61-2ddf-465a-bac5-aa15b7c865aa");
              // final downloadUrl = await ref.;
              final player = AudioPlayer();
              await player.play(UrlSource(
                  'https://firebasestorage.googleapis.com/v0/b/ecommerce-app-b5380.appspot.com/o/chat%2Fchat_voice%2Fy2mate.is%20-%20JACK%20J97%20X%C3%93A%20T%C3%8AN%20ANH%20%C4%90I%20Official%20Music%20Video%20Album26%20-mA-UxOle3YQ-48k-1692691214.mp3?alt=media&token=80990a61-2ddf-465a-bac5-aa15b7c865aa'));
            },
            child: Icon(
              _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 36.0,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            _isPlaying ? '$_durationInSeconds seconds' : 'Tap to play',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.release();
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
