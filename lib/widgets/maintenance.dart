import 'package:flutter/material.dart';
import 'package:myfrocks/helper/custom_sliver_grid_delegate.dart';
import 'package:myfrocks/helper/requestutil.dart';
import 'package:myfrocks/screens/tipsdetails.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetMaintenance extends StatelessWidget {  
  final categories = [
    {"icon":"lib/assets/mc_basic.png", "title":"Basic Sewing Machine", "type":"5"},
    {"icon":"lib/assets/mc_electric.png", "title":"Electric Sewing Machine", "type":"6"},
    {"icon":"lib/assets/mc_industrial.png", "title":"Industrial Sewing Machine", "type":"7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(                    
              itemCount: categories.length,
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
                        ScreenTipDetails.routeName,
                        arguments: categories[index],
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
                            height: 18,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                categories[index]['icon'],
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
                                categories[index]['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium'),
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
          ],
        ),
    );
  }
}