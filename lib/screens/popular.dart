import 'package:flutter/material.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/utilities/data_utilities.dart';
import 'package:newsapp/single_post.dart';
import 'dart:async';
import 'package:newsapp/modules/post.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostsAPI postsAPI = PostsAPI();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:postsAPI.fetChPostsById(2) ,
      // ignore: missing_return
      builder: (context, snapShot){
        switch(snapShot.connectionState){
          case ConnectionState.none :
            return connectionError();
            break;
          case ConnectionState.active :
            return loading();
            break;
          case ConnectionState.waiting :
            return loading() ;
            break ;
          case ConnectionState.done :
            if (snapShot.hasError){
              return error (snapShot.error);
            }else {
              List <Post> posts = snapShot.data;
              return  ListView.builder(
                itemBuilder: (context ,position){
                  return Card(
                    child: _drawSingleRaw(posts[position]),
                  );
                },
                itemCount: posts.length,
              );
            }
            break;
        }
      },
    );
  }
  Widget _drawSingleRaw (Post post){
    return Padding (
      padding: EdgeInsets.all(8.0),
      child: Card (
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:(){
                Navigator.push(context,
                MaterialPageRoute(builder: (context){
                return SinglePost(post);} ));
            },
              child: Row(children: <Widget>[
                SizedBox(
                  child: Image(image: NetworkImage(post.featuredImage),fit: BoxFit.cover,),
                  width: 124,
                  height: 124,
                ),
                SizedBox (width: 16,),
                Expanded(
                  child: Column(children: <Widget>[
                    Text(post.title , maxLines: 3, style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w700),),
                    SizedBox(height: 18,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(child: authorHandling(post)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.timer),
                              Text(parseHumanDateTime(post.dateWritten)),
                            ],),
                        )
                      ],),
                  ],),
                ),
              ],),
            ),
          )
        ],),
      ),
    );
  }
 
}
