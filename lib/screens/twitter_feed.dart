import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Feed'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white60,
              onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  _cardHeader(),
                  _cardBody(),
                  _drawLine(),
                  _cardFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Christina Meyers ',
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '@ch_meyers',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Fri, 21 May 2017 * 14.30',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _cardBody() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        child: Text(
            'We also talk about the future of work as the robots advance , and we ask whethe a refo phone',
          style:TextStyle(fontSize:15.0,height: 1.4 ,color: Colors.grey.shade800,) ,),
      ),
    );
  }

  Widget _cardFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.repeat),
                  iconSize: 28,
                  color: Colors.orange,
                  onPressed: () {}),
              Text(
                '25',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  'SHARE',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'OPEN',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _drawLine() {
    return Container(
      height: 1.0,
      color: Colors.grey.shade200,
      margin: EdgeInsets.only(top: 16.0,left:8.0,right: 8.0),
    );
 }
}
