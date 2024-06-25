import 'package:card_game/core/config/app_instance.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Singleton instance
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;
  // Get websocket url
  final String wsUrl = AppInstance().config()!.wsUrl;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    // Initialize SocketIO
    socket = IO.io(
        wsUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
  }
}
