import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:card_game/core/errors/error_mapper.dart';
import 'package:card_game/core/form/form_property/form_property.dart';
import 'package:card_game/core/form/form_property/form_property_type.dart';
import 'package:card_game/core/form/string_extension/string_validator.dart';
import 'package:card_game/modules/home/api/usecase/host_game_usecase.dart';
import 'package:card_game/modules/play/api/enums/game_action.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'host_event.dart';
part 'host_state.dart';

class HostBloc extends Bloc<HostEvent, HostState> {
  HostBloc() : super(const HostState()) {
    on<HostGameEvent>(_hostGame, transformer: sequential());

    on<HostFormPropertyChanged>(
        (event, emit) => emit(_formPropertyChanged(event)));
  }
  HostState _formPropertyChanged(HostFormPropertyChanged event) {
    switch (event.type) {
      case HostFormPropertyType.name:
        return state.copyWithPropertyType(
            validator: ValidationType.username,
            type: event.type,
            value: event.value,
            valueIsDirty: true,
            valueInvalidMessage: "Must be a valid name");
      case HostFormPropertyType.handSize:
        return state.copyWithPropertyType(
            validator: ValidationType.none,
            type: event.type,
            value: event.value,
            valueIsDirty: true,
            valueInvalidMessage: "Must be a valid hand size");
    }
  }

  Future<void> _hostGame(HostGameEvent event, Emitter<HostState> emit) async {
    emit(state.copyWith(inProgress: true, errorMessage: null));
    try {
      final result = await JoinOrHostGameUsecase().execute(
        action: GameAction.host,
        room: event.room,
        name: event.name,
        handSize: event.handSize,
      );
      if (result.isRight) {
        emit(HostSuccessState(
            currentPlayer: event.name,
            config: GameConfig(
                action: GameAction.host,
                name: event.name,
                room: event.room,
                handSize: int.tryParse(event.handSize) ?? 7)));
      } else {
        state.copyWith(
          errorMessage: result.left.errorMessage,
        );
      }
    } catch (e) {
      String errorMessage = ErrorMapper.getErrorMessage(e.toString());
      state.copyWith(errorMessage: errorMessage, inProgress: false);
    }
  }
}
