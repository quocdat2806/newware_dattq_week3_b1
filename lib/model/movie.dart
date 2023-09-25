import 'package:week3b2/model/cast.dart';

class Movie {
  final bool adult;
  final String poster_path;
  final String title;
  final String overview;
  final num vote_average;
  List<Cast> list;

  Movie(this.adult, this.poster_path, this.title, this.overview,
      this.vote_average, this.list);

  @override
  String toString() {
    return 'Movie{poster_path: $poster_path, title: $title, overview: $overview, vote_average: $vote_average, list: $list}';
  }
}
