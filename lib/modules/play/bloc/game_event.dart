part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectSocket extends GameEvent {}

class DisconnectSocket extends GameEvent {}

class SendMessage extends GameEvent {
  final String event;
  final Map<String, dynamic> data;

  SendMessage({required this.event, required this.data});
}

class GameStateInterval extends GameEvent {}
class PlayerLeave extends GameEvent {}

class UpdateGameState extends GameEvent {
  final dynamic data;

  UpdateGameState(this.data);

  @override
  List<Object?> get props => [data];
}

class PlayCard extends GameEvent {
  final String playerId;
  final String cardId;

  PlayCard({required this.playerId, required this.cardId});
}

class DrawCard extends GameEvent {}

class HandleSocketMessage extends GameEvent {
  final dynamic message;

  HandleSocketMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class HandleGameOver extends GameEvent {
  final dynamic data;

  HandleGameOver(this.data);

  @override
  List<Object?> get props => [data];
}
