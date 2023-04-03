
//TODO fill the gasp before release
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const kAndroidBannerUnitId = "";
const kIosBannerUnitId = "";

//Test APPLICATION ID
const kTestDiviceId = "true";

class AdService {
  final MobileAds _mobileAds;

  AdService(this._mobileAds);

  Future<void> init() async {
    await _mobileAds.initialize();
    if(kDebugMode){
      final cfg = RequestConfiguration(testDeviceIds:  [kTestDiviceId]);
      await MobileAds.instance.updateRequestConfiguration(cfg);
    }
  }

  BannerAd getBannerAd() {
    return BannerAd(
        size: AdSize.fullBanner,
        adUnitId: _bannerUnitId,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('Banner Loaded');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            debugPrint(" ERROR  :  $error" );
          }
        ),
    )..load();


  }

  String get _bannerUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }

    if (Platform.isAndroid){
      return kAndroidBannerUnitId;
    }

    if (Platform.isIOS) {
      return kIosBannerUnitId;
    }

    throw UnimplementedError(
      "${Platform.operatingSystem} is not implemented for banner ads"
    );

  }
}