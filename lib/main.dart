import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/functions/ad_functions.dart';
import 'module/view/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  if (AdFunctions.loadAd == Duration(seconds: 0)) {
    AdFunctions.loadAd();
    runApp(MyApp());
  } else {
    runApp(MyApp());
    print('Started at ${DateTime.now()}');
    final time = await Future.delayed(
      const Duration(seconds: 10),
      () async {},
    ).then((value) => DateTime.now());
    print('Awaited time was at $time');
    AdFunctions.loadAd();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
