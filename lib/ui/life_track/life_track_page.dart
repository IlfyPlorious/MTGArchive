import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/ui/bloc/life_track/life_track_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/life_track/life_track_main_page.dart';
import 'package:playground/ui/life_track/life_track_general_options_page.dart';
import 'package:playground/utils/constants.dart';

class LifeTrackPage extends StatelessWidget {
  const LifeTrackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LifeTrackCubit(),
      child: const LifeTrackView(),
    );
  }
}

class LifeTrackView extends StatelessWidget {
  const LifeTrackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LifeTrackCubit, LifeTrackState>(
        builder: (context, state) {
      switch (state.pageState) {
        case PageState.main:
          return getMainPage(state, context);
        case PageState.generalOptions:
          return getOptionsPage(state, context);
        default:
          return getMainPage(state, context);
      }
    });
  }

  Widget getMainPage(LifeTrackState state, BuildContext context) {
    switch (state.status) {
      case Status.initial:
        return LifeTrackMainPage(state: state);
      case Status.success:
        return LifeTrackMainPage(state: state);
      case Status.loading:
        return const PageLoading();
      case Status.failure:
        return Text('Something went wrong: ${state.error.toString()}');
      default:
        return const Text('Something went wrong');
    }
  }

  Widget getOptionsPage(LifeTrackState state, BuildContext context) {
    switch (state.status) {
      case Status.initial:
        return LifeTrackGeneralOptionsPage(state: state);
      case Status.success:
        return LifeTrackGeneralOptionsPage(state: state);
      case Status.loading:
        return const PageLoading();
      case Status.failure:
        return Text('Something went wrong: ${state.error.toString()}');
      default:
        return const Text('Something went wrong');
    }
  }
}
