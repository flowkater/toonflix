class MovieModel {
  final String title, thumb;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id = json['id'];

  @override
  String toString() {
    return " id: $id, title: $title, thumb: $thumb";
  }

  String thumbUrl() {
    return "https://image.tmdb.org/t/p/w500/$thumb";
  }
}
