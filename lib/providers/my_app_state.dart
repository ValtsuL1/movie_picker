import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_picker/models/movie.dart';

class MyAppState extends ChangeNotifier {

  List<Movie> currentMovies = [];

  Future<List<Movie>> fetchMovies() async {
    final Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1");

    var response = await http.get(url, headers: {
      "accept": "application/json",
      "authorization": "Bearer ${dotenv.env['API_READ_KEY']}"
    });

    var data = jsonDecode(response.body) as Map<String, dynamic>;

    List results = data['results'];

    return results.map((result) => Movie.fromJson(result)).toList();
  }

  AlertDialog sendMatchModal(String matchTitle) {
    return AlertDialog(
      title: const Text("Match found!"),
      content: Text(matchTitle),
    );
  }
}
