import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/widget/movie_details/movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  MovieDetailsMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              'Top Billed Cast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 295,
            width: double.infinity,
            child: Scrollbar(
              thickness: 7,
              radius: const Radius.circular(10),
              trackVisibility: true,
              child: _ActorsListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Full Cast & Crew',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ActorsListWidget extends StatelessWidget {
  _ActorsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 15),
      itemCount: 10,
      itemExtent: 130,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _ActorsListsItemWidget(actorIndex: index);
      },
    );
  }
}

class _ActorsListsItemWidget extends StatelessWidget {
  _ActorsListsItemWidget({super.key, required this.actorIndex});
  final int actorIndex;
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final actor = model!.movieDetails!.credits.cast[actorIndex];
    final profilePath = actor.profilePath;

    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: Card(
        elevation: 5.9,
        shadowColor: Color.fromARGB(255, 255, 250, 250).withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: profilePath != null
                  ? Image.network(ApiClient.imageUrl(profilePath))
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actor.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      actor.character,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
