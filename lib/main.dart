
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/routes.dart';
import 'package:myfrocks/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  debugPrint(message.toString());
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('lib/assets/logo.png'), context);
    precacheImage(AssetImage('lib/assets/cat1_frock.png'), context);
    precacheImage(AssetImage('lib/assets/cat2_nighty.png'), context);
    precacheImage(AssetImage('lib/assets/cat3_churidar.png'), context);
    precacheImage(AssetImage('lib/assets/cat4_video.png'), context);
    precacheImage(AssetImage('lib/assets/cat5_class.png'), context);
    precacheImage(AssetImage('lib/assets/cat6_maintanence.png'), context);
    precacheImage(AssetImage('lib/assets/cat7_tips.png'), context);
    precacheImage(AssetImage('lib/assets/cat8_qa.png'), context);
    precacheImage(AssetImage('lib/assets/bg_red.png'), context);
    precacheImage(AssetImage('lib/assets/bg_red_inside.svg'), context);
    precacheImage(AssetImage('lib/assets/mc_basic.png'), context);
    precacheImage(AssetImage('lib/assets/mc_electric.png'), context);
    precacheImage(AssetImage('lib/assets/mc_industrial.png'), context);
    precacheImage(AssetImage('lib/assets/youtube.png'), context);
    return MaterialApp(
      title: 'My Frocks',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orange
      ),
      home: ScreenHome(title: 'www.MyFrocks.com'),
      routes: routes,
    );
  }
}
