import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moshahda_app/View/Components/General/ViedioPlayerView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScr extends StatelessWidget {
  String videoUrl;
  VideoPlayerScr(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayerView(videoUrl),
        ),
      ),
    );
  }
}
