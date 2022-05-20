
import 'package:flutter/material.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mqas.dart';

class WidgetQA extends StatelessWidget {
  MQAs model;
  FrocksApis _apiResponse = FrocksApis();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getQAs(),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            model = ((snapshot.data as SuccessState).value) as MQAs;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                itemCount: model.qas.length,
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
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
                                      TextSpan(text: 'Q : ',
                                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium')
                                      ),
                                      TextSpan(text: model.qas[index].qa_question,
                                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium')
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Card(
                              elevation: 5,
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              color: HexColor('9985ff7f'),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
                                child: RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(text: 'A : ',
                                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium')
                                      ),
                                      TextSpan(text: model.qas[index].qa_answer,
                                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium')
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                          ),
                        ],
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