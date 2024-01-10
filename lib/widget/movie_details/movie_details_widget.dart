import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/widget/app/my_app_model.dart';

import 'package:themoviedb/widget/movie_details/movie_details_main_screen_cast_widget.dart';
import 'package:themoviedb/widget/movie_details/movie_details_model.dart';

import 'movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});
  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              'assets/images/themoviedb_logo.png',
              height: 35,
            )),
        body: const ColoredBox(
          color: Color(0xFF001422),
          child: _BodyWidget(),
        ));
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromARGB(255, 3, 37, 65),
      ));
    }
    return ListView(
      children: [
        MovieDetailsMainInfoWidget(),
        MovieDetailsMainScreenCastWidget()
      ],
    );
  }
}
