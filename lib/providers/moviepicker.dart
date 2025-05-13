import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:movie_picker/generated/moviepicker.pbgrpc.dart';
import 'package:movie_picker/providers/my_app_state.dart';

class MoviePickerProvider extends ChangeNotifier {

  late final ClientChannel _channel;
  late final MoviePickerClient _stub;
  late final StreamController<StateMessage> _send;
  late final ResponseStream _receive;

  var appState = MyAppState();

  MoviePickerProvider() {

    _channel = ClientChannel('10.0.2.2', port: 50051, options: ChannelOptions(
      credentials:  ChannelCredentials.insecure()
    ));

    _stub = MoviePickerClient(_channel);
    _send = StreamController<StateMessage>();
    _receive = _stub.streamState(_send.stream);

    _receive.listen((msg){
      print("message from server: ${msg.user}: ${msg.data}");
    });
  }

  void send(movieTitle) {
    var msg = StateMessage()
    ..data = movieTitle 
    ..user = appState.userName;

    _send.add(msg);

  }

}