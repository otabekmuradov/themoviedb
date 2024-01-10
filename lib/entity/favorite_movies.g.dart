// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovies _$FavoriteMoviesFromJson(Map<String, dynamic> json) =>
    FavoriteMovies(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => FavoriteMoviesList.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$FavoriteMoviesToJson(FavoriteMovies instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
