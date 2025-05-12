
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_picker/providers/my_app_state.dart';

void main() {
  test('Test for adding and removing favorite wordpairs', () {
    final myAppState = MyAppState();

    myAppState.getNext();

    myAppState.toggleFavorite();

    expect(myAppState.favorites.length, 1);

    myAppState.getNext();

    myAppState.toggleFavorite();

    expect(myAppState.favorites.length, 2);

    myAppState.toggleFavorite();

    expect(myAppState.favorites.length, 1);
  });
}