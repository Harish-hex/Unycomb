part of 'realtime_match_cubit.dart';

abstract class RealtimeMatchState extends Equatable {
  const RealtimeMatchState();

  @override
  List<Object?> get props => <Object?>[];
}

class RealtimeMatchIdle extends RealtimeMatchState {
  const RealtimeMatchIdle();
}

class RealtimeMatchListening extends RealtimeMatchState {
  const RealtimeMatchListening();
}

class RealtimeMatchEvent extends RealtimeMatchState {
  const RealtimeMatchEvent(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
