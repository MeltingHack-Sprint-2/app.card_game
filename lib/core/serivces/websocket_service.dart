import 'package:card_game/core/config/app_instance.dart';
import 'package:card_game/modules/play/api/enums/game_events.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:card_game/modules/play/bloc/game_bloc.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  // Logs messages to the console
  final _logger = Logger();
  // Socket
  late IO.Socket _socket;
  // Callback function
  late Function(GameEvent) listener;
  // Get websocket url
  final String wsUrl = AppInstance().config()!.wsUrl;
  // Connection state
  bool _isConnected = false;

  factory SocketService({required Function(GameEvent) listener}) {
    _instance.listener = listener;
    return _instance;
  }

  SocketService._internal();

  void connect({required GameConfig config, required Player currentPlayer}) {
    _socket = IO.io(
        wsUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    _socket.onConnect((_) {
      _isConnected = true;
      listener(ConnectSocket());
      _logger.d("Connected to $wsUrl");
      _socket.emit('message', {
        'event': Events.PLAYER_JOIN,
        'data': config.toJson(),
      });
    });
    // Disconnect
    _socket.onDisconnect((_) {
      _isConnected = false;
      listener(DisconnectSocket());
      _logger.d("Disconnected from $wsUrl");
    });
    // On message
    _socket.on('message', (data) {
      listener(HandleSocketMessage(data));
    });

    // On game notify
    _socket.on(Events.GAME_NOTIFY, (data) {
      listener(HandleSocketMessage(data));
    });
    // On game state interval
    _socket.on(Events.GAME_ROOM, (data) {
      listener(GameStateInterval());
    });

    // On game over
    _socket.on(Events.GAME_OVER, (data) {
      listener(HandleGameOver(data));
    });

    // On game start
    _socket.on(Events.GAME_START, (_) {
      listener(GameStateInterval());
    });

    // Reconnect handling
    _socket.onReconnect((_) {
      _logger.d("Reconnected to $wsUrl");
      _socket.emit('message', {
        'event': Events.PLAYER_JOIN,
        'data': config.toJson(),
      });
      if (_isConnected) {
        _socket.emit('message', {
          'event': Events.GAME_START,
          'data': {
            'room': config.room,
            'hand_size': config.handSize,
          }
        });
      }
    });

    // Connect to the socket server
    _socket.connect();
  }

  void sendMessage(String event, dynamic data) {
    _socket.emit(event, data);
  }

  // Fetch connectin state
  bool isConnected() {
    return _isConnected;
  }

  // Disconnect and close
  void disconnect() {
    _socket.close();
    _socket.dispose();
    _isConnected = false;
    _logger.d("Disconnected and disposed socket");
  }
}
