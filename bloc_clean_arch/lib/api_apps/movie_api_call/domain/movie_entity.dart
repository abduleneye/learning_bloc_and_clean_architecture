class MovieAlbum {
  final int userId;
  final int id;
  final String title;

  const MovieAlbum(
      {required this.id, required this.title, required this.userId});

  factory MovieAlbum.fromJson(Map<String, dynamic> json) {
    return MovieAlbum(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}
