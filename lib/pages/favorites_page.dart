import 'package:flutter/material.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:movie_picker/widgets/big_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final theme = Theme.of(context);
    final style1 = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );

    return ListView(
      children: [
        Text('Favorites', style: style1,),
        for (var favorite in appState.favorites)
          BigCard(pair: favorite)
      ],
    );
  }
}
