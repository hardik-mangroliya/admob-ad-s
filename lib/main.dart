import 'package:flutter/material.dart';
import 'package:flutter_application_1/module/view/screen/banner_ad_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/functions/ad_functions.dart';

void main() async {
  // Future.delayed(const Duration(seconds: 50), () {
  //   print("Executed after 10 seconds");
  // });

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // ---------------------------------------------
  print('Started at ${DateTime.now()}');
  final time = await Future.delayed(
    const Duration(seconds: 10),
    () async {},
  ).then((value) => DateTime.now());
  print('Awaited time was at $time');
  // --------------------------------------

  await AdFunctions.loadAd();
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
