part of 'life_track_cubit.dart';

enum PageState { main, generalOptions, playerOptions }

enum DiceThrowState { rolling, completed, waitForRoll }

class LifeTrackState extends Equatable {
  LifeTrackState({
    this.status = Status.initial,
    this.pageState = PageState.main,
    this.numberOfPlayers = 2,
    this.focusedPlayer = 0,
    this.maxHealth = 20,
    this.diceState = DiceThrowState.waitForRoll,
    List<PlayerData>? playersData,
    this.error,
  }) : playersData = playersData ?? [PlayerData(), PlayerData()];

  final Status status;
  final PageState pageState;

  final int numberOfPlayers;
  final int maxHealth;

  final List<PlayerData> playersData;
  final int focusedPlayer;
  final DiceThrowState diceState;

  final Exception? error;

  LifeTrackState copyWith(
      {Status? status,
      PageState? pageState,
      int? numberOfPlayers,
      int? maxHealth,
      int? focusedPlayer,
      DiceThrowState? diceState,
      List<PlayerData>? playersData,
      Exception? error}) {
    return LifeTrackState(
      status: status ?? this.status,
      pageState: pageState ?? this.pageState,
      numberOfPlayers: numberOfPlayers ?? this.numberOfPlayers,
      maxHealth: maxHealth ?? this.maxHealth,
      playersData: playersData ?? this.playersData,
      focusedPlayer: focusedPlayer ?? this.focusedPlayer,
      error: error ?? this.error,
      diceState: diceState ?? this.diceState,
    );
  }

  @override
  List<Object> get props => [
        status,
        pageState,
        numberOfPlayers,
        maxHealth,
        playersData,
        focusedPlayer,
        diceState
      ];
}
