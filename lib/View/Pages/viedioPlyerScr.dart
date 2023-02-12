import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScr extends StatelessWidget {
  String videoUrl;
  VideoPlayerScr(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
