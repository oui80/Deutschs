import 'package:Dutch/ad/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({Key? key}) : super(key: key);

  @override
  State<BottomBannerAd> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {

  final banner = GetIt.instance.get<AdService>().getBannerAd();

  @override
  void dipose(){
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: AdWidget(ad: banner,),
    );
  }
}
