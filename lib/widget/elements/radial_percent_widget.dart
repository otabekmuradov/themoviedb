import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/widget/movie_details/movie_details_model.dart';

class RadialPercentageWidget extends StatefulWidget {
  const RadialPercentageWidget({super.key});

  @override
  State<RadialPercentageWidget> createState() => _RadialPercentageWidgetState();
}

class _RadialPercentageWidgetState extends State<RadialPercentageWidget> {
  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final voteAverage = movieDetails?.voteAverage ?? 0;

    var _indicatorColor;
    var _backIndiColor;

    if (voteAverage == 0) {
      _indicatorColor = const Color.fromRGBO(102, 102, 102, 1);
      _backIndiColor = const Color.fromRGBO(102, 102, 102, 1);
    } else if (1 <= voteAverage && voteAverage <= 3.9) {
      _indicatorColor = const Color.fromRGBO(225, 36, 96, 1);
      _backIndiColor = const Color.fromRGBO(90, 20, 52, 1);
    } else if (4 <= voteAverage && voteAverage <= 6.9) {
      _indicatorColor = const Color.fromRGBO(211, 214, 77, 1);
      _backIndiColor = const Color.fromRGBO(67, 61, 21, 1);
    } else if (7 <= voteAverage) {
      _indicatorColor = const Color.fromRGBO(118, 255, 77, 1);
      _backIndiColor = const Color(0xff204529);
    }

    final scoreIndicator = (voteAverage / 10).abs();

    var scorePercent;

    if (voteAverage <= 0.89) {
      scorePercent = 'NR';
    } else if (voteAverage >= 0.9) {
      scorePercent = ((voteAverage * 10).truncate() + 1).toString();
      scorePercent = '$scorePercent%';
    }

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF081c22),
      ),
      height: 55,
      width: 60,
      child: CircularPercentIndicator(
        radius: 25,
        lineWidth: 3,
        percent: scoreIndicator,
        progressColor: _indicatorColor,
        backgroundColor: _backIndiColor,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          '$scorePercent',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}
