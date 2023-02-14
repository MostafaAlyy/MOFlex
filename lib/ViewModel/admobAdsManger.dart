import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManger {
  static bool testMood = false;
  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad Field Load : $error');
    },
    onAdOpened: (ad) => debugPrint('ad opened'),
  );
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8319531544284510~9695717534";
    } else if (Platform.isIOS) {
      return "------------------------------";
    } else {
      throw UnsupportedError('un supported platform');
    }
  }

  static String get bannerAdUnit {
    if (testMood) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8319531544284510/8319056682";
    } else if (Platform.isIOS) {
      return "------------------------------";
    } else {
      throw UnsupportedError('un supported platform');
    }
  }

  static String get rewardedAdUnit {
    if (testMood) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8319531544284510/2237967718";
    } else if (Platform.isIOS) {
      return "------------------------------";
    } else {
      throw UnsupportedError('un supported platform');
    }
  }

  static String get interstitialdAdUnit {
    if (testMood) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8319531544284510/1528355423";
    } else if (Platform.isIOS) {
      return "------------------------------";
    } else {
      throw UnsupportedError('un supported platform');
    }
  }
}
