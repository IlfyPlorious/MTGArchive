import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';

class OptionsBar extends StatelessWidget {
  const OptionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            context.read<LifeTrackCubit>().resetLifeTotals();
          },
          iconSize: 20,
          padding: const EdgeInsets.all(0),
          icon: Image.asset('assets/images/hammer.png'),
        ),
        IconButton(
          onPressed: () {
            context.read<LifeTrackCubit>().switchToOptionsPage();
          },
          iconSize: 20,
          padding: const EdgeInsets.all(0),
          icon: Image.asset('assets/images/settings.png'),
        ),
        IconButton(
          onPressed: () async {
            await context.read<LifeTrackCubit>().throwDice();
          },
          iconSize: 20,
          padding: const EdgeInsets.all(0),
          icon: Image.asset('assets/images/dice.png'),
        )
      ],
    );
  }
}
