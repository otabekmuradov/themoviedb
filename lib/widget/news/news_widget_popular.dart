import 'package:themoviedb/widget/elements/radial_percent_widget.dart';
import 'package:flutter/material.dart';

class NewsWidgetPopular extends StatefulWidget {
  const NewsWidgetPopular({Key? key}) : super(key: key);

  @override
  _NewsWidgetPopularState createState() => _NewsWidgetPopularState();
}

class _NewsWidgetPopularState extends State<NewsWidgetPopular> {
  final _catrgory = 'movies';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'What`s Popular',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              DropdownButton<String>(
                value: _catrgory,
                onChanged: (catrgory) {},
                items: [
                  const DropdownMenuItem(
                      value: 'movies', child: Text('Movies')),
                  const DropdownMenuItem(value: 'tv', child: Text('TV')),
                  const DropdownMenuItem(
                      value: 'tvShows', child: Text('TVShows')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 306,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemExtent: 140,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                Image.asset('assets/images/tinagemutant.jpg'),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.more_horiz),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          child: SizedBox(
                            width: 50,
                            height: 60,
                            child: RadialPercentageWidget(),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text(
                        'Willy`s Wonderland',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text('Feb 12, 2021'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
