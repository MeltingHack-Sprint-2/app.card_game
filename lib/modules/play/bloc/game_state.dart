part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    this.isConnected = false,
    this.started = false,
    this.players = const [],
    this.hands = const {},
    this.topCard,
    this.errorMessage,
    required this.config,
    required this.currentPlayer,
  });

  final bool isConnected;
  final bool started;
  final List<Player> players;
  final Hands hands;
  final CardModel? topCard;
  final String? errorMessage;
  final GameConfig config;
  final Player currentPlayer;

  GameState copyWith({
    bool? isConnected,
    bool? started,
    List<Player>? players,
    Map<String, List<CardModel>>? hands,
    CardModel? topCard,
    String? errorMessage,
    GameConfig? config,
    Player? currentPlayer,
  }) {
    return GameState(
      isConnected: isConnected ?? this.isConnected,
      started: started ?? this.started,
      players: players ?? this.players,
      hands: hands ?? this.hands,
      topCard: topCard ?? this.topCard,
      errorMessage: errorMessage ?? this.errorMessage,
      config: config ?? this.config,
      currentPlayer: currentPlayer ?? this.currentPlayer,
    );
  }

  @override
  List<Object?> get props => [
    isConnected,
    started,
    players,
    hands,
    topCard,
    errorMessage,
    config,
    currentPlayer,
  ];
}

