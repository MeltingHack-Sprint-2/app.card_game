part of 'host_bloc.dart';

class HostState extends Equatable {
  const HostState({
    this.errorMessage,
    this.name = const FormPropertyItem(),
    this.handSize = const FormPropertyItem(),
    // this.room = const FormPropertyItem(),
    this.inProgress = false,
  });

  final String? errorMessage;
  final bool inProgress;
  final FormPropertyItem name;
  final FormPropertyItem handSize;

  // final FormPropertyItem room;

  HostState copyWith({String? errorMessage, bool inProgress = false}) {
    return HostState(
      errorMessage: errorMessage ?? this.errorMessage,
      inProgress: inProgress,
      name: name,
      handSize: handSize,
    );
  }

  HostState _copyWithProperty({
    FormPropertyItem? name,
    // FormPropertyItem? room,
    FormPropertyItem? handSize,
  }) {
    return HostState(
      handSize: handSize ?? this.handSize,
      name: name ?? this.name,
      // room: room ?? this.room,
    );
  }

  HostState copyWithPropertyType({
    required ValidationType? validator,
    required HostFormPropertyType type,
    String? value,
    bool? valueIsDirty,
    String? valueInvalidMessage,
  }) {
    final isValid = validator != null
        ? value?.isValidFor(validator) == true
        : (value?.length ?? 0) > 0;

    return _copyWithProperty(
      name: type == HostFormPropertyType.name
          ? name.copyWith(
              value, isValid ? null : valueInvalidMessage, valueIsDirty)
          : null,
      handSize: type == HostFormPropertyType.handSize
          ? handSize.copyWith(
              value, isValid ? null : valueInvalidMessage, valueIsDirty)
          : null,
    );
  }

  bool get isValid {
    return name.propertyIsValid;
  }

  @override
  List<Object?> get props => [errorMessage, inProgress, name, handSize];
}

class HostSuccessState extends HostState {
  final String currentPlayer;
  final GameConfig config;

  const HostSuccessState({
    required this.config,
    required this.currentPlayer,
  });
}
