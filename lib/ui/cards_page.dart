import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/requestmodels/cardsrequest.dart';
import 'package:playground/network/requestmodels/setsrequest.dart';
import 'package:playground/network/responsemodels/basecard.dart';
import 'package:playground/network/responsemodels/card.dart' as card_models;
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/network/responsemodels/sets.dart' as sets_models;
import 'package:playground/ui/bloc/cards/cards_cubit.dart';
import 'package:playground/ui/bloc/sets/sets_cubit.dart';
import 'package:playground/ui/details_page.dart';
import 'package:playground/ui/partitions/bottomsheets/cards_bottomsheets.dart';
import 'package:playground/utils/constants.dart';
import 'package:playground/utils/utils.dart';

import '../colors.dart';

part './partitions/back_header.dart';
part './partitions/page_loading.dart';
part 'partitions/error/cards_page_error.dart';
part 'partitions/error/sets_page_error.dart';
part 'partitions/lists/cards_list_populated.dart';

class CardsPage extends StatelessWidget {
  CardsPage({Key? key, set})
      : set = set ?? sets_models.Set(),
        super(key: key);

  final sets_models.Set set;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: GetIt.instance<CardsListCubit>(instanceName: 'CardsListCubit')
          ..initData(CardsRequest(setCode: set.code)),
        child: CardsView(set));
  }
}

class CardsView extends StatelessWidget {
  const CardsView(this.set, {Key? key}) : super(key: key);

  final sets_models.Set set;

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
        actions: [
          Container(
            height: 20,
            width: 20,
            margin: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet<CardsFilters>(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) {
                      CardsFilters filters =
                          context.read<CardsListCubit>().getFilters();

                      return BlocProvider<CardsListCubit>.value(
                        value: GetIt.instance<CardsListCubit>(
                            instanceName: 'CardsListCubit'),
                        child: CardsFiltersBottomSheet(
                          cardsFilters: filters,
                        ),
                      );
                    });
              },
              iconSize: 20,
              padding: const EdgeInsets.all(0),
              icon: Image.asset('assets/images/filters_light.png'),
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              set.name ?? 'Some Magic Cards',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<CardsListCubit, CardsListState>(
              builder: (context, state) {
                switch (state.status) {
                  case CardsListStatus.initial:
                    return const Expanded(child: PageLoading());
                  case CardsListStatus.success:
                    return CardsList<card_models.Card>(
                      loadingPagination: false,
                      cards:
                          context.read<CardsListCubit>().getFilteredCardsList(),
                      onRefreshCallback: () async {
                        CardsRequest(setCode: set.code);
                      },
                      onBottomReachedCallback: () {
                        context
                            .read<CardsListCubit>()
                            .appendCards(CardsRequest(setCode: set.code));
                      },
                      request: CardsRequest(setCode: set.code),
                    );
                  case CardsListStatus.loadingPagination:
                    return CardsList<card_models.Card>(
                      loadingPagination: true,
                      cards:
                          context.read<CardsListCubit>().getFilteredCardsList(),
                      onRefreshCallback: () async {
                        context
                            .read<CardsListCubit>()
                            .fetchCards(CardsRequest(setCode: set.code));
                      },
                      onBottomReachedCallback: () {
                        context
                            .read<CardsListCubit>()
                            .appendCards(CardsRequest(setCode: set.code));
                      },
                      request: CardsRequest(setCode: set.code),
                    );
                  case CardsListStatus.loading:
                    return const Expanded(child: PageLoading());
                  case CardsListStatus.failure:
                    return CardsPageError(
                        state.exception ?? Exception('Error loading data'));
                  default:
                    return const Expanded(child: PageLoading());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
