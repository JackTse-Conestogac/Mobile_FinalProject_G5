import 'package:flutter/material.dart';
import '../entities/User.dart';

class BlogApiScreen extends StatefulWidget {
  // Properties

  const BlogApiScreen({Key? key}) : super(key: key);

  //static const

  @override
  State<BlogApiScreen> createState() => _BlogApiScreenState();
}

class _BlogApiScreenState extends State<BlogApiScreen> {
  @override
  Widget build(BuildContext context) {
 // Access the passed user object

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog API Search'),
        ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://picsum.photos/250?image=9'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.link),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.email),
                ),
              ],
            )
          ],
        ));
  }
}
