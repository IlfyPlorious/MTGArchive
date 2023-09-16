import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';
import 'package:playground/ui/life_track/partitions/two_layout.dart';

class LifeTrackMainPage extends StatelessWidget {
  const LifeTrackMainPage({Key? key, required this.state}) : super(key: key);

  final LifeTrackState state;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      body: Container(
        color: CustomColors.eggshell,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TwoLayoutWidget(
                diceState: state.diceState,
                player1: state.playersData[0],
                player2: state.playersData[1],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
