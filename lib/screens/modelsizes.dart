import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:myfrocks/widgets/models.dart';
import 'package:myfrocks/widgets/modelsizes.dart';

class ScreenModelSizes extends StatefulWidget {
  static const routeName = '/modelsizes';
  ScreenModelSizes({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenModelSizesState createState() => _ScreenModelSizesState();
}

// class ScreenArguments {
//   final String title;
//   ScreenArguments(this.title);
// }

class _ScreenModelSizesState extends State<ScreenModelSizes> {

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          args['category'],
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
            color: Colors.black12,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0)
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Svg(
              'lib/assets/bg_red_inside.svg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: WidgetModelSizes(args)
        )
      )
    );
  }
}