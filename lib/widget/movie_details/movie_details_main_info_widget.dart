import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/entity/movie_details_credits.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

import 'package:themoviedb/widget/elements/radial_percent_widget.dart';
import 'package:themoviedb/widget/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final tagLine = movieDetails?.tagline;
    final overview = movieDetails?.overview;

    return Column(
      children: [
        const _TopPosterWidget(),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: MovieNameWidget(),
        ),
        const _ScoreWidget(),
        const _ShortInfoWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$tagLine',
                  style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                      fontStyle: FontStyle.italic)),
              const SizedBox(
                height: 13,
              ),
              const Text('Overview',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7)),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$overview',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 20),
              const _CrewWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CrewWidget extends StatelessWidget {
  const _CrewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    var crew = movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    if (movieDetails == null) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Crew>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: crewChunks
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _CrewWidgetRow(crews: chunk),
            ),
          )
          .toList(),
    );
  }
}

class _CrewWidgetRow extends StatelessWidget {
  final List<Crew> crews;
  const _CrewWidgetRow({
    Key? key,
    required this.crews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: crews
          .map(
            (crew) => _CrewWidgetItem(
              crew: crew,
            ),
          )
          .toList(),
    );
  }
}

class _CrewWidgetItem extends StatelessWidget {
  final Crew crew;
  const _CrewWidgetItem({super.key, required this.crew});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(crew.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.7)),
          Text(crew.job,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            left: 20,
            top: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: Icon(
                model?.isFavorite == true
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                size: 30,
                color: Colors.white,
              ),
            ),
            top: 10,
            right: 10,
          )
        ],
      ),
    );
  }
}

class MovieNameWidget extends StatelessWidget {
  const MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';

    return RichText(
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
          text: model?.movieDetails?.title ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
        ),
        TextSpan(
          text: year,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 21,
          ),
        ),
      ]),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;

    final videos = movieDetails?.videos.results
        .where((video) => video.site == 'YouTube' && video.type == 'Trailer');
    final trailerKey = videos!.isNotEmpty ? videos.first.key : null;
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                RadialPercentageWidget(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'User Score',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7),
                )
              ],
            ),
          ),
          Container(
            width: 1,
            height: 15,
            color: Colors.grey,
          ),
          trailerKey != null
              ? TextButton(
                  onPressed: () => Navigator.pushNamed(
                      context, MainNavigationRouteNames.movieTrailerWidget,
                      arguments: trailerKey),
                  child: const Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.play,
                        size: 13,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Play Trailer',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ShortInfoWidget extends StatelessWidget {
  const _ShortInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = [];
    final releaseDate = model.movieDetails?.releaseDate;

    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add(' (${productionCountries.last.iso}) ');
    }
    final runtime = model.movieDetails?.runtime ?? 0;

    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    var genresNames = <String>[];
    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
    }

    return Container(
      height: 80,
      width: double.infinity,
      color: const Color(0xff01101a),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'R',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Text(
                texts.join(''),
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
              Text(
                '• ${hours}h ${minutes}m',
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                genresNames.join(', '),
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
