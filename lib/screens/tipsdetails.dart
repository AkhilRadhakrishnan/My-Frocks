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
              child: SafeArea(child: WidgetTipDetails(args)))),
    );
  }

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;
  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialReady = true;
          _interstitialAd = ad;
        },
            onAdFailedToLoad: (error){
              _interstitialAd.dispose();
              _interstitialAd = null;
              createInterstitialAd();
            }
        ));
    if(_interstitialReady){
      _interstitialAd.show();
      _interstitialAd = null;
    }
  }

  @override
  void dispose() {
    _interstitialReady = false;
    _interstitialAd.dispose();
    super.dispose();
  }
}
