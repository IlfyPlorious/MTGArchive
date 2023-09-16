import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/ui/bloc/decks_collection/add_deck/add_deck_cubit.dart';
import 'package:playground/ui/bloc/decks_collection/decks_collection_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/deck_collection/deck_details/deck_details_page.dart';
import 'package:playground/ui/partitions/fields/deck_list_tile.dart';
import 'package:playground/ui/partitions/fields/dropdown_field.dart';
import 'package:playground/ui/partitions/fields/label_field.dart';
import 'package:playground/utils/constants.dart';

class AddDeckPage extends StatelessWidget {
  const AddDeckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDeckCubit()..initData(),
      child: const AddDeckView(),
    );
  }
}

class AddDeckView extends StatelessWidget {
  const AddDeckView({Key? key}) : super(key: key);

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
              'Add new deck',
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
                  BlocBuilder<AddDeckCubit, AddDeckState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case Status.initial:
                          return AddDeckPageData(
                            formatsList: state.formatsList,
                          );
                        case Status.success:
                          return AddDeckPageData(
                            formatsList: state.formatsList,
                            deckId: state.deckId,
                            deckName: state.name,
                          );
                        case Status.loading:
                          return const Expanded(child: PageLoading());
                        case Status.failure:
                          if (state.exception is ScryfallError) {
                            return Center(
                              child: Text((state.exception as ScryfallError)
                                  .getErrorMessage()),
                            );
                          } else {
                            return AddDeckPageData(
                              formatsList: state.formatsList,
                              deckId: state.deckId,
                              deckName: state.name,
                              invalidInputs: true,
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

class AddDeckPageData extends StatelessWidget {
  const AddDeckPageData(
      {Key? key,
      required this.formatsList,
      this.deckId,
      this.deckName,
      this.invalidInputs = false})
      : super(key: key);

  final List<String> formatsList;
  final String? deckId;
  final String? deckName;
  final bool invalidInputs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (deckId?.isNotEmpty == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DeckDetailsPage(
                      deckId: deckId ?? emptyString,
                      deckName: deckName ?? emptyString,
                    )));
      }
    });
    return Column(
      children: [
        TopLabelField(
          label: 'Deck name',
          onTextChangedCallback: (value) {
            context.read<AddDeckCubit>().updateName(value);
          },
          hint: 'Your new deck name (ex. Infect deck)',
        ),
        DropdownField<String>(
          label: 'Format',
          hint: 'Pick the format',
          dropdownList: formatsList,
          onDropdownChangedCallback: (value) {
            context.read<AddDeckCubit>().updateFormat(value);
          },
        ),
        const SizedBox(
          height: 30,
        ),
        if (invalidInputs)
          const Text('You have to give your deck a name and pick a format!',
              style: TextStyle(color: CustomColors.errorRed)),
        ElevatedButton(
          onPressed: () async {
            context.read<AddDeckCubit>().createDeck();
          },
          child: const Text(
            'Create deck',
          ),
        )
      ],
    );
  }
}
