part of 'join_bloc.dart';

class JoinState extends Equatable {
  const JoinState({
    this.errorMessage,
    this.name = const FormPropertyItem(),
    this.room = const FormPropertyItem(),
    this.inProgress = false,
  });

  final String? errorMessage;
  final bool inProgress;
  final FormPropertyItem name;
  final FormPropertyItem room;

  JoinState copyWith({String? errorMessage, bool inProgress = false}) {
    return JoinState(
        errorMessage: errorMessage ?? this.errorMessage,
        inProgress: inProgress,
        name: name,
        room: room);
  }

  JoinState _copyWithProperty(
      {FormPropertyItem? name, FormPropertyItem? room}) {
    return JoinState(
      name: name ?? this.name,
      room: room ?? this.room,
    );
  }

  JoinState copyWithPropertyType({
    required ValidationType? validator,
    required JoinFormPropertyType type,
    String? value,
    bool? valueIsDirty,
    String? valueInvalidMessage,
  }) {
    final isValid = validator != null
        ? value?.isValidFor(validator) == true
        : (value?.length ?? 0) > 0;

    return _copyWithProperty(
        name: type == JoinFormPropertyType.name
            ? name.copyWith(
                value, isValid ? null : valueInvalidMessage, valueIsDirty)
            : null,
        room: type == JoinFormPropertyType.room
            ? room.copyWith(
                value, isValid ? null : valueInvalidMessage, valueIsDirty)
            : null);
  }

  bool get isValid {
    return name.propertyIsValid && room.propertyIsValid;
  }

  @override
  List<Object?> get props => [errorMessage, inProgress, name, room];
}

class JoinSuccessState extends JoinState {
  final Player currentPlayer;
  final GameConfig config;

  const JoinSuccessState({required this.config, required this.currentPlayer});
}
