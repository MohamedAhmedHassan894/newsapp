import 'package:flutter/material.dart';
import 'package:newsapp/modules/nav_minu.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/headline_news.dart';
import 'package:newsapp/screens/twitter_feed.dart';
import 'package:newsapp/screens/instagram_feed.dart';
import 'package:newsapp/screens/facebook_feeds.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

bool loggedIn = false ;
class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMenuItem> navigationMenue = [
    NavMenuItem("Explore" ,(){return HomeScreen();}),
    NavMenuItem("HeadLine News",(){return HeadLineNews();}),
    NavMenuItem("Twitter feeds" , (){return TwitterFeed();}),
    NavMenuItem("Instagram Feeds", (){return InstagramFeed();}),
    NavMenuItem("Facebook Feeds", (){return FacebookFeeds();}),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 75.0 , left: 18.0),
        child: ListView.builder(
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(navigationMenue[position].title,style: TextStyle(color: Colors.grey.shade700,fontSize: 18),),
                trailing: Icon(Icons.chevron_right,color: Colors.grey.shade500,size: 35,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){return navigationMenue[position].destination();}));
                },
              ),
            );
          },
          itemCount:navigationMenue.length,),
      ),
    );
  }
}
