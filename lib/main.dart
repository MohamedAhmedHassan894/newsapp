import "package:flutter/material.dart";
import 'package:newsapp/screens/onboarding.dart';
import 'package:newsapp/utilities/app_theme.dart';

 main ()  {
   runApp(NewsApp());
}
class NewsApp extends StatelessWidget {
  /* final Widget _screen ;
   NewsApp(this._screen);*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: OnBoarding(),
    );
  }
}
