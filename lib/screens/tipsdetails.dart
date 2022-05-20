import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/helper/admanager.dart';
import 'package:myfrocks/widgets/tipdetails.dart';

class ScreenTipDetails extends StatefulWidget {
  static const routeName = '/tips';
  ScreenTipDetails({Key key, this.args}) : super(key: key);
  final Map<String, String> args;

  @override
  _ScreenTipDetailsState createState() => _ScreenTipDetailsState();
}

// class ScreenArguments {
//   final String title;
//   ScreenArguments(this.title);
// }

class _ScreenTipDetailsState extends State<ScreenTipDetails> {

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((InitializationStatus status) {
      print('Initialization done: ${status.adapterStatuses}');
        createInterstitialAd();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          args['title'],
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            fontFamily: 'Poppins-Medium',           
            shadows: <Shadow>[
              Shadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 4),
              ),
            ]
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            color: Colors.black12,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0)
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Svg(
              'lib/assets/bg_red_inside.svg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: WidgetTipDetails(args)
        )
      )
    );
  }

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;
  void createInterstitialAd() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      // request: AdRequest(
      //   testDevices: <String>['0B3A1E0EC7DB8FF05EF85F3BDF73090A'],
      //   nonPersonalizedAds: true
      // ),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }

  @override   
  void dispose() {   
    super.dispose();
    if (_interstitialReady) {
      _interstitialAd.show();
      _interstitialReady = false;
      _interstitialAd = null;
    }
  }

}