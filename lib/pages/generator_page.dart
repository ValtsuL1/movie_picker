import 'package:flutter/material.dart';
import 'package:movie_picker/models/movie.dart';
import 'package:movie_picker/providers/moviepicker.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:movie_picker/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var movieState = context.watch<MoviePickerProvider>();

    Future<void> showAlert() async {
      return showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Match found!"),
            content: Text(movieState.matchingMovie),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: Text("OK"))
            ],
          );
        });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (movieState.matchFound) {
        showAlert();
        }
      }
    );


    

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Movie>>(
            future: appState.fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.connectionState == ConnectionState.done
                  && !snapshot.hasError
                  && snapshot.hasData) {
                    return SwipeableCards(snapshot.data!);
              }

              return Text("Cant access movies");
            }
          ),
          Text(movieState.userName),
          TextFormField(controller: controller),
          TextButton(
            onPressed: () {
              print(controller.text);

              movieState.setUserName(controller.text);
            },
            child: Text("save username")),
            SizedBox(height: 30,),
        ],
      ),
    );
  }
}
