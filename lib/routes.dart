import 'package:flutter/material.dart';
import 'package:myfrocks/screens/models.dart';
import 'package:myfrocks/screens/modelsizes.dart';
import 'package:myfrocks/screens/modelsizedetails.dart';
import 'package:myfrocks/screens/tipsdetails.dart';

final Map<String, WidgetBuilder> routes = {
  ScreenModels.routeName: (context) => ScreenModels(),
  ScreenModelSizes.routeName: (context) => ScreenModelSizes(),
  ScreenModelSizeDetails.routeName: (context) => ScreenModelSizeDetails(),
  ScreenTipDetails.routeName: (context) => ScreenTipDetails(),
};