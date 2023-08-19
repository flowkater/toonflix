// - [x] 영화의 포스터 thumb
// - [x] 영화의 제목 title
// - [x] 영화의 등급
// - [x] 영화의 개요 overview
// - [x] 영화의 장르 genre

class MovieDetailModel {
  final String title, thumb, overview, homepage;
  final int id, grade, runtime;
  final List<GenreModel> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        homepage = json['homepage'],
        thumb = "https://image.tmdb.org/t/p/w500/${json['poster_path']}",
        genres = json['genres']
            .map<GenreModel>((genre) => GenreModel(genre['id'], genre['name']))
            .toList(),
        grade = (json['vote_average'] / 2).round(),
        runtime = json['runtime'],
        id = json['id'];

  String genresToString() {
    return genres.map<String>((genre) => genre.name).toList().join(', ');
  }

  String minutesToString() {
    return "${runtime ~/ 60}h ${runtime % 60}m";
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel(this.id, this.name);
}
