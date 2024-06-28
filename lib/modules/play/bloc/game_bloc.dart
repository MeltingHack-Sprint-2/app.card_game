import 'dart:async';
import 'package:card_game/core/serivces/websocket_service.dart';
import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late SocketService _socketService;
  Timer? _refetchTimer;
  final _logger = Logger();
  GameBloc(GameConfig config, Player currentPlayer)
      : super(GameState(config: config, currentPlayer: currentPlayer)) {
    // Listen to events
    on<ConnectSocket>(_onConnectSocket);
    on<DisconnectSocket>(_onDisconnectSocket);
    on<SendMessage>(_onSendMessage);
    on<GameStateInterval>(_onGameStateInterval);
    on<UpdateGameState>(_onUpdateGameState);
    on<PlayCard>(_onPlayCard);
    on<PlayerLeave>(_onPlayerLeave);
    on<DrawCard>(_onDrawCard);
    on<HandleGameRoom>(_onHandleGameRoom);
    on<HandleGameNotify>(_handleGameNotify);
    on<HandleGameOver>(_onHandleGameOver);
    on<HandleGameStart>(_onHandleGameStart);

    // _logger.d("Attempting to Connect");
    _socketService = SocketService(listener: (event) {
      _logger.d("Recieved event $event");
      add(event);
    });

    _socketService.connect(config: config, currentPlayer: currentPlayer);
  }

  void _onHandleGameStart(HandleGameStart event, Emitter<GameState> emit) {
    emit(state.copyWith(started: true));
    _socketService.sendMessage(Events.GAME_START, {
      "room": state.config.room,
      "hand_size": state.config.handSize,
    });
  }

  void _onHandleGameRoom(HandleGameRoom event, Emitter<GameState> emit) {
    _logger.d("Game ROOM... ${event.data}");
    emit(state.copyWith(players: event.data));
  }

  void _onConnectSocket(ConnectSocket event, Emitter<GameState> emit) {
    emit(state.copyWith(isConnected: true));
  }

  void _onDisconnectSocket(DisconnectSocket event, Emitter<GameState> emit) {
    // _logger.d("Disconnecting");
    emit(state.copyWith(isConnected: false));
  }

  void _onSendMessage(SendMessage event, Emitter<GameState> emit) {
    // _logger.d("Message ${event.data}");
    _socketService.sendMessage(event.event, event.data);
  }

  void _onGameStateInterval(GameStateInterval event, Emitter<GameState> emit) {
    // _logger.d("Timmer!!");
    _refetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _socketService
          .sendMessage(Events.GAME_STATE, {'room': state.config.room});
    });
  }

  void _onUpdateGameState(UpdateGameState event, Emitter<GameState> emit) {
    final hands = (event.data['hands'] as Map).map((key, value) => MapEntry(key,
            (value as List).map((card) => CardModel.fromJson(card)).toList()))
        as Hands;
    final topCard = CardModel.fromJson(event.data['top_card']);
    // _logger.d("Updating game state ${event.data['top_card']}");
    emit(state.copyWith(hands: hands, topCard: topCard));
  }

  void _onPlayerLeave(PlayerLeave event, Emitter<GameState> emit) {
    _socketService.sendMessage(
      Events.PLAYER_LEAVE,
      {'name': state.config.name, 'room': state.config.room},
    );
    emit(PlayerLeaveState(
      config: state.config,
      currentPlayer: state.currentPlayer,
    ));
  }

  void _onPlayCard(PlayCard event, Emitter<GameState> emit) {
    // _logger.d("Playing card ${event.cardId}");
    _socketService.sendMessage(Events.GAME_PLAY, {
      'player_id': event.playerId,
      'card_id': event.cardId,
      'room': state.config.room,
    });
  }

  void _onDrawCard(DrawCard event, Emitter<GameState> emit) {
    _logger.d("Drawing card ${state.currentPlayer.id}");
    _socketService.sendMessage(Events.GAME_DRAW,
        {'player_id': state.currentPlayer.id, 'room': state.config.room});
  }

  void _handleGameNotify(HandleGameNotify event, Emitter<GameState> emit) {
    final type = event.data['type'];
    final message = event.data['message'];

    switch (type) {
      case 'info':
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blue,
            textColor: Colors.white);
        break;
      case 'success':
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        break;
      case 'warn':
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.orange,
            textColor: Colors.white);
        break;
      case 'error':
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        break;
      default:
        break;
    }
  }

  void _onHandleGameOver(HandleGameOver event, Emitter<GameState> emit) {
    // _logger.d("Handle Game Over ${event.data['reason']}");
    emit(state.copyWith(errorMessage: event.data['reason']));
  }

  void clearGameStateInterval() {
    _refetchTimer?.cancel();
  }

  @override
  Future<void> close() {
    _socketService.disconnect;
    clearGameStateInterval();
    return super.close();
  }
}
