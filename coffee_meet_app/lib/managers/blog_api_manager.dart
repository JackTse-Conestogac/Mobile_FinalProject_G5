import 'dart:convert';

import 'package:coffee_meet_app/entities/blog_post.dart';
import 'package:http/http.dart';


class BlogApiManager{
  static Future<List<BlogPost>> getBlogContentByTitleName(String title) async{

    String url = "https://api.spaceflightnewsapi.net/v4/blogs/?search=${title}";
    Response response = await get(Uri.parse(url));

    dynamic data = jsonDecode(response.body);

    List<BlogPost> blogPosts = [];
    List<dynamic> results = data["results"];

    for (dynamic result in results){
      BlogPost post = BlogPost.fromJson(result);
      blogPosts.add(post);
      print("blogPost added");
    }
    return blogPosts;
  }

}