import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_picker/pages/my_home_page.dart';
import 'package:movie_picker/providers/moviepicker.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyAppState()),
      ChangeNotifierProvider(create: (_) => MoviePickerProvider())],
    child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Picker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}
