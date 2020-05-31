import 'package:flutter/material.dart';
import 'package:newsapp/modules/post.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget connectionError() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('Connection Error!!!!'),
  );
}

Widget error(var error) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text(error.toString()),
  );
}

Widget noData() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('No Data Available!'),
  );
}

Widget loading() {
  return Container(
    padding: EdgeInsets.only(top: 16, bottom: 16),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

String parseHumanDateTime(String dateTime) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
  DateTime theDifference = DateTime.now().subtract(timeAgo);
  return timeago.format(theDifference);
}

Widget authorHandling(Post post){
  if(post.author.contains("www")){
    return Text("Social Media");
  }
  if (post.author.contains("null")){
    return Text("News Report");
  }
  else {
    return Text(post.author);
  }
}