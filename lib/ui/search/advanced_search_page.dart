import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/responsemodels/card.dart' as card_models;
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/ui/bloc/search/advanced_search_page_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/ui/search/advanced_search_result_page.dart';
import 'package:playground/ui/search/search_page.dart';
import 'package:playground/utils/constants.dart';

part 'advanced_search_page_data.dart';

class AdvancedSearchPage extends StatelessWidget {
  const AdvancedSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdvancedSearchPageCubit(),
        child: AdvancedSearchView());
  }
}

class AdvancedSearchView extends StatelessWidget {
  AdvancedSearchView({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Advanced search',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AdvancedSearchPageCubit, AdvancedSearchPageState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return AdvancedSearchPageData(
                  showStateCallback: () {
                    Logger().i(state.toString());
                  },
                  types: state.types,
                  rarities: state.rarities,
                  blocks: state.blocks,
                  sets: state.sets,
                  formats: state.formats,
                  colors: state.colors,
                  textEditingController: textEditingController,
                );
              case Status.success:
                return AdvancedSearchPageData(
                  showStateCallback: () {
                    Logger().i(state.toString());
                  },
                  types: state.types,
                  rarities: state.rarities,
                  blocks: state.blocks,
                  sets: state.sets,
                  formats: state.formats,
                  colors: state.colors,
                  textEditingController: textEditingController,
                );
              case Status.loading:
                return const Expanded(child: PageLoading());
              case Status.failure:
                return Text(
                    (state.exception as ScryfallError).getErrorMessage());
              default:
                return const Expanded(child: PageLoading());
            }
          },
        ),
      ),
    );
  }
}
