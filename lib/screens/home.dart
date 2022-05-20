import 'package:flutter/material.dart';
import 'package:myfrocks/widgets/category.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins-Medium',            
            shadows: <Shadow>[
              Shadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 4),
              ),
            ]
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, right: 5.0),
            color: Colors.black26,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0)
        )
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/bg_red.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: WidgetCategory()
        )
      )
    );
  }
}
