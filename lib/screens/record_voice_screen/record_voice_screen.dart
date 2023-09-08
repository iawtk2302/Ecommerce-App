import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class RecordVoiceScreen extends StatefulWidget {
  const RecordVoiceScreen({super.key});
  static const String routeName = '/record-voice-screen';
  @override
  State<RecordVoiceScreen> createState() => _RecordVoiceScreenState();
}

class _RecordVoiceScreenState extends State<RecordVoiceScreen> {
  final FlutterSoundRecorder _flutterSoundRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isAnimated = false;
  String _filePath = '';
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _flutterSoundRecorder.closeRecorder();
    super.dispose();
  }

  void initRecorder() async {
    await _flutterSoundRecorder.openRecorder();
    _flutterSoundRecorder
        .setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void startRecording() async {
    await _flutterSoundRecorder.startRecorder(
      toFile: 'audio',
    );
    _filePath = '';
    setState(() {
      _isRecording = true;
      _isAnimated = true;
    });
  }

  void stopRecording() async {
    _filePath = (await _flutterSoundRecorder.stopRecorder())!;
    setState(() {
      _isRecording = false;
      _isAnimated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const MyIcon(
              icon: AppAssets.icMic,
              height: 150,
            ),
            StreamBuilder<RecordingDisposition>(
              stream: _flutterSoundRecorder.onProgress,
              builder: (context, snapshot) {
                final Duration duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                String twoDigit(int n) => n.toString().padLeft(2, '0');
                String twoDigitMinutes =
                    twoDigit(duration.inMinutes.remainder(60));
                String twoDigitSeconds =
                    twoDigit(duration.inSeconds.remainder(60));
                return Text(
                  '$twoDigitMinutes:$twoDigitSeconds',
                  style: AppStyles.displayLarge,
                );
              },
            ),
            LottieBuilder.asset(
              AppAssets.lottieAudio,
              animate: _isAnimated,
              width: 120,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Reset',
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
                GestureDetector(
                  onTap: () {
                    if (!_isRecording) {
                      startRecording();
                    } else {
                      stopRecording();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 30,
                    child: Icon(
                      _isRecording ? Icons.pause : Icons.play_arrow,
                      color: AppColors.whiteColor,
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () => _sendVoiceMessage(),
                    child: const MyIcon(
                      icon: AppAssets.icSend,
                      colorFilter: ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn),
                      height: 35,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendVoiceMessage() async {
    if (_filePath.isNotEmpty) {
      Navigator.of(context).pop();
      await ChatService().sendVoiceMessage(_filePath);
    }
  }
}
