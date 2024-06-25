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
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final SocketService _socketService = SocketService(); // Singleton for ws
  late IO.Socket socket;
  Timer? _refetchTimer;
  final _logger = Logger();

  GameBloc(GameConfig config, Player currentPlayer)
      : super(GameState(config: config, currentPlayer: currentPlayer)) {
    // Set up socket listeners
    socket = _socketService.socket;

    // Connect
    socket.onConnect((_) {
      add(ConnectSocket());
      _logger.d("Connected");
      socket.emit('message',
          {'event': Events.PLAYER_JOIN, 'data': state.config.toJson()});
    });
    // Disconnect
    socket.onDisconnect((_) {
      add(DisconnectSocket());
    });

    // On message
    socket.on('message', (data) {
      add(HandleSocketMessage(data));
    });

    // On game notify
    socket.on(Events.GAME_NOTIFY, (data) {
      add(HandleSocketMessage(data));
    });

    // On game state interval
    socket.on(Events.GAME_ROOM, (data) {
      add(GameStateInterval());
    });

    // On game over
    socket.on(Events.GAME_OVER, (data) {
      add(HandleGameOver(data));
    });

    // On game start
    socket.on(Events.GAME_START, (_) {
      add(GameStateInterval());
    });

    // Reconnect handling
    socket.onReconnect((_) {
      socket.emit(
          'message', {'event': Events.PLAYER_JOIN, 'data': config.toJson()});
      if (state.started == true) {
        socket.emit('message', {
          'event': Events.GAME_START,
          'data': {'room': config.room, 'hand_size': config.handSize}
        });
      }
    });

    // Connect to the socket server
    socket.connect();

    // Listen to events
    on<ConnectSocket>(_onConnectSocket);
    on<DisconnectSocket>(_onDisconnectSocket);
    on<SendMessage>(_onSendMessage);
    on<GameStateInterval>(_onGameStateInterval);
    on<UpdateGameState>(_onUpdateGameState);
    on<PlayCard>(_onPlayCard);
    on<PlayerLeave>(_onPlayerLeave);
    on<DrawCard>(_onDrawCard);
    on<HandleSocketMessage>(_onHandleSocketMessage);
    on<HandleGameOver>(_onHandleGameOver);
  }

  void _onConnectSocket(ConnectSocket event, Emitter<GameState> emit) {
    emit(state.copyWith(isConnected: true));
  }

  void _onDisconnectSocket(DisconnectSocket event, Emitter<GameState> emit) {
    _logger.d("Disconnecting");
    emit(state.copyWith(isConnected: false));
  }

  void _onSendMessage(SendMessage event, Emitter<GameState> emit) {
    _logger.d("Message ${event.data}");
    socket.emit(event.event, event.data);
  }

  void _onGameStateInterval(GameStateInterval event, Emitter<GameState> emit) {
    _logger.d("Timmer!!");
    _refetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      socket.emit(Events.GAME_STATE, {'room': state.config.room});
    });
  }

  void _onUpdateGameState(UpdateGameState event, Emitter<GameState> emit) {
    final hands = (event.data['hands'] as Map).map((key, value) => MapEntry(key,
            (value as List).map((card) => CardModel.fromJson(card)).toList()))
        as Hands;
    final topCard = CardModel.fromJson(event.data['top_card']);
    _logger.d("Updating game state ${event.data['top_card']}");
    emit(state.copyWith(hands: hands, topCard: topCard));
  }

  void _onPlayerLeave(PlayerLeave event, Emitter<GameState> emit) {
    _logger.d("Player leaving ${state.config.name}");
    socket.emit(
      Events.PLAYER_LEAVE,
      {'name': state.config.name, 'room': state.config.room},
    );
  }

  void _onPlayCard(PlayCard event, Emitter<GameState> emit) {
    _logger.d("Playing card ${event.cardId}");
    socket.emit(Events.GAME_PLAY, {
      'player_id': event.playerId,
      'card_id': event.cardId,
      'room': state.config.room,
    });
  }

  void _onDrawCard(DrawCard event, Emitter<GameState> emit) {
    _logger.d("Drawing card ${state.currentPlayer.id}");
    socket.emit(Events.GAME_DRAW,
        {'player_id': state.currentPlayer.id, 'room': state.config.room});
  }

  void _onHandleSocketMessage(
      HandleSocketMessage event, Emitter<GameState> emit) {
    final eventType = event.message['event'];
    final data = event.message['data'];
    _logger.d("Handling socket Message ${data}");
    switch (eventType) {
      case Events.GAME_NOTIFY:
        _handleGameNotify(data);
        break;
      case Events.GAME_ROOM:
        final players = (data['players'] as List)
            .map((player) => Player.fromJson(player))
            .toList();
        emit(state.copyWith(players: players));
        break;
      case Events.GAME_START:
        emit(state.copyWith(started: true));
        break;
      default:
        break;
    }
  }

  void _handleGameNotify(dynamic data) {
    final type = data['type'];
    final message = data['message'];

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
    _logger.d("Handle Game Over ${event.data['reason']}");
    emit(state.copyWith(errorMessage: event.data['reason']));
  }

  void clearGameStateInterval() {
    _refetchTimer?.cancel();
  }

  @override
  Future<void> close() {
    socket.dispose();
    clearGameStateInterval();
    return super.close();
  }
}
