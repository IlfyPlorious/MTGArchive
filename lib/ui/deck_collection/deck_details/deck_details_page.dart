import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/models/deck_constraint.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/firebase/deck_card.dart';
import 'package:playground/ui/bloc/decks_collection/deck_details/deck_details_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/details_page.dart';
import 'package:playground/ui/partitions/fields/card_tile.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/utils/constants.dart';

part 'deck_details_page_data.dart';

class DeckDetailsPage extends StatelessWidget {
  const DeckDetailsPage(
      {Key? key, required this.deckId, required this.deckName})
      : super(key: key);

  final String deckId;
  final String deckName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeckDetailsCubit()..initData(deckId),
      child: DeckDetailsView(
        deckName: deckName,
      ),
    );
  }
}

class DeckDetailsView extends StatelessWidget {
  const DeckDetailsView({
    Key? key,
    this.deckName = emptyString,
  }) : super(key: key);

  final String deckName;

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
          children: [
            Text(
              deckName,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Container(
            height: 20,
            width: 20,
            margin: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Careful there!'),
                    content: const Text(
                        'Are you sure you want to delete this deck? It will be lost forever'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          'Purge it!',
                          style: TextStyle(color: CustomColors.orange),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          'Noo, my precious...',
                          style: TextStyle(color: CustomColors.orange),
                        ),
                      ),
                    ],
                  ),
                ).then((dialogResult) {
                  if (dialogResult == true) {
                    context
                        .read<DeckDetailsCubit>()
                        .deleteDeck()
                        .then((completed) {
                      if (completed) {
                        Navigator.pop(context);
                      }
                    });
                  }
                });
              },
              iconSize: 20,
              padding: const EdgeInsets.all(0),
              icon: Image.asset('assets/images/bin.png'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  BlocBuilder<DeckDetailsCubit, DeckDetailsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case DeckDetailsStatus.initial:
                          return DeckDetailsPageData(
                            onFocus: state.searchHasFocus,
                            searchQuery: state.searchQuery,
                            autocompleteSuggestions:
                                state.autocompleteSuggestions,
                            cards: state.cards,
                            constraints: state.deck.getDeckConstraints(),
                          );
                        case DeckDetailsStatus.success:
                          return DeckDetailsPageData(
                            onFocus: state.searchHasFocus,
                            searchQuery: state.searchQuery,
                            autocompleteSuggestions:
                                state.autocompleteSuggestions,
                            cards: state.cards,
                            constraints: state.deck.getDeckConstraints(),
                          );
                        case DeckDetailsStatus.loadingAutocomplete:
                          return DeckDetailsPageData(
                            onFocus: state.searchHasFocus,
                            searchQuery: state.searchQuery,
                            autocompleteSuggestions:
                                state.autocompleteSuggestions,
                            loadingAutocomplete: true,
                            cards: state.cards,
                            constraints: state.deck.getDeckConstraints(),
                          );
                        case DeckDetailsStatus.loading:
                          return const Expanded(child: PageLoading());
                        case DeckDetailsStatus.failure:
                          if (state.exception is ScryfallError) {
                            return Center(
                              child: Text((state.exception as ScryfallError)
                                  .getErrorMessage()),
                            );
                          } else {
                            return Center(
                              child: Text(state.exception.toString()),
                            );
                          }
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
