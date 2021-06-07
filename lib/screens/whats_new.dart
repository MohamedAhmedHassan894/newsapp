import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/modules/post.dart';
import 'package:newsapp/utilities/data_utilities.dart';
import 'package:newsapp/single_post.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w100);
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );

    return FutureBuilder(
      future: postsAPI.fetChPostsById(1),
      // ignore: missing_return
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
            return connectionError();
            break;
          case ConnectionState.done:
            if (snapshot.error != null) {
              return error(snapshot.error);
            } else {
              List<Post> posts =snapshot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SinglePost(post);
                  }));
                },
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.featuredImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 48, right: 48),
                            child: Text(
                              post.title,
                              style: _headerTitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34, right: 34),
                            child: Text(
                              (post.author.contains("www") ||
                                      post.author.contains("null")
                                  ? "Social Media"
                                  : post.author),
                              //post.content.substring( 0 , 75 ),//
                              style: _headerDescription,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            break;
        }
      },
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetChPostsById(1),
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return loading();
                      break;
                    case ConnectionState.active:
                      return loading();
                      break;
                    case ConnectionState.none:
                      return connectionError();
                      break;
                    case ConnectionState.done:
                      if (snapShot.error != null) {
                        return error(snapShot.error);
                      } else {
                        if (snapShot.hasData) {
                          List<Post> posts = snapShot.data;
                          Random random = Random();
                          int row1 = random.nextInt(posts.length);
                          int row2 = random.nextInt(posts.length);
                          int row3 = random.nextInt(posts.length);
                          if (posts.length >= 3) {
                            Post post1 = snapShot.data[row1];
                            Post post2 = snapShot.data[row2];
                            Post post3 = snapShot.data[row3];
                            return Column(
                              children: <Widget>[
                                _drawSingleRow(post1),
                                _drawDivider(),
                                _drawSingleRow(post2),
                                _drawDivider(),
                                _drawSingleRow(post3),
                              ],
                            );
                          } else {
                            return noData();
                          }
                        } else {
                          return noData();
                        }
                      }
                      break;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade100,
    );
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SinglePost(post);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Image.network(
                post.featuredImage,
                fit: BoxFit.cover,
              ),
              width: 124,
              height: 124,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 4,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      authorHandling(post),
                      Row(
                        children: <Widget>[
                          Icon(Icons.timer),
                          Text(parseHumanDateTime(post.dateWritten)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawRecentUpdates() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: postsAPI.fetChPostsById(2),
        // ignore: missing_return
        builder: (context, AsyncSnapshot snapShot) {
          List<Post> posts = snapShot.data;
          Random random = Random();
          int sportPost = random.nextInt(posts.length);
          int businessPost = random.nextInt(posts.length);
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              return connectionError();
              break;
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.done:
              if (snapShot.hasError) {
                return error(snapShot.error);
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 8, top: 8),
                      child: _drawSectionTitle('Recent Updates'),
                    ),
                    _drawRecentUpdatesCard(
                        Colors.deepOrange, snapShot.data[sportPost]),
                    _drawRecentUpdatesCard(
                        Colors.teal, snapShot.data[businessPost]),
                    SizedBox(
                      height: 48,
                    ),
                  ],
                );
              }
              break;
          }
        },
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }

  Widget _drawRecentUpdatesCard(Color color, Post post) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SinglePost(post);
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.featuredImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Container(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Business",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              child: Text(
                post.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    parseHumanDateTime(post.dateWritten),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
