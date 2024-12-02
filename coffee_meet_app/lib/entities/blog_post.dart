class BlogPost{
  int blogId;
  String title;
  String summary;
  String publishedDate;
  String updatedDate;

  BlogPost.fromJson(Map<String, dynamic> json):
      this.blogId = json["id"],
      this.title = json["title"],
      this.summary = json["summary"],
      this.publishedDate = json["published_at"],
      this.updatedDate = json["updated_at"];

}