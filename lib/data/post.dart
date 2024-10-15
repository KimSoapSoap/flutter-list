class Post {
  int id;
  String title;
  String content;
  String createdAt;
  String updateAt;

  Post(this.id, this.title, this.content, this.createdAt, this.updateAt);

  // Get 요청시 사용
  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        title = json["title"] ?? "",
        content = json["content"] ?? "",
        createdAt = json["createdAt"] ?? "",
        updateAt = json["updateAt"] ?? "";
}
