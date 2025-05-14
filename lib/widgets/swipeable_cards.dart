import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:movie_picker/providers/moviepicker.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class SwipeableCards extends StatelessWidget {

  final List<Movie> movies;

  SwipeableCards(this.movies);

  List<Widget> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.amber,
      child: Text("First"),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: Text("Second"),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.cyan,
      child: Text("Third"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();

    var moviePicker = context.read<MoviePickerProvider>();

    print("Movies:");
    print(movies);

    if (movies.isEmpty) {
      return Text("No movies available.");
    }

    return Flexible(
        child: CardSwiper(
            cardBuilder: (context, index, thresholdX, thresholdY) {
              var baseUrl = "https://image.tmdb.org/t/p/w500";
              var posterPath = movies[index].posterPath;
              var posterUrl = baseUrl + posterPath;

              return Container(
                alignment: Alignment.center,
                child: Image.network(posterUrl),
              );
            },
            cardsCount: movies.length,
            onSwipe: (
                int previousIndex,
                int? currentIndex,
                CardSwiperDirection direction) async {
              debugPrint('Card $previousIndex was swiped to the ${direction.name}. Now card $currentIndex is on top');

              if (direction == CardSwiperDirection.right) {
                moviePicker.send(movies[previousIndex].originalTitle);
              }

              return true;
            },
            isLoop: false,
            allowedSwipeDirection: AllowedSwipeDirection.only(left: true, right: true),
            ));
  }
}
