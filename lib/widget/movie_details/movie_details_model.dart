import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final int movieId;
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  Future<void>? Function()? onSessionExpired;
  MovieDetailsModel(this.movieId);

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

  final _dateFormat = DateFormat('MM/dd/yyyy');
  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale() async {
    await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _movieDetails = await _apiClient.movieDetails(movieId, 'en-US');
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.SessionExpired:
          await onSessionExpired?.call();
          break;
        default:
          print(e);
      }
    }
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    try {
      await _apiClient.markAsFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.Movie,
          mediaId: movieId,
          isFavorite: _isFavorite);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.SessionExpired:
          await onSessionExpired?.call();
          break;
        default:
          print(e);
      }
    }
  }
}
