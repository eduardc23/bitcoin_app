import 'package:bitcoin_app/src/pages/detail/ui/detail_page.dart';
import 'package:bitcoin_app/src/pages/home/ui/home_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'detail': (BuildContext context) => DetailPage(),
  };
}
