import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';
import 'package:playground/ui/life_track/partitions/selector.dart';
import 'package:provider/provider.dart';

class LifeTrackGeneralOptionsPage extends StatelessWidget {
  const LifeTrackGeneralOptionsPage({Key? key, required this.state}) : super(key: key);

  final LifeTrackState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: const EdgeInsets.all(0),
            icon: Image.asset('assets/images/back_arrow_light.png'),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Options',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectorWithIcons<int>(
                      title: "Board\nlayout",
                      onChoiceClicked: (value) {
                        context
                            .read<LifeTrackCubit>()
                            .setNumberOfPlayers(value);
                      },
                      iconPaths: const [
                        "assets/images/two_layout.png",
                        "assets/images/three_layout.png",
                        "assets/images/four_layout.png"
                      ],
                      options: const [2, 3, 4],
                      selected: state.numberOfPlayers,
                    ),
                    SelectorWithIcons<int>(
                      title: "Max\nHealth",
                      onChoiceClicked: (value) {
                        context
                            .read<LifeTrackCubit>()
                            .setMaxHealth(value);
                      },
                      options: const [20, 30, 40],
                      selected: state.maxHealth,
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<LifeTrackCubit>().switchToMainPage();
                          },
                          child: const Text('To board')),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
