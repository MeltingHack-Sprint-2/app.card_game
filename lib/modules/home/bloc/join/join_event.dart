part of 'join_bloc.dart';

class JoinEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class JoinFormPropertyChanged extends JoinEvent {
  final JoinFormPropertyType type;
  final String value;
  JoinFormPropertyChanged({required this.type, required this.value});
}

class JoinGameEvent extends JoinEvent{
  final String name;
  final String room;
  JoinGameEvent({required this.name, required this.room,});
}