import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:provider/provider.dart';

class SwipeableCards extends StatelessWidget {
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

    var appState = context.watch<MyAppState>();

    var movies = appState.currentMovies;

    if(movies.isEmpty) {
      return Text("No movies available.");
    }

    return Flexible(
        child: CardSwiper(
            cardBuilder: (context, index, thresholdX, thresholdY) {

              var posterPath = "https://image.tmdb.org/t/p/w500" + appState.currentMovies[index]['poster_path'];

              return Container(
                alignment: Alignment.center,
                child: Image.network(posterPath),
              );
            },
            cardsCount: appState.currentMovies.length));
  }
}
