import "package:flutter/material.dart";
import 'package:newsapp/lang/appLocal.dart';
import 'package:newsapp/screens/onboarding.dart';
import 'package:newsapp/utilities/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

main()  {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _NewsAppState state = context.findAncestorStateOfType<_NewsAppState>();

    state.setState(() {
      state.locale = newLocale;
    });
  }
}

class _NewsAppState extends State<NewsApp> {
  Locale locale;
  bool supportedLang=false;
  @override
  void initState() {
    super.initState();
    this._fetchLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: OnBoarding(),
        localizationsDelegates: [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: this.locale,
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        // ignore: missing_return
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (this.locale == null) {
            if (deviceLocale != null) {
              for (Locale locale in supportedLocales) {
                if (deviceLocale.languageCode == locale.languageCode) {
                  // print(currentLocale.languageCode);//the current language in system
                  this.supportedLang=true;
                  return deviceLocale;
                }
              }
              //if no locals and the device local is not in the supported languages
              if(!this.supportedLang){
                return supportedLocales.first;
              }
            }
            else{return supportedLocales.first;}
          }

          else{
            return this.locale;
            }
        },
      );
    
  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lang') == null) {
      //if it's the first time for app
      return null;
    } else {
      return Locale(prefs.getString('lang'), '');
    }
  }
}
