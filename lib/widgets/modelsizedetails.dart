import 'package:flutter/material.dart';
import 'package:myfrocks/helper/frocksapis.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/models/mmodelsizedetail.dart';

class WidgetModelSizeDetails extends StatelessWidget {
  MModelSizeDetails details;
  FrocksApis _apiResponse = FrocksApis();
  WidgetModelSizeDetails(this.args);

  final Map<String, String> args;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Result>(
        future: _apiResponse.getModelSizeDetails(this.args["category"].toLowerCase(), this.args["modelid"], this.args["sizeid"]),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            details = ((snapshot.data as SuccessState).value) as MModelSizeDetails;
            /*var fabric = [];
            for (var item in details.details) {
              if(item.dimension_name.contains('fabric')) {
                fabric.add(item.dimension_value);
              }
            }
            var added = false;*/
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(  
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),                  
                    color: Colors.white54,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:5),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(this.args["model"],
                            style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.black)
                          ),
                        ),
                        SizedBox(height:5),
                        Container(height:1, color: Colors.black12,),
                        SizedBox(height:5),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(this.args["size"],
                            style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.black)
                          ),
                        ),
                        SizedBox(height:5),
                      ],
                    )
                  ),
                  SizedBox(height:10),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: SingleChildScrollView(
                        child: Container(
                          color: HexColor('CC8E0C0C'),
                          child: Table(
                              border: TableBorder.all(color: HexColor('8E0C0C')),                    
                              columnWidths: {
                                0: FractionColumnWidth(0.4),
                                1: FractionColumnWidth(0.6)
                              },
                              children:[
                                for(var item in details.details )
                                    TableRow(children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0, right:5.0, top:5.0, bottom: 5.0),
                                          child:  Text(item.dimension_name.toUpperCase(),
                                            style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.white)
                                          ),
                                        ),
                                      ),                            
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0, right:5.0, top:5.0, bottom: 5.0),
                                          child: Text(item.dimension_value,
                                            style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium', color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]
                                  )
                              ]
                            ),
                        ),
                        ),
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