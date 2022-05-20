
import 'package:flutter/material.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mtips.dart';

class WidgetTipDetails extends StatelessWidget {
  MTips model;
  FrocksApis _apiResponse = FrocksApis();
  WidgetTipDetails(this.args);

  final Map<String, String> args;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getTips(this.args["type"].toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            model = ((snapshot.data as SuccessState).value) as MTips;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                itemCount: model.tips.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: ()=> {
                      /*Navigator.pushNamed(
                        context,
                        ScreenModelSizes.routeName,
                        arguments: { 'category': this.title,
                          'modelid': models.models[index].model_id,
                          'model': models.models[index].model_name,
                          'thump': models.models[index].thumbnail_path
                        },
                      )*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0, right: 10, top: 8),
                      child: Card(
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: '" ',
                                  style: TextStyle(fontSize: 22, fontFamily: 'Poppins-Medium')
                                ),
                                TextSpan(text: model.tips[index].tip_description,
                                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium')
                                ),
                                TextSpan(text: ' "',
                                  style: TextStyle(fontSize: 22, fontFamily: 'Poppins-Medium')
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    )
                  );
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
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator())
            );
          }
        }
      )
    );
  }
}