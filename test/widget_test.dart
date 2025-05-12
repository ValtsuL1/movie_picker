
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_picker/main.dart';
import 'package:movie_picker/providers/moviepicker.dart';
import 'package:movie_picker/providers/my_app_state.dart';
import 'package:provider/provider.dart';


void main() {
  testWidgets('Generator page rendering', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      (MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => MoviePickerProvider())],
      child: MyApp(),
      )));

    expect(find.text('Test grpc'), findsOneWidget);

    expect(find.text('Fetch movies'), findsOneWidget);

  });
}
