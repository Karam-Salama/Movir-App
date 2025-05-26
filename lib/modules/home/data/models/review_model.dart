class MovieReviewModel {
  String? author;
  AuthorDetails? authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;

  MovieReviewModel({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory MovieReviewModel.fromJson(Map<String, dynamic> json) {
    return MovieReviewModel(
      author: json['author'],
      authorDetails: json['author_details'] != null
          ? AuthorDetails.fromJson(json['author_details'])
          : null,
      content: json['content'],
      createdAt: json['created_at'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
    );
  }
}

class AuthorDetails {
  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: json['rating'],
    );
  }
}
