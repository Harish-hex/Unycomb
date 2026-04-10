import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/data/network/websocket_client.dart';

part 'realtime_match_state.dart';

class RealtimeMatchCubit extends Cubit<RealtimeMatchState> {
  RealtimeMatchCubit({required WebSocketClient webSocketClient})
      : _webSocketClient = webSocketClient,
        super(const RealtimeMatchIdle());

  final WebSocketClient _webSocketClient;
  StreamSubscription<String>? _subscription;

  Future<void> subscribe() async {
    await _subscription?.cancel();
    emit(const RealtimeMatchListening());
    _subscription = _webSocketClient.messages.listen(
      (String message) => emit(RealtimeMatchEvent(message)),
    );
  }

  void emitRequest(String userId) {
    _webSocketClient.emit('request:$userId');
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
