import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/ad_string_constant.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardAdmob extends StatefulWidget {
  const RewardAdmob({Key? key}) : super(key: key);

  @override
  State<RewardAdmob> createState() => _RewardAdmobState();
}

class _RewardAdmobState extends State<RewardAdmob> {
  late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  @override
  void initState() {
    super.initState();
    RewardedAd.load(
      adUnitId: AdStringConstant.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
            },
          );
          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Reward Ad"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     _rewardedAd.show(onUserEarnedReward: (ad, reward) {});
        //   },
        // ),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            _rewardedAd.show(onUserEarnedReward: (ad, reward) {});
          },
          child: Container(
            color: Colors.indigo,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                " TAP HERE FOR Reward AD ",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
