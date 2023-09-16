import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/ui/bloc/search/advanced_search_result_page_cubit.dart';
import 'package:playground/ui/cards_page.dart';

part 'advanced_search_result_page_data.dart';

class AdvancedSearchResultPage extends StatelessWidget {
  AdvancedSearchResultPage({Key? key, SearchRequest? searchRequest})
      : searchRequest = searchRequest ??
            SearchRequest(
                query: FullTextSearchQuery(),
                matchAll: <String, dynamic>{
                  'types': false,
                  'colors': false,
                  'rarities': false,
                  'blocks': false,
                  'sets': false,
                  'formats': false,
                  'power': '=',
                  'toughness': '=',
                  'loyalty': '=',
                  'year': '=',
                }),
        super(key: key);

  final SearchRequest searchRequest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AdvancedSearchResultPageCubit()..initCards(searchRequest),
        child: const AdvancedSearchResultView());
  }
}

class AdvancedSearchResultView extends StatelessWidget {
  const AdvancedSearchResultView({Key? key}) : super(key: key);

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
              'Search results',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AdvancedSearchResultPageCubit,
                AdvancedSearchResultPageState>(
              builder: (context, state) {
                switch (state.status) {
                  case AdvancedSearchResultPageStatus.initial:
                    return AdvancedSearchResultPageData();
                  case AdvancedSearchResultPageStatus.success:
                    return AdvancedSearchResultPageData(cards: state.cardList);
                  case AdvancedSearchResultPageStatus.loading:
                    return const Expanded(child: PageLoading());
                  case AdvancedSearchResultPageStatus.loadingPagination:
                    return AdvancedSearchResultPageData(
                      cards: state.cardList,
                      loadingPagination: state.loadingPagination,
                    );
                  case AdvancedSearchResultPageStatus.failure:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(),
                        Container(
                          margin: const EdgeInsets.all(12),
                          child: Text(
                            (state.exception as ScryfallError)
                                .getErrorMessage(),
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Return to advanced search'),
                        )
                      ],
                    );
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
