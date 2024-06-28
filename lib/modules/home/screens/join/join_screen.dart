import 'package:card_game/components/Textfields/primary.dart';
import 'package:card_game/components/alerts/snackbar.dart';
import 'package:card_game/components/appbar/app_bar.dart';
import 'package:card_game/components/buttons/primary.dart';
import 'package:card_game/core/form/form_property/form_property_type.dart';
import 'package:card_game/modules/home/bloc/join/join_bloc.dart';
import 'package:card_game/modules/play/screens/play_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinScreen extends StatelessWidget {
  static const routename = '/joinScreen';
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return BlocProvider(
      create: (context) => JoinBloc(),
      child: BlocConsumer<JoinBloc, JoinState>(
        listener: (context, state){
          if (state is JoinSuccessState) {
            Navigator.pushNamed(context, PlayScreen.routename,
                arguments: {
                  "config": state.config,
                  "player": state.currentPlayer
                });
          }else if (state.errorMessage != null) {
            showSnackBar(context, theme,
                message: state.errorMessage!,
                backgroundColor: theme.colorScheme.error);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: UnoAppBar.create(theme: theme, context: context),
          body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text("Join", style: theme.materialData.textTheme.displayLarge),
                const SizedBox(
                  height: 16,
                ),
                Text("Enter Credentials to join game",
                    style: theme.materialData.textTheme.bodyMedium),
                const SizedBox(height: 24),
                Text("Enter a name", style: theme.materialData.textTheme.bodyMedium),
                const SizedBox(height: 16),
                PrimaryTextField(
                  onChanged: (value) {
                    context.read<JoinBloc>().add(JoinFormPropertyChanged(
                        type: JoinFormPropertyType.name, value: value));
                  },
                  hintText: "John Doe",
                  errorText: state.name.valueInvalidMessage,
                ),
                const SizedBox(height: 16),
                Text("Room", style: theme.materialData.textTheme.bodyMedium),
                const SizedBox(height: 16),
                PrimaryTextField(
                  onChanged: (value) {
                    context.read<JoinBloc>().add(JoinFormPropertyChanged(
                        type: JoinFormPropertyType.room, value: value));
                  },
                  errorText: state.room.valueInvalidMessage,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                    inProgress: state.inProgress,
                    text: "Join",
                    onPressed: state.isValid
                        ? () {
                      context.read<JoinBloc>().add(JoinGameEvent(
                          name: state.name.value, room: state.room.value));
                    }
                        : null),
              ],
            ),
          ),
        ),
    );
  }
}
