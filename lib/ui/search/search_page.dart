import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/ui/bloc/search/search_page_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/details_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/ui/search/advanced_search_page.dart';
import 'package:playground/utils/constants.dart';

part 'search_page_data.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchPageCubit(), child: const SearchView());
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

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
              'Search for cards',
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
              child: Column(
                children: [
                  BlocBuilder<SearchPageCubit, SearchPageState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case SearchPageStatus.initial:
                          return SearchPageData(
                            autocompleteSuggestions:
                                state.autocompleteSuggestions,
                            searchOnFocus: state.searchOnFocus,
                            autocompleteQuery: state.autocompleteQuery,
                          );
                        case SearchPageStatus.success:
                          return SearchPageData(
                              autocompleteSuggestions:
                                  state.autocompleteSuggestions,
                              showSearchResults: state.showSearchResults,
                              searchResultCards: state.searchResultCards,
                              autocompleteQuery: state.autocompleteQuery,
                              searchOnFocus: state.searchOnFocus);
                        case SearchPageStatus.loadingPagination:
                          return SearchPageData(
                              autocompleteSuggestions:
                                  state.autocompleteSuggestions,
                              loadingPagination: state.loadingPagination,
                              showSearchResults: state.showSearchResults,
                              searchResultCards: state.searchResultCards,
                              autocompleteQuery: state.autocompleteQuery,
                              searchOnFocus: state.searchOnFocus);
                        case SearchPageStatus.loading:
                          return const Expanded(child: PageLoading());
                        case SearchPageStatus.loadingAutocomplete:
                          return SearchPageData(
                            autocompleteSuggestions:
                                state.autocompleteSuggestions,
                            searchOnFocus: state.searchOnFocus,
                            autocompleteQuery: state.autocompleteQuery,
                            autocompleteLoading: true,
                          );
                        case SearchPageStatus.failure:
                          return Text((state.exception as ServerErrorException)
                              .getServerError());
                        default:
                          return const Expanded(child: PageLoading());
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
