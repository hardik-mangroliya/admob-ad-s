import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ad_string_constant.dart';

abstract class AdFunctions {
  static InterstitialAd? _interstitialAd;
  static AppOpenAd? openAd;

  static Future<void> loadAd() async {
    await AppOpenAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/3419835294',
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            print('ad is loaded');
            openAd = ad;
            openAd!.show();
          },
          onAdFailedToLoad: (error) {
            print("ad failed to load $error");
          },
        ),
        orientation: AppOpenAd.orientationPortrait);
  }

  static Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdStringConstant.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstialAd failed to show: $error.');
          _interstitialAd = null;
        },
      ),
    );
  }

  static Future<void> showInterstitialAd() async {
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
        loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
