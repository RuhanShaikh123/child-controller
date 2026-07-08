import 'dart:typed_data';

import 'package:web_socket_channel/io.dart';

class WebSocketService {

  static final WebSocketService instance =
  WebSocketService._();

  WebSocketService._();

  late IOWebSocketChannel channel;

  Future<void> connect(String familyId) async {

    channel = IOWebSocketChannel.connect(
      Uri.parse(
        "wss://parental-control-server-bckk.onrender.com",
      ),
    );

    channel.sink.add(
      '{"type":"register","role":"child","familyId":"$familyId"}',
    );
  }

  void sendAudio(Uint8List bytes) {
    channel.sink.add(bytes);
  }

  void disconnect() {
    channel.sink.close();
  }
}