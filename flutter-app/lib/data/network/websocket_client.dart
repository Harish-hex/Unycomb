import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  WebSocketClient();

  final StreamController<String> _fallbackController =
      StreamController<String>.broadcast();
  WebSocketChannel? _channel;

  Stream<String> get messages =>
      _channel?.stream.cast<String>() ?? _fallbackController.stream;

  Future<void> connect(String url) async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
    } catch (_) {
      _channel = null;
    }
  }

  void emit(String event) {
    if (_channel != null) {
      _channel!.sink.add(event);
      return;
    }
    _fallbackController.add(event);
  }

  Future<void> dispose() async {
    await _channel?.sink.close();
    await _fallbackController.close();
  }
}
