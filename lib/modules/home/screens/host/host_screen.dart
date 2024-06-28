import 'dart:math';

import 'package:card_game/components/Textfields/primary.dart';
import 'package:card_game/components/alerts/snackbar.dart';
import 'package:card_game/components/appbar/app_bar.dart';
import 'package:card_game/components/buttons/primary.dart';
import 'package:card_game/core/form/form_property/form_property_type.dart';
import 'package:card_game/modules/home/bloc/host/host_bloc.dart';
import 'package:card_game/modules/play/screens/play_screen.dart';
import 'package:card_game/theme/app_colors.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String generateRandomString(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

class HostScreen extends StatelessWidget {
  static const routename = '/hostScreen';
  const HostScreen({super.key});
  static final room = generateRandomString(8);

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return BlocProvider(
      create: (context) => HostBloc(),
      child: BlocConsumer<HostBloc, HostState>(
        listener: (context, state) {
          if (state is HostSuccessState) {
            Navigator.pushNamed(context, PlayScreen.routename, arguments: {
              "config": state.config,
              "player": state.currentPlayer
            });
          } else if (state.errorMessage != null) {
            showSnackBar(context, theme,
                message: state.errorMessage!,
                backgroundColor: theme.colorScheme.error);
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: UnoAppBar.create(theme: theme, context: context),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text("Host", style: theme.materialData.textTheme.displayLarge),
              const SizedBox(height: 16),
              Text("Enter Credentials to host game",
                  style: theme.materialData.textTheme.bodyMedium),
              const SizedBox(height: 24),
              PrimaryTextField(
                errorText: state.name.valueInvalidMessage,
                onChanged: (value) {
                  context.read<HostBloc>().add(HostFormPropertyChanged(
                      type: HostFormPropertyType.name, value: value));
                },
                hintText: "John Doe",
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Room",
                style: theme.materialData.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              _codeDisplay(code: room, theme: theme),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Hand Size",
                style: theme.materialData.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryTextField(
                errorText: state.handSize.valueInvalidMessage,
                onChanged: (value) {
                  context.read<HostBloc>().add(HostFormPropertyChanged(
                      type: HostFormPropertyType.handSize, value: value));
                },
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                text: "Host",
                inProgress: state.inProgress,
                onPressed: state.isValid
                    ? () => context.read<HostBloc>().add(HostGameEvent(
                          name: state.name.value,
                          room: room,
                          handSize: state.handSize.value,
                        ))
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _codeDisplay({required String code, required EasyPockerTheme theme}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: AppColors.mediumGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12)),
    child: Text(
      code,
      style: theme.materialData.textTheme.bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
