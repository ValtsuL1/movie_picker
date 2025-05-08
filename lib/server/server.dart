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
  final Map<String, String> userValues = {};

  @override
  Stream<StateMessage> streamState(ServiceCall call, Stream<StateMessage> request) {
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen((msg){
      currentUser = msg.user;
      clients[msg.user] = controller;
      userValues[msg.user] = msg.data;

      for(var entry in userValues.entries) {
        if(entry.key != msg.user && entry.value == msg.data) {
          final matchMessage = StateMessage()
          ..user = 'server'
          ..data = entry.value;

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