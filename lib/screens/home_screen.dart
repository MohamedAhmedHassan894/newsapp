import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/navigation_drawer.dart';
import 'package:newsapp/screens/whats_new.dart';
import 'package:newsapp/screens/popular.dart';
import 'package:newsapp/screens/favourites.dart';
import 'package:newsapp/screens/pages/about.dart';
import 'package:newsapp/screens/pages/help.dart';
import 'package:newsapp/screens/pages/contact.dart';
import 'package:newsapp/screens/pages/settings.dart';
import 'package:newsapp/utilities/data_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum popOutMenu { HELP, ABOUT, CONTACT, SETTINGS }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                if (_getLanguageCode(context) != 'en') {
                  // step one, save the chosen locale
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.setString('lang', 'en');  
                  // step two, rebuild the whole app, with the new locale
                  NewsApp.setLocale(context, Locale('en', ''));
                }else{
                NewsApp.setLocale(context, Locale('ar', ''));
                  
                }
              },
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              label: Text(
                _getLanguageCode(context) == 'ar' ? 'en' : 'العربية',
                style: TextStyle(color: Colors.white),
              )),
          _PopOutMenue(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: getTranslated(context, 'whatsnews')),
            Tab(
              text: getTranslated(context, 'popular'),
            ),
            Tab(
              text: getTranslated(context, 'favourites'),
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: TabBarView(
          children: [
            WhatsNew(),
            Popular(),
            Favourites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _PopOutMenue(BuildContext context) {
    return PopupMenuButton<popOutMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<popOutMenu>(
            value: popOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<popOutMenu>(
            value: popOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<popOutMenu>(
            value: popOutMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<popOutMenu>(
            value: popOutMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
        ];
      },
      onSelected: (popOutMenu menu) {
        switch (menu) {
          case popOutMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutUs();
            }));
            break;
          case popOutMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Help();
            }));
            break;
          case popOutMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Contact();
            }));
            break;
          case popOutMenu.SETTINGS:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }

  _getLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }
}

