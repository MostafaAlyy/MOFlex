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

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdsManger.interstitialdAdUnit,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;

            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');

            _interstitialAd = null;
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  adLoop() {
    Future.delayed(const Duration(minutes: 15), () {
      setState(() {
        if (_interstitialAd != null) {
          showInterstitialAd();
        }
        createInterstitialAd();
        adLoop();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    createInterstitialAd();
    super.initState();
    adLoop();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
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
