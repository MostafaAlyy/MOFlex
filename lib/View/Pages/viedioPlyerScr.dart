import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScr extends StatelessWidget {
  String videoUrl;
  VideoPlayerScr(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotatedBox(
          quarterTurns: 1,
          child: WebView(
            initialUrl: videoUrl,
            navigationDelegate: (navigation) => NavigationDecision.prevent,
            javascriptMode:
                JavascriptMode.values.reduce((value, element) => element),
          ),
        ),
      ),
    );
  }
}
