import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/module/view/screen/interstitial_ad_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../core/ad_helper.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key}) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print("Failed to load Banner ad:${err.message}");
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Banner Ad"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40, right: 0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                loadAd();
              },
              child: Container(
                width: 80,
                height: 50,
                color: Colors.blue[100],
                child: const Center(child: Text("Load AD")),
              ),
            ),
            const SizedBox(
              width: 225,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdInterstitial()));
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Center(
          child: _isBannerAdReady
              ? Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                )
              : const CircularProgressIndicator()),
    );
  }
}
