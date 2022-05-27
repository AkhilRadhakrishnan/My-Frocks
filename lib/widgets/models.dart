import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mmodel.dart';
import 'package:myfrocks/screens/modelsizes.dart';
import 'package:myfrocks/widgets/banner_ad_widget.dart';

class WidgetModels extends StatefulWidget {
  WidgetModels(this.title);
  final String title;

  @override
  _WidgetModelsState createState() => _WidgetModelsState();
}

class _WidgetModelsState extends State<WidgetModels> {
  MModels models;
  FrocksApis _apiResponse = FrocksApis();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getModels(this.widget.title.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            models = ((snapshot.data as SuccessState).value) as MModels;

            int len = models.models.length;
            return ListView.separated(
              itemCount: len,
              separatorBuilder: (ctx, index) {
                if ((index % 4) == 0 && index != 0) {
                  return BannerAdWidget();
                } else if (len <= 2) {
                  return BannerAdWidget();
                } else if (len <= 4 && (index % 2) == 0 && index != 0) {
                  return BannerAdWidget();
                } else {
                  return SizedBox();
                }
              },
              itemBuilder: (ctx, index) {
                final item = models.models.elementAt(index);
                return InkWell(
                    onTap: () => {
                          Navigator.pushNamed(
                            context,
                            ScreenModelSizes.routeName,
                            arguments: {
                              'category': this.widget.title,
                              'modelid': item.id,
                              'model': item.name,
                              'thump': item.thumbnail
                            },
                          )
                        },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 8),
                      child: Card(
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(
                                color: HexColor('8E0C0C'), width: 1.0),
                            borderRadius: BorderRadius.circular(15.0)),
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
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    imageUrl: 'http://myfrocks.com/App/Admin/' +
                                        item.thumbnail),
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
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor('8E0C0C'),
                                      fontFamily: 'Poppins-Medium')),
                            ),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
