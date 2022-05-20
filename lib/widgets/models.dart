import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/helper/admanager.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mmodel.dart';
import 'package:myfrocks/screens/modelsizes.dart';

class WidgetModels extends StatefulWidget {
  WidgetModels(this.title);
  final String title;

  @override
  _WidgetModelsState createState() => _WidgetModelsState();  
}

class _WidgetModelsState extends State<WidgetModels> {
  MModels models;
  FrocksApis _apiResponse = FrocksApis();
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
        future: _apiResponse.getModels(this.widget.title.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            models = ((snapshot.data as SuccessState).value) as MModels;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                itemCount: models.models.length + (_isAdLoaded ? (models.models.length ~/ _kAdIndex) : 0),
                itemBuilder: (ctx, index) {
                  if (_isAdLoaded && index == _kAdIndex) {
                    return Container(
                      child: AdWidget(ad: _ad),
                      width: _ad.size.width.toDouble(),
                      height: _ad.size.height.toDouble(),
                      alignment: Alignment.center,
                    );
                  } else {
                    final item = models.models[getIndex(index)];
                    return InkWell(
                      onTap: ()=> {
                        Navigator.pushNamed(
                          context,
                          ScreenModelSizes.routeName,
                          arguments: { 'category': this.widget.title,
                            'modelid': item.id,
                            'model': item.name,
                            'thump': item.thumbnail
                          },
                        )
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 10, top: 8),
                        child: Card(
                          elevation: 5,
                          shape: new RoundedRectangleBorder(
                            side: new BorderSide(color: HexColor('8E0C0C'), width: 1.0),
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Center(
                                child: Container(
                                  height: 150,
                                  // child: SizedBox(child: Text('yashjha'),),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    imageUrl: 'http://myfrocks.com/App/Admin/'+item.thumbnail
                                  ),
                                  /*decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage('http://myfrocks.com/App/Admin/'+item.thumbnail_path),
                                    fit: BoxFit.cover)
                                  ),*/
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(item.name,
                                  style: TextStyle(fontSize: 14, color: HexColor('8E0C0C'), fontFamily: 'Poppins-Medium')
                                ),
                              ),
                              SizedBox(height: 10)
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

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

}