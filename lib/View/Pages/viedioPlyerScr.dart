import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ViewModel/admobAdsManger.dart';

class VideoPlayerScr extends StatefulWidget {
  String videoUrl;
  VideoPlayerScr(this.videoUrl);

  @override
  State<VideoPlayerScr> createState() => _VideoPlayerScrState();
}

class _VideoPlayerScrState extends State<VideoPlayerScr> {
  final GlobalKey webViewKey = GlobalKey();
  InterstitialAd? _interstitialAd;

  InAppWebViewController? webViewController;

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RotatedBox(
            quarterTurns: 0,
            child: InAppWebView(
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              initialUrlRequest: URLRequest(url: Uri.parse(widget.videoUrl)),
              onWebViewCreated: (controller) {
                webViewController = controller;
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                ]);
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
              ),
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.CANCEL;
              },
            ),
          ),
        ),
      ),
    );
  }
}
