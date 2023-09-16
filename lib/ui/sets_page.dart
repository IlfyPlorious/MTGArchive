import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/network/requestmodels/setsrequest.dart';
import 'package:playground/network/responsemodels/sets.dart' as sets_models;
import 'package:playground/ui/bloc/sets/sets_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/bottomsheets/sets_bottomsheets.dart';

part 'partitions/lists/sets_list_populated.dart';

class SetsPage extends StatelessWidget {
  const SetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SetsPageCubit()..fetchSets(SetsRequest()),
        child: SetsView());
  }
}

class SetsView extends StatelessWidget {
  SetsView({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                showModalBottomSheet<SetsFilters>(
                    context: context,
                    builder: (ctx) {
                      SetsFilters filters =
                          context.read<SetsPageCubit>().getFilters();
                      return SetsFiltersBottomSheet(
                        setsFilters: filters,
                      );
                    }).then((setsFilters) {
                  context.read<SetsPageCubit>().applyFilters(setsFilters);
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
          children: const [
            Text(
              'All MTG sets',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<SetsPageCubit, SetsPageState>(
              builder: (context, state) {
                switch (state.status) {
                  case SetsListStatus.initial:
                    return const Expanded(child: PageLoading());
                  case SetsListStatus.success:
                    return SetsList(
                      sets: state.setsList.where((element) {
                        bool? dateCheck = state.setsFilters.afterFilterDate
                            ? (element.releaseDateAsDateTime?.compareTo(
                                        state.setsFilters.releaseDate) ??
                                    0) >
                                0
                            : (element.releaseDateAsDateTime?.compareTo(
                                        state.setsFilters.releaseDate) ??
                                    0) <=
                                0;

                        return element.type ==
                                (state.setsFilters.expansions.getApiKey() ??
                                    element.type) &&
                            state.setsFilters.onlineOnly ==
                                element.onlineOnly &&
                            dateCheck;
                      }).toList(),
                      request: SetsRequest(),
                    );
                  case SetsListStatus.loading:
                    return const Expanded(child: PageLoading());
                  case SetsListStatus.failure:
                    return SetsPageError(
                        state.exception ?? Exception('Error loading data'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
