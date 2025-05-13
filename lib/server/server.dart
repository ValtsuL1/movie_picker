import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:movie_picker/generated/moviepicker.pbgrpc.dart';

Future<void> main() async {
  final server = Server.create(services: [MoviePickerService()]);

  final port = 50051;

  await server.serve(port: port);

  print('server running on port $port');
}

class MoviePickerService extends MoviePickerServiceBase {
  
  final Map<String, StreamController<StateMessage>> clients = {};
  final Map<String, List<String>> userValues = {};

  @override
  Stream<StateMessage> streamState(ServiceCall call, Stream<StateMessage> request) {
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen((msg){
      print(msg.data);

      currentUser = msg.user;
      clients[msg.user] = controller;
      
      if (userValues.containsKey(msg.user)) {
        userValues[msg.user]?.add(msg.data);
      } else {
        userValues[msg.user] = [msg.data];
      }

      print("Current server values: $userValues");
      print("Current user: $currentUser");

      for(var entry in userValues.entries) {
        if(entry.key != msg.user && entry.value.contains(msg.data)) {
          final matchMessage = StateMessage()
          ..user = 'server'
          ..data = msg.data;

          clients[entry.key]?.add(matchMessage);
          clients[msg.user]?.add(matchMessage);

          
        }
      }
    }, onDone: (){
      if(currentUser != null){
        clients.remove(currentUser);
        userValues.remove(currentUser);
      }
    });

    return controller.stream;
  }

}