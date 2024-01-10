import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';

import 'package:themoviedb/widget/auth_screen/auth_model.dart';
import 'package:themoviedb/widget/auth_screen/auth_widget.dart';
import 'package:themoviedb/widget/main_screen/main_screen_model.dart';
import 'package:themoviedb/widget/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widget/movie_details/movie_details_model.dart';
import 'package:themoviedb/widget/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widget/movie_trailer/movie_trailer_widget.dart';

import 'package:themoviedb/widget/reg_screen/reg_screen.dart';
import 'package:themoviedb/widget/resetpass_screen/reset_screen.dart';
import 'package:themoviedb/widget/verifyemail_screen/verifyemail_screen.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailerWidget = '/movie_details/trailer';
  static const resetPassScreen = '/reset_screen';
  static const registerScreen = '/register_screen';
  static const verifyScreen = '/verify_screen';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        NotifierProvider(create: () => AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
        create: () => MainScreenModel(), child: const MainScreenWidget()),
    MainNavigationRouteNames.resetPassScreen: (context) =>
        const ResetPassScreen(),
    MainNavigationRouteNames.registerScreen: (context) =>
        const RegisterScreen(),
    MainNavigationRouteNames.verifyScreen: (context) =>
        const VerifyEmailScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        //final accountId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youTubeKey: youTubeKey),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
