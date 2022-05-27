import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../helper/admanager.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd _ad;

  ValueNotifier<bool> _isAdLoaded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      // request: AdRequest(
      //   testDevices: <String>['0B3A1E0EC7DB8FF05EF85F3BDF73090A'],
      // ),
      listener: AdListener(
        onAdLoaded: (_) {
          _isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad.load();
    print('AD loaded');
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isAdLoaded,
        builder: (context, value, child) {
          return value
              ? Container(
                  child: AdWidget(key: UniqueKey(), ad: _ad),
                  width: _ad.size.width.toDouble(),
                  height: _ad.size.height.toDouble(),
                  alignment: Alignment.center,
                )
              : SizedBox();
        });
  }
}
