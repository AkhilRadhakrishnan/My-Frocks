import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myfrocks/helper/custom_sliver_grid_delegate.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mmodelsize.dart';
import 'package:myfrocks/screens/modelsizedetails.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetModelSizes extends StatelessWidget {
  MModelSizes models;
  FrocksApis _apiResponse = FrocksApis();
  WidgetModelSizes(this.args);

  final Map<String, String> args;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getModelSizes(this.args['category'].toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            models = ((snapshot.data as SuccessState).value) as MModelSizes;
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(this.args['model'],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                          shape: new RoundedRectangleBorder(
                            side: new BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            height: 180,
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(child: CircularProgressIndicator()),
                              imageUrl: 'http://myfrocks.com/App/Admin/'+this.args["thump"]
                            ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: ()=> {
                      launch('https://youtube.com/channel/UCop6t8_o2vDm3hQS-l2f0PQ')
                    },
                    child: Image(image: AssetImage('lib/assets/youtube.png'),
                      height: 50,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text('Size Charts',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.black,
                        decoration: TextDecoration.underline,),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(                    
                      itemCount: models.sizes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        height: MediaQuery.of(context).size.width * 0.2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: ()=> {
                              Navigator.pushNamed(
                                context,
                                ScreenModelSizeDetails.routeName,
                                arguments: { 'category': this.args['category'], 
                                  'model': this.args['model'], 
                                  'modelid': this.args['modelid'], 
                                  'size': models.sizes[index].size_name,
                                  'sizeid': models.sizes[index].size_id
                                },
                              )
                            },
                            child:Card(
                            color: index % 2 == 0 ? Colors.red : Colors.orange,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(child: Text(models.sizes[index].size_name)),
                          )
                        );
                      }
                    ),
                  ),
                ],
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