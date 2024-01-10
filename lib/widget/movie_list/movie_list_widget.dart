import 'package:flutter/material.dart';

import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../Library/Widgets/Inherited/provider.dart';
import 'movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);

    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Scrollbar(
          thickness: 5,
          radius: const Radius.circular(20),
          trackVisibility: true,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.movies.length,
            itemExtent: 175,
            itemBuilder: (BuildContext context, index) {
              model.showedMovieAtIndex(index);
              final movie = model.movies[index];
              final posterPath = movie.posterPath;
              return Padding(
                padding: const EdgeInsets.only(left: 19, top: 10, right: 19),
                child: Stack(
                  children: [
                    Card(
                      shadowColor: const Color.fromARGB(255, 255, 250, 250)
                          .withOpacity(0.6),
                      elevation: 5.9,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: posterPath != null
                                ? Image.network(
                                    ApiClient.imageUrl(posterPath),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 18, bottom: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 0.6),
                                  ),
                                  Text(model.stringFromDate(movie.releaseDate),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 153, 153, 153),
                                        fontSize: 17,
                                        letterSpacing: 0.3,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 15),
                                    child: Text(
                                      movie.overview,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14.99),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => model.onMovieTap(context, index),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 19, top: 10, right: 19),
          child: TextField(
            onChanged: model.searchMovie,
            decoration: InputDecoration(
                labelText: 'Find',
                filled: true,
                fillColor: Colors.white.withAlpha(235),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
