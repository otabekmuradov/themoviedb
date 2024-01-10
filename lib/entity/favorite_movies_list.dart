import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/entity/movie_data_parser.dart';

part 'favorite_movies_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteMoviesList {
  final bool adult;
  final String? backdropPath;
  final List<int> genre_ids;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseMovieDataFromString)
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  FavoriteMoviesList({
    required this.adult,
    required this.backdropPath,
    required this.genre_ids,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory FavoriteMoviesList.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMoviesListFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMoviesListToJson(this);
}
