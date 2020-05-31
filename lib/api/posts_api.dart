import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/modules/post.dart';
import 'package:newsapp/utilities/api_utilities.dart';


class PostsAPI {
  Future<List<Post>> fetChPostsById(int id ) async {
    String postApi ;
    if(id==1){
      postApi = base_api+top_stories_api;
    }
    if(id==2){
      postApi =base_api+recent_updates_api;
    }
    var response = await http.get(postApi);
    List<Post> posts = List<Post>();
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];

      for( var item in data ){
        Post post = Post(
            title: item["title"].toString(),
            description: item["description"].toString(),
            dateWritten: item["publishedAt"].toString(),
            featuredImage: item["urlToImage"].toString(),
            author: item["author"].toString(),
        );
        posts.add(post);
      }
    }

    return posts;

  }

}