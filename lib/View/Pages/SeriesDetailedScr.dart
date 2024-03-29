import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moshahda_app/Models/SeriesModel.dart';
import 'package:moshahda_app/View/Pages/desktopWebView.dart';
import 'package:moshahda_app/View/Pages/viedioPlyerScr.dart';

import '../../ViewModel/Cupits/HomeCupit/home_cubit.dart';
import '../../ViewModel/admobAdsManger.dart';
import '../Components/General/SeriesEpisodCard.dart';

class SeriesDetailedScr extends StatefulWidget {
  SeriesModel Series;
  SeriesDetailedScr(this.Series, {super.key});

  @override
  State<SeriesDetailedScr> createState() => _SeriesDetailedScrState();
}

class _SeriesDetailedScrState extends State<SeriesDetailedScr> {
  BannerAd? banner;
  RewardedAd? rewardedAd;
  InterstitialAd? _interstitialAd;

  void createBannerAd() {
    banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdsManger.bannerAdUnit,
        listener: AdsManger.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdsManger.rewardedAdUnit,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() => rewardedAd = ad),
            onAdFailedToLoad: (error) => setState(
                  () {
                    debugPrint(error.message);
                    rewardedAd = null;
                  },
                )));
  }

  void showRewardedAd({required Function afterReward}) {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      setState(() {
        createRewardedAd();
        afterReward.call();
        showInterstitialAd();
      });
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        afterReward.call();
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      afterReward.call();
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createInterstitialAd();
    createBannerAd();
    createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    List<String> links = widget.Series.links!.keys.toList();
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = HomeCubit.get(context);

          return Scaffold(
            backgroundColor: const Color.fromARGB(1000, 11, 10, 28),
            body: BlocProvider(
              create: (context) => HomeCubit(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.18,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: widget.Series.img!,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 1.7,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  const Color.fromARGB(1000, 11, 10, 28)
                                      .withOpacity(0.60),
                                  const Color.fromARGB(1000, 11, 10, 28)
                                      .withOpacity(0.0),
                                ],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter))),
                        //back button
                        Positioned(
                            top: MediaQuery.of(context).size.height / 30,
                            child: IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Color.fromARGB(1000, 11, 10, 28),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        //play button
                        Positioned(
                            top: MediaQuery.of(context).size.height / 2.4,
                            left: MediaQuery.of(context).size.width - 90,
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff1f005c),
                                      Color(0xff5b0060),
                                      Color(0xff870160),
                                      Color(0xffac255e),
                                      Color(0xffca485c),
                                      Color(0xffe16b5c),
                                      Color(0xfff39060),
                                      Color(0xffffb56b),
                                    ],
                                  )),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    if (!Platform.isWindows) {
                                      showRewardedAd(afterReward: () {});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScr(widget
                                                    .Series.links![links[0]])),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DesktopWebView(widget
                                                    .Series.links![links[0]]!)),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 16,
                          top: MediaQuery.of(context).size.height / 2.1,
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.Series.name!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 24),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Date: ${widget.Series.dateTime} ",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (banner != null)
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(ad: banner!)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: widget.Series.links!.length *
                            (MediaQuery.of(context).size.height / 6),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.Series.links!.length,
                          itemBuilder: (context, index) => SeriesEpisodCard(
                              onPlay: () async {
                                showRewardedAd(afterReward: () {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayerScr(
                                          widget.Series.links![links[index]])),
                                );
                              },
                              Series: widget.Series,
                              context: context,
                              index: index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  cupit.FavoriteSeriestoDB(widget.Series);
                },
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: Icon(
                  Icons.favorite,
                  size: 40,
                  color: (HomeCubit.favoriteSeries
                          .containsKey('${widget.Series.name}'))
                      ? Colors.redAccent
                      : Colors.grey[300]!.withOpacity(0.2),
                )),
          );
        },
      ),
    );
  }
}
