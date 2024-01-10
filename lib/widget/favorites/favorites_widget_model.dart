import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/entity/favorite_movies_list.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class FavoriteMoviesModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();

  final _apiClient = ApiClient();
  final _movies = <FavoriteMoviesList>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;

  List<FavoriteMoviesList> get movies => List.unmodifiable(_movies);
  final _dateFormat = DateFormat.yMMMMd();
  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await loadMovies();
  }

  Future<void> loadMovies() async {
    if (_isLoadingInProgres || _currentPage >= _totalPage) return;
    _isLoadingInProgres = true;
    final nextPage = _currentPage + 1;

    try {
      final accountId = await _sessionDataProvider.getAccountId();
      final sessionId = await _sessionDataProvider.getSessionId();

      final moviesResponse = await _apiClient.favoriteMovies(
          accountId!, sessionId!, "en-US", nextPage);

      _movies.addAll(moviesResponse.results);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgres = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgres = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    loadMovies();
  }
}
