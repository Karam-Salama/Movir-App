class FavoriteModel {
  final String createdAt;
  final bool isFavorite;
  final String userId;
  final String movieId;

  FavoriteModel({
    required this.createdAt,
    required this.userId,
    required this.movieId,
    required this.isFavorite,
  });
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'userId': userId,
      'movieId': movieId,
      'isFavorite': isFavorite,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      createdAt: json['createdAt'] as String,
      userId: json['userId'] as String,
      movieId: json['movieId'] as String,
      isFavorite: json['isFavorite'] as bool,
    );
  }
}
