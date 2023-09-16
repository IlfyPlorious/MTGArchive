import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playground/models/player_data.dart';
import 'package:playground/utils/constants.dart';

part 'life_track_state.dart';

class LifeTrackCubit extends Cubit<LifeTrackState> {
  LifeTrackCubit() : super(LifeTrackState());

  void switchToOptionsPage() {
    emit(state.copyWith(pageState: PageState.generalOptions));
  }

  void switchToPlayerOptionsPage({required int player}) {
    emit(state.copyWith(
        pageState: PageState.playerOptions, focusedPlayer: player - 1));
  }

  void switchToMainPage() {
    emit(state.copyWith(pageState: PageState.main));
  }

  void setNumberOfPlayers(int numberOfPlayers) {
    final playersData = <PlayerData>[];
    for (int i = 0; i < numberOfPlayers; i = i + 1) {
      playersData.add(PlayerData());
    }
    emit(state.copyWith(
        numberOfPlayers: numberOfPlayers, playersData: playersData));
  }

  void setMaxHealth(int maxHealth) {
    emit(state.copyWith(maxHealth: maxHealth));
  }

  void incrementPlayerHealth({required int player}) {
    final playersData = List<PlayerData>.from(state.playersData);
    playersData[player - 1] = playersData[player - 1]
        .copyWith(health: playersData[player - 1].health + 1);
    emit(state.copyWith(playersData: playersData));
  }

  void decrementPlayerHealth({required int player}) {
    final playersData = List<PlayerData>.from(state.playersData);
    playersData[player - 1] = playersData[player - 1]
        .copyWith(health: playersData[player - 1].health - 1);
    emit(state.copyWith(playersData: playersData));
  }

  void resetLifeTotals() {
    final playersData = List<PlayerData>.from(state.playersData);
    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(health: state.maxHealth);
    }
    emit(state.copyWith(playersData: playersData));
  }

  Future<void> throwDice() async {
    final dices = ['one', 'two', 'three', 'four', 'five', 'six'];
    var playersData = List<PlayerData>.from(state.playersData);

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: dices[Random().nextInt(6)]);
    }
    emit(state.copyWith(
        playersData: playersData, diceState: DiceThrowState.rolling));

    playersData = List<PlayerData>.from(state.playersData);

    await Future.delayed(
      const Duration(milliseconds: 400),
      () => null,
    );

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: dices[Random().nextInt(6)]);
    }
    emit(state.copyWith(playersData: playersData));

    playersData = List<PlayerData>.from(state.playersData);

    await Future.delayed(
      const Duration(milliseconds: 600),
      () => null,
    );

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: dices[Random().nextInt(6)]);
    }
    emit(state.copyWith(playersData: playersData));

    playersData = List<PlayerData>.from(state.playersData);

    await Future.delayed(
      const Duration(milliseconds: 800),
      () => null,
    );

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: dices[Random().nextInt(6)]);
    }
    emit(state.copyWith(playersData: playersData));

    playersData = List<PlayerData>.from(state.playersData);

    await Future.delayed(
      const Duration(milliseconds: 1000),
      () => null,
    );

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: dices[Random().nextInt(6)]);
    }
    emit(state.copyWith(
        playersData: playersData, diceState: DiceThrowState.completed));

    playersData = List<PlayerData>.from(state.playersData);

    await Future.delayed(
      const Duration(milliseconds: 2500),
      () => null,
    );

    for (var i = 0; i < playersData.length; i++) {
      playersData[i] = playersData[i].copyWith(die: 'null');
    }
    emit(state.copyWith(
        playersData: playersData, diceState: DiceThrowState.waitForRoll));
  }
}
