import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController(text: 'otabey');
  final passwordTextController = TextEditingController(text: 'otabek2004');
  bool passHide = true;
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Invalid Username or Password!';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage =
              'Server Error. Please, check your network connection!';
          break;
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Invalid Username or Password!';
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Something went wrong, please try again!';
          break;
        case ApiClientExceptionType.SessionExpired:
      }
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null || accountId == null) {
      _errorMessage = 'Unknown error, please try again!';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);

    unawaited(
        Navigator.pushNamed((context), MainNavigationRouteNames.mainScreen));
  }

  passHideFunc() {
    passHide = !passHide;
    notifyListeners();
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;

//   const AuthProvider({
//     super.key,
//     required this.model,
//     required super.child,
//   });

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget = context.getElementForInheritedWidgetOfExactType()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }
// }


