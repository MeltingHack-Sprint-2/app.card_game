part of 'host_bloc.dart';

class HostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HostFormPropertyChanged extends HostEvent {
  final HostFormPropertyType type;
  final String value;

  HostFormPropertyChanged({required this.type, required this.value});
}

class HostGameEvent extends HostEvent {
  final String name;
  final String handSize;
  final String room;

  HostGameEvent(
      {required this.name, required this.room, required this.handSize});
}
