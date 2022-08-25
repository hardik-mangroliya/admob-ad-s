import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/ad_helper.dart';
import 'package:flutter_application_1/module/view/screen/reward_ad_sceen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInterstitial extends StatefulWidget {
  const AdInterstitial({Key? key}) : super(key: key);

  @override
  State<AdInterstitial> createState() => _AdInterstitialState();
}

class _AdInterstitialState extends State<AdInterstitial> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
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

  void _showInterstitialAd() {
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
        _loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _loadInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Interstitial Ad'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RewardAdmob(),
            ),
          );
        },
        child: const Icon(Icons.add_box),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            _showInterstitialAd();
          },
          child: Container(
            color: Colors.teal,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                " TAP HERE FOR\n  Interstitial AD ",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
