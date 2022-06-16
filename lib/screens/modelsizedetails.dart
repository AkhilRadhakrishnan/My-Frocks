import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/helper/admanager.dart';
import 'package:myfrocks/widgets/models.dart';
import 'package:myfrocks/widgets/modelsizedetails.dart';
import 'package:myfrocks/widgets/modelsizes.dart';

class ScreenModelSizeDetails extends StatefulWidget {
  static const routeName = '/modelsizedetails';
  ScreenModelSizeDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenModelSizeDetailsState createState() => _ScreenModelSizeDetailsState();
}

// class ScreenArguments {
//   final String title;
//   ScreenArguments(this.title);
// }

class _ScreenModelSizeDetailsState extends State<ScreenModelSizeDetails> {
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
    final Map<String, String> args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return WillPopScope(
      onWillPop: () async {
        if (AdManager.backButtonPressed < 2) {
          AdManager.backButtonPressed = AdManager.backButtonPressed + 1;
        } else {
          if (_interstitialReady) {
            _interstitialAd.show();
            _interstitialReady = false;
            _interstitialAd = null;
          }
          AdManager.backButtonPressed = 0;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              args['category'],
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
                  ]),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: PreferredSize(
                child: Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  color: Colors.black12,
                  height: 2.0,
                ),
                preferredSize: Size.fromHeight(2.0)),
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
              child: SafeArea(child: WidgetModelSizeDetails(args)))),
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
    _interstitialReady = false;
    _interstitialAd.dispose();
    super.dispose();
  }
}
