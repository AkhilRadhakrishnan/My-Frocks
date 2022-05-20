
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/helper/admanager.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mvideos.dart';
import 'package:myfrocks/widgets/video.dart';
import 'package:video_player/video_player.dart';

class WidgetSewingClass extends StatefulWidget {
  @override
  _WidgetSewingClassState createState() => _WidgetSewingClassState();
}

class _WidgetSewingClassState extends State<WidgetSewingClass> {
  MVideos model;
  FrocksApis _apiResponse = FrocksApis();

  @override
  bool get wantKeepAlive => true;

  BannerAd _ad;
  int _kAdIndex = 3;
  bool _isAdLoaded = false;

  int getIndex(int index) {
    int decrement = (index-1) ~/ _kAdIndex;
    if (_isAdLoaded) {
      return index - decrement;
    }
    return index;
  }

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
          setState(() {
            _isAdLoaded = true;
          });
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
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getVideos("11"),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            model = ((snapshot.data as SuccessState).value) as MVideos;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                itemCount: model.videos.length + (_isAdLoaded ? (model.videos.length ~/ _kAdIndex) : 0),
                itemBuilder: (ctx, index) {
                  if (_isAdLoaded && index == _kAdIndex) {
                    return Container(
                      child: AdWidget(ad: _ad),
                      width: _ad.size.width.toDouble(),
                      height: _ad.size.height.toDouble(),
                      alignment: Alignment.center,
                    );
                  } else {
                    final item = model.videos[getIndex(index)];
                    return InkWell(
                      onTap: ()=> {
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 10, top: 8),
                        child: Card(
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          color: Colors.white30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Container(
                                    padding: const EdgeInsets.only(left: 3, right: 3),
                                    child: WidgetVideo(
                                        url: item.path, 
                                        thumbnail: item.thumbnail,
                                      ),/*BetterPlayer.network(
                                      'http://myfrocks.com/App/Admin/'+model.videos[index].path,
                                      betterPlayerConfiguration: BetterPlayerConfiguration(
                                        aspectRatio: 16 / 9,
                                        placeholder: CachedNetworkImage(
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                          imageUrl: 'http://myfrocks.com/App/Admin/'+model.videos[index].thumbnail,
                                        ),
                                        showPlaceholderUntilPlay: true
                                      )
                                    ),*/
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(item.name,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium')
                                ),
                              ),
                              SizedBox(height: 5)
                            ],
                          ),
                        ),
                      )
                    );
                  }
                }
              ),
            );
          } else if (snapshot.data is ErrorState) {
            String errorMessage = (snapshot.data as ErrorState).msg;
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: Text(errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: 'Poppins-Medium')
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }
}