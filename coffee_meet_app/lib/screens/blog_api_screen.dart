import 'package:coffee_meet_app/entities/blog_post.dart';
import 'package:coffee_meet_app/managers/blog_api_manager.dart';
import 'package:flutter/material.dart';

class BlogApiScreen extends StatefulWidget {
  const BlogApiScreen({Key? key}) : super(key: key);

  @override
  State<BlogApiScreen> createState() => _BlogApiScreenState();
}

class _BlogApiScreenState extends State<BlogApiScreen> {
  final TextEditingController blogPostController = TextEditingController();
  String blogtitle = "";
  List<BlogPost> blogPosts = [];
  String message = ""; // Message to display if there are no results

  @override
  void dispose() {
    blogPostController.dispose();
    super.dispose();
  }

  Future<void> searchBlogs() async {
    final searchText = blogPostController.text.trim();
    if (searchText.isEmpty) {
      // Validation for empty search bar
      setState(() {
        message = "Search bar can not be empty.";
        blogPosts = [];
      });
      return;
    }

    try {
      List<BlogPost> retrievedBlogPosts =
      await BlogApiManager.getBlogContentByTitleName(searchText);
      setState(() {
        blogtitle = searchText;
        blogPosts = retrievedBlogPosts;
        message = retrievedBlogPosts.isEmpty ? "No results found for '$searchText'." : "";
      });
    } catch (e) {
      setState(() {
        message = "An error occurred: $e";
        blogPosts = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs API Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Enhanced Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: blogPostController,
                decoration: const InputDecoration(
                  hintText: 'Search for blogs...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: searchBlogs,
              child: const Text("Search"),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search with: $blogtitle",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${blogPosts.length} blogs found",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (message.isNotEmpty)
              Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (message.isNotEmpty) const SizedBox(height: 16), // Extra spacing
            Expanded(
              child: blogPosts.isEmpty
                  ? const Center() // Keep empty space if no blogs are present
                  : ListView.builder(
                itemCount: blogPosts.length,
                itemBuilder: (context, index) {
                  BlogPost blogPost = blogPosts[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title: ${blogPost.title}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Summary: ${blogPost.summary}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
