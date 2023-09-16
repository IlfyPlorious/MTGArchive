import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/ui/bloc/decks_collection/decks_collection_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/deck_collection/add_deck/add_deck_page.dart';
import 'package:playground/ui/deck_collection/deck_details/deck_details_page.dart';
import 'package:playground/ui/partitions/fields/deck_list_tile.dart';
import 'package:playground/utils/constants.dart';

class DecksCollectionPage extends StatelessWidget {
  const DecksCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DecksCollectionCubit()..getDecksData(),
      child: const DecksCollectionView(),
    );
  }
}

class DecksCollectionView extends StatelessWidget {
  const DecksCollectionView({Key? key}) : super(key: key);

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
              'Decks collection',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDeckPage()));
        },
        label: const Text('New deck'),
        icon: const Icon(Icons.library_add),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<DecksCollectionCubit>().getDecksData();
                },
                child: Column(
                  children: [
                    BlocBuilder<DecksCollectionCubit, DecksCollectionState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case Status.initial:
                            return const Expanded(child: PageLoading());
                          case Status.success:
                            return DecksCollectionData(
                              decks: state.decks,
                            );
                          case Status.loading:
                            return const Expanded(child: PageLoading());
                          case Status.failure:
                            return Center(
                              child: Text(state.exception.toString()),
                            );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DecksCollectionData extends StatelessWidget {
  const DecksCollectionData({Key? key, required this.decks}) : super(key: key);

  final List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: decks.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return DeckListTile(
              tapCallback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeckDetailsPage(
                            deckId: decks[index].id ?? emptyString,
                            deckName: decks[index].name ?? emptyString))).then(
                    (value) =>
                        context.read<DecksCollectionCubit>().getDecksData());
              },
              deckName: decks[index].name ?? emptyString,
              format: decks[index].format ?? emptyString,
              backgroundUrl: decks[index].backgroundUrl,
              colors: decks[index].colors,
            );
          }),
    );
  }
}
