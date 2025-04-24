import 'package:flutter/material.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:movie_picker/widgets/big_card.dart';
import 'package:movie_picker/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => appState.fetchMovies(), child: Text("Fetch movies")),
          BigCard(pair: pair),
          SizedBox(height: 10),
          SwipeableCards()
        ],
      ),
    );
  }
}
