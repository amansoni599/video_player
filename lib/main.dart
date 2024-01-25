import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(
    MaterialApp(
      home: MaterialApp(home: Home()),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController controller;
  final AudioPlayer _audioPlayer1 = AudioPlayer();
  final AudioPlayer _audioPlayer2 = AudioPlayer();
  bool audioTypeHindi = true;
  @override
  void initState() {
    loadVideoPlayer();
    // final player = AudioCache().p;
    // player.loadAsset("assets/english.mpeg");

    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.asset('assets/video.mp4');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  Future<void> _initAudioPlayer1() async {
    await _audioPlayer1.setAsset('assets/hindi.mpeg');

    if (audioTypeHindi == true) {
      _audioPlayer1.play();
    } else {
      _audioPlayer1.play();
      _audioPlayer1.setVolume(0.0);
    }
  }

  Future<void> _initAudioPlayer2() async {
    await _audioPlayer2.setAsset('assets/english.mpeg');

    if (audioTypeHindi == true) {
      _audioPlayer2.play();
      _audioPlayer2.setVolume(0.0);
    } else {
      _audioPlayer2.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play Video from Assets/URL"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(children: [
        SizedBox(
          height: 400,
          width: 300,
          child: VideoPlayer(controller),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  // if (controller.value.isPlaying) {
                  //   controller.pause();
                  // } else {
                  controller.play();
                  _initAudioPlayer1();
                  _initAudioPlayer2();
                  // }

                  setState(() {});
                },
                icon: Icon(Icons.play_arrow)),
            IconButton(
                onPressed: () {
                  controller.seekTo(const Duration(seconds: 0));
                  _audioPlayer1.stop();
                  _audioPlayer2.stop();

                  setState(() {});
                },
                icon: const Icon(Icons.stop)),
            const SizedBox(
              width: 20,
            ),
            const Text("English"),
            Switch(
                value:
                    audioTypeHindi, // Set the initial value (true for ON, false for OFF)
                onChanged: (value) {
                  audioTypeHindi = value;

                  if (value == true) {
                    _audioPlayer2.setVolume(0.0);
                    _audioPlayer1.setVolume(1);
                  } else {
                    _audioPlayer1.setVolume(0.0);
                    _audioPlayer2.setVolume(1);
                  }
                  setState(() {});
                }),
            const Text("Hindi"),
          ],
        )
      ]),
    );
  }
}
