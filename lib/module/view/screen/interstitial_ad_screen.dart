import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/functions/ad_functions.dart';
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
    AdFunctions.loadInterstitialAd();
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
            AdFunctions.showInterstitialAd();
          },
          child: Container(
            color: Colors.teal,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                " TAP HERE FOR Interstitial Ad ",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
