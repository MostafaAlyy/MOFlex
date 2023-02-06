import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  String videoUrl;
  VideoPlayerView(this.videoUrl);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerView(videoUrl);
}

class _VideoPlayerView extends State<VideoPlayerView> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieContoller;
  String videoUrl;
  _VideoPlayerView(this.videoUrl);

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    chewieContoller = ChewieController(
        videoPlayerController: videoPlayerController, aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(controller: chewieContoller),
    );
  }
}
