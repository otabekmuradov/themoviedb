import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/entity/favorite_movies_list.dart';

part 'favorite_movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteMovies {
  final int page;
  final List<FavoriteMoviesList> results;
  final int totalPages;
  final int totalResults;

  FavoriteMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory FavoriteMovies.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMoviesToJson(this);
}
