import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mads.dart';
import 'package:myfrocks/screens/models.dart';
import '../helper/custom_sliver_grid_delegate.dart';

class WidgetCategory extends StatelessWidget {
  MADs model;
  FrocksApis _apiResponse = FrocksApis();
  final imageAndCaption = [
    {"icon":"lib/assets/cat1_frock.png", "title":"Frocks", "smtitle":"Frocks"},
    {"icon":"lib/assets/cat2_nighty.png", "title":"Nighty", "smtitle":"Nighty"},
    {"icon":"lib/assets/cat3_churidar.png", "title":"Churidar", "smtitle":"Churidar"},
    {"icon":"lib/assets/cat4_video.png", "title":"App Only Videos", "smtitle":"App Only\n Videos"},
    {"icon":"lib/assets/cat5_class.png", "title":"Sewing Class", "smtitle":"Sewing Class"},
    {"icon":"lib/assets/cat8_qa.png", "title":"Questions & Answers", "smtitle":"Q & A"},
    {"icon":"lib/assets/cat7_tips.png", "title":"Sewing Tips", "smtitle":"Sewing Tips"},
    {"icon":"lib/assets/cat6_maintanence.png", "title":"Sewing Machine \n& Maintanence", "smtitle":"Sewing Machine \n& Maintanence"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 14,),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder<Result>(
            future: _apiResponse.getAds(""),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                model = ((snapshot.data as SuccessState).value) as MADs;
                var images = [];
                for (var ad in model.ads) {
                  images.add(NetworkImage('http://myfrocks.com/App/Admin/'+ad.thumbnail));
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * (9/16),
                  child: Carousel(
                    images: images,
                    //dotSize: 6.0,
                    //dotSpacing: 15.0,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Colors.blue,
                    indicatorBgPadding: 2.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                    radius: Radius.circular(10.0),
                  ),
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 6),
                      ),
                    ]
                  ),
                );
              } else if (snapshot.data is ErrorState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * (9/16),
                  child: Carousel(
                    images: [AssetImage("lib/assets/logo.png")],
                    boxFit: BoxFit.fitHeight,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Colors.blue,
                    indicatorBgPadding: 2.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                    radius: Radius.circular(10.0),
                  ),
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 6),
                      ),
                    ]
                  ),
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * (9/16),
                  child: Carousel(
                    images: [AssetImage("lib/assets/logo.png")],
                    boxFit: BoxFit.fitHeight,
                    //dotSize: 6.0,
                    //dotSpacing: 15.0,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Colors.blue,
                    indicatorBgPadding: 2.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                    radius: Radius.circular(10.0),
                  ),
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 6),
                      ),
                    ]
                  ),
                );
              }
            }
          )
        ), 
        SizedBox(height: 15,),
        Expanded(
          child: Padding(                  
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GridView.builder(                    
              itemCount: imageAndCaption.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 4,
                height: MediaQuery.of(context).size.width * 0.45,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    onTap: ()=> {
                      Navigator.pushNamed(
                        context,
                        ScreenModels.routeName,
                        arguments: imageAndCaption[index]['title'],
                      )
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: HexColor("E6FFFFFF"),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                imageAndCaption[index]['icon'],
                                fit: BoxFit.fitWidth,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            decoration: BoxDecoration (
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                  offset: Offset(0, 6),
                                ),
                              ]
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                imageAndCaption[index]['smtitle'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13, fontFamily: 'Poppins-Medium'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]
    );
  }
}