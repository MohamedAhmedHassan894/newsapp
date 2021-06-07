import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
class AppLocale{
  Locale locale;
  Map<String,String> _LoadedLocalizedValues;
  Map<String,dynamic> _fileLodedValues; // it should be string and dynamic because it's a json file 
  AppLocale(this.locale);

  static AppLocale of(BuildContext context){
    return Localizations.of(context,AppLocale);
  }

  Future loadLanguage() async{
    String _langFile =await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    _fileLodedValues=jsonDecode(_langFile);
    _LoadedLocalizedValues = _fileLodedValues.map((key, value) => MapEntry(key, value.toString())); //here we convert it to string and string
  }

  String getTranslated(String key){
    // print(_LoadedLocalizedValues[key]);
    return _LoadedLocalizedValues[key];
  }
  static const LocalizationsDelegate<AppLocale> delegate = _AppLocaleDelegate();
}

class _AppLocaleDelegate extends LocalizationsDelegate<AppLocale>{
  const _AppLocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en","ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async{
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLanguage();
    return appLocale;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old)=>false;

}