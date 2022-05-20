import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1587899225953631~7912684777";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7382785139320010~4280691407";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1587899225953631/3602722914";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7382785139320010/9964262923";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1587899225953631/3639409603";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7382785139320010/9964262923";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}