import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/models/player_data.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';

class PlayerLayout extends StatelessWidget {
  const PlayerLayout({
    Key? key,
    required this.playerData,
    required this.diceState,
    required this.increaseHealthCallback,
    required this.decreaseHealthCallback,
    required this.navigateToPlayerOptionsCallback,
  }) : super(key: key);

  final PlayerData playerData;
  final DiceThrowState diceState;

  final Function() increaseHealthCallback;
  final Function() decreaseHealthCallback;
  final Function() navigateToPlayerOptionsCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.blackOlive,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      margin: const EdgeInsets.all(0),
      child: ClipPath(
        clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: _parseBackgroundUrl()['color'],
              image: _parseBackgroundUrl()['url'] != null
                  ? DecorationImage(
                      image: NetworkImage(_parseBackgroundUrl()['url']),
                      fit: BoxFit.cover)
                  : null),
          child: Column(
            children: [
              SizedBox(
                height: 64,
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.purple
                      ],
                      stops: [
                        0.0,
                        0.3,
                        0.7,
                        1.0
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playerData.playerStats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.orangeAccent,
                        child: Text(playerData.playerStats[index].toString()),
                      );
                    },
                  ),
                ),
              ),
              diceState != DiceThrowState.waitForRoll
                  ? Expanded(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              playerData.getDiePath,
                              height: 154,
                            ),
                            if (diceState == DiceThrowState.completed)
                              const Text(
                                'Results!',
                                style: TextStyle(fontSize: 35),
                              ),
                          ],
                        ),
                      ],
                    ))
                  : Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: decreaseHealthCallback,
                                    icon: const Image(
                                      image:
                                          AssetImage('assets/images/minus.png'),
                                      height: 48,
                                      width: 48,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                playerData.health.toString(),
                                style: TextStyle(
                                  color: playerData.health <= 0
                                      ? CustomColors.darkErrorRed
                                      : CustomColors.blackOlive,
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: increaseHealthCallback,
                                    icon: const Image(
                                      image:
                                          AssetImage('assets/images/plus.png'),
                                      height: 48,
                                      width: 48,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: navigateToPlayerOptionsCallback,
                      iconSize: 20,
                      padding: const EdgeInsets.all(0),
                      icon: Image.asset(
                        'assets/images/settings.png',
                        height: 24,
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                    child: Text(
                      playerData.name,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _parseBackgroundUrl() {
    Map<String, dynamic> result = <String, dynamic>{};

    switch (playerData.backgroundUrl) {
      case 'orange':
        result['color'] = CustomColors.orange;
        result['url'] = null;
        break;
      case 'white':
        result['color'] = CustomColors.eggshell;
        result['url'] = null;
        break;
      default:
        result['color'] = Colors.white;
        result['url'] = playerData.backgroundUrl;
    }

    return result;
  }
// TODO IMPLEMENT A METHOD TO PARSE
// COLOR FROM BACKGROUNDURL
// OTHERWISE DISPLAY URL
}
