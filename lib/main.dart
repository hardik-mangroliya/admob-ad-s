import 'package:flutter/material.dart';
import 'package:flutter_application_1/module/view/screen/banner_ad_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/3419835294',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        print('ad is loaded');
        openAd = ad;
        openAd!.show();
      }, onAdFailedToLoad: (error) {
        print("ad failed to load $error");
      }),
      orientation: AppOpenAd.orientationPortrait);
}

void showAd() {
  if (openAd == null) {
    print("try to show before loading ");
    loadAd();
    return;
  }
  openAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (ad) {
      print("onAdShowedFullScreenContent");
    },
    onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print('failed to load $error');
      openAd = null;
      loadAd();
    },
    onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      print("dismissed");
      openAd = null;
      loadAd();
    },
  );
  openAd!.show();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await loadAd();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdBanner(),
    );
  }
}
