import 'dart:async';

import 'package:card_game/core/router/routes.dart';
import 'package:card_game/modules/play/api/enums/game_action.dart';
import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/api/models/card_model.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameState with ChangeNotifier {
  late IO.Socket socket;
  bool isConnected = false;
  bool started = true;
  List<Player> players = [];
  // late GameConfig config;
  GameConfig config = GameConfig(
      action: GameAction.join, name: "Zuqo", room: "room", handSize: 7);
  late Player currentPlayer = Player(id: "1", name: "Zuqo");
  Timer? _refetchTimer;
  Map<String, List<CardModel>> hands = {};
  CardModel? topCard;

  GameState() {
    // Initialize SocketIO
    socket = IO.io(
        'http://socket_url',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect() // Disable auto-connect to manually connect
            .build());

    // Set up socket listeners
    socket.onConnect((_) {
      setConnected(true);
      socket.emit(
          'message', {'event': Events.PLAYER_JOIN, 'data': config.toJson()});
    });

    socket.onDisconnect((_) {
      setConnected(false);
    });
    socket.on('message', (data) {
      handleSocketMessage(data);
    });

    socket.on(Events.GAME_NOTIFY, (data) {
      handleSocketMessage(data);
    });

    socket.on(Events.GAME_ROOM, (data) {
      setPlayers((data['players'] as List)
          .map((player) => Player.fromJson(player))
          .toList());
    });

    socket.on(Events.GAME_OVER, (data){
      // handleGameOver(data, context);
    });

    socket.on(Events.GAME_START, (_) {
      setStarted(true);
    });

    // Reconnect handling
    socket.onReconnect((_) {
      socket.emit(
          'message', {'event': Events.PLAYER_JOIN, 'data': config.toJson()});
      if (started) {
        socket.emit('message', {
          'event': Events.GAME_START,
          'data': {'room': config.room, 'hand_size': config.handSize}
        });
      }
    });

    // Connect to the socket server
    socket.connect();
  }

  void refetchGameStateInterval() {
    _refetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      socket.emit(Events.GAME_STATE, {'room': config.room});
    });
  }

  void clearGameStateInterval() {
    _refetchTimer?.cancel();
  }

  void updateGameState(dynamic data) {
    hands = (data['hands'] as Map).map((key, value) => MapEntry(
        key, (value as List).map((card) => CardModel.fromJson(card)).toList()));
    topCard = CardModel.fromJson(data['top_card']);
    notifyListeners();
  }

  void handleGameOver(dynamic data, BuildContext context) {
    final reason = data['reason']; // What reason comes from the socket ??
    switch (reason) {
      case GameOverReason.won:
        final winner = Player.fromJson(data['winner']);
        Navigator.of(context).pushReplacementNamed(Routes.winScreen,
            arguments: {"winner": winner});
        break;
      case GameOverReason.insufficientPlayers:
        Fluttertoast.showToast(msg: 'Insufficient players. Refreshing...');
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        });
        break;
    }
  }

  void playCard(String playerId, String cardId) {
    socket.emit(Events.GAME_PLAY, {
      'player_id': playerId,
      'card_id': cardId,
      'room': config.room,
    });
  }

  void drawCard() {
    socket.emit(
        Events.GAME_DRAW, {'player_id': currentPlayer.id, 'room': config.room});
  }

  void handleSocketMessage(dynamic message) {
    // Handle incoming socket messages
    final event = message['event'];
    final data = message['data'];

    switch (event) {
      case Events.GAME_NOTIFY:
        handleGameNotify(data);
        break;
      case Events.GAME_ROOM:
        setPlayers((data['players'] as List)
            .map((player) => Player.fromJson(player))
            .toList());
        break;
      case Events.GAME_START:
        setStarted(true);
        break;
      default:
        break;
    }
  }

  void handleGameNotify(dynamic data) {
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

  void setConnected(bool status) {
    isConnected = status;
    notifyListeners();
  }

  void setStarted(bool status) {
    started = status;
    notifyListeners();
  }

  void setPlayers(List<Player> newPlayers) {
    players = newPlayers;
    notifyListeners();
  }

  @override
  void dispose() {
    socket.dispose();
    clearGameStateInterval();
    super.dispose();
  }
}

enum GameOverReason { won, insufficientPlayers }
