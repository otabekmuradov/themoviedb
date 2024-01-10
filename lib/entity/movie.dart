import 'package:json_annotation/json_annotation.dart';

import 'package:themoviedb/entity/movie_data_parser.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: parseMovieDataFromString)
  final DateTime? releaseDate;
  final List<int> genre_ids;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie(
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genre_ids,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  );

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  toJson() => _$MovieToJson(this);
}
