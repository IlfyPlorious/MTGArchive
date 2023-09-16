import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/models/player_data.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';
import 'package:playground/ui/life_track/partitions/player.dart';

import 'options_bar.dart';

class TwoLayoutWidget extends StatelessWidget {
  const TwoLayoutWidget({
    Key? key,
    required this.player1,
    required this.player2,
    required this.diceState,
  }) : super(key: key);

  final PlayerData player1;
  final PlayerData player2;
  final DiceThrowState diceState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RotatedBox(
            quarterTurns: 2,
            child: PlayerLayout(
              playerData: player2,
              diceState: diceState,
              increaseHealthCallback: () {
                context.read<LifeTrackCubit>().incrementPlayerHealth(player: 2);
              },
              decreaseHealthCallback: () {
                context.read<LifeTrackCubit>().decrementPlayerHealth(player: 2);
              },
              navigateToPlayerOptionsCallback: () {
                context
                    .read<LifeTrackCubit>()
                    .switchToPlayerOptionsPage(player: 2);
              },
            ),
          ),
        ),
        const SizedBox(height: 50, child: OptionsBar()),
        Expanded(
          child: PlayerLayout(
            playerData: player1,
            diceState: diceState,
            increaseHealthCallback: () {
              context.read<LifeTrackCubit>().incrementPlayerHealth(player: 1);
            },
            decreaseHealthCallback: () {
              context.read<LifeTrackCubit>().decrementPlayerHealth(player: 1);
            },
            navigateToPlayerOptionsCallback: () {
              context
                  .read<LifeTrackCubit>()
                  .switchToPlayerOptionsPage(player: 1);
            },
          ),
        ),
      ],
    );
  }
}
