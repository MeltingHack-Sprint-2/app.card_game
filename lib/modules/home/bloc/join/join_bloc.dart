import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:card_game/core/errors/error_mapper.dart';
import 'package:card_game/core/form/form_property/form_property.dart';
import 'package:card_game/core/form/form_property/form_property_type.dart';
import 'package:card_game/core/form/string_extension/string_validator.dart';
import 'package:card_game/modules/home/api/usecase/host_game_usecase.dart';
import 'package:card_game/modules/play/api/enums/game_action.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/api/models/player_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'join_event.dart';
part 'join_state.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  JoinBloc() : super(const JoinState()) {
    on<JoinGameEvent>(_joinGame, transformer: sequential());
    on<JoinFormPropertyChanged>(
        (event, emit) => emit(_formPropertyChanged(event)));
  }

  JoinState _formPropertyChanged(JoinFormPropertyChanged event) {
    switch (event.type) {
      case JoinFormPropertyType.name:
        return state.copyWithPropertyType(
            validator: ValidationType.username,
            type: event.type,
            value: event.value,
            valueIsDirty: true,
            valueInvalidMessage: "Must be a valid name");
      case JoinFormPropertyType.room:
        return state.copyWithPropertyType(
            validator: ValidationType.none,
            type: event.type,
            value: event.value,
            valueIsDirty: true,
            valueInvalidMessage: "Must be a valid room");
    }
  }

  Future<void> _joinGame(JoinGameEvent event, Emitter<JoinState> emit) async {
    emit(state.copyWith(inProgress: true, errorMessage: null));
    try {
      final result = await JoinOrHostGameUsecase().execute(
        action: GameAction.join,
        room: event.room,
        name: event.name,
      );
      if (result.isRight) {
        emit(JoinSuccessState(
            currentPlayer: Player(id: event.name, name: event.name),
            config: GameConfig(
                action: GameAction.host,
                name: event.name,
                room: event.room,
                handSize: 7)));
      } else {
        state.copyWith(
          errorMessage: result.left.errorMessage,
        );
      }
    } catch (e) {
      String errorMessage = ErrorMapper.getErrorMessage(e.toString());
      state.copyWith(errorMessage: errorMessage);
    }
  }
}
