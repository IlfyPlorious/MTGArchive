part of 'deck_details_page.dart';

class DeckDetailsPageData extends StatefulWidget {
  DeckDetailsPageData(
      {Key? key,
      this.onFocus = false,
      this.searchQuery = emptyString,
      this.loadingAutocomplete = false,
      Map<String, List<DeckCard>>? cards,
      DeckConstraints? constraints,
      List<String?>? autocompleteSuggestions})
      : autocompleteSuggestions = autocompleteSuggestions ?? <String>[],
        constraints = constraints ?? StandardConstraints(),
        cards = cards ?? {},
        super(key: key);

  final bool onFocus;
  final String searchQuery;
  final bool loadingAutocomplete;
  final List<String?> autocompleteSuggestions;
  final Map<String, List<DeckCard>> cards;
  final DeckConstraints? constraints;

  @override
  State<DeckDetailsPageData> createState() => _DeckDetailsPageDataState();
}

class _DeckDetailsPageDataState extends State<DeckDetailsPageData> {
  final searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFieldController.addListener(() {
      context.read<DeckDetailsCubit>().changeFocus(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: SearchField(
              showIcon: false,
              hint: 'Search to add ( min. 3 chr )',
              onFocus: widget.onFocus,
              controller: searchFieldController,
              onQuerySubmittedCallback: (value) {
                context.read<DeckDetailsCubit>().changeFocus(false);
              },
              onTextChangedCallback: (value) {
                context.read<DeckDetailsCubit>().updateSearchQuery(value);
              },
              onActionButtonCallback: () {
                context.read<DeckDetailsCubit>().changeFocus(false);
              },
            ),
          ),
          if (widget.onFocus && widget.searchQuery.length > 2)
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: const BoxDecoration(
                color: CustomColors.darkGray,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: widget.loadingAutocomplete
                  ? const PageLoading()
                  : ListView.separated(
                      itemCount: widget.autocompleteSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion =
                            widget.autocompleteSuggestions[index];
                        return ListTile(
                          onTap: () async {
                            await showDialog<int>(
                                context: context,
                                builder: (BuildContext context) {
                                  int count = 1;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        backgroundColor: CustomColors.eggshell,
                                        title: const Text(
                                          'How many to add?',
                                          style: TextStyle(
                                              color: CustomColors.blackOlive),
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (count - 1 > 0) {
                                                    count -= 1;
                                                  }
                                                });
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Text(
                                              count.toString(),
                                              style: const TextStyle(
                                                  color:
                                                      CustomColors.blackOlive),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  count += 1;
                                                });
                                              },
                                              icon: const Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, count),
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: CustomColors.orange),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, null),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: CustomColors.orange),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }).then((addCount) {
                              if ((addCount ?? -1) > 0) {
                                context.read<DeckDetailsCubit>().addCardToDeck(
                                    widget.autocompleteSuggestions[index] ??
                                        emptyString,
                                    addCount!);
                              }
                            });
                          },
                          title: Text(
                            suggestion ?? emptyString,
                            style: const TextStyle(color: CustomColors.orange),
                          ),
                          trailing: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 30, maxWidth: 30),
                              child: Image.asset('assets/images/add.png')),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
            ),
          Expanded(
            child: ListView(
              children: BaseCardTypes.values
                  .where((type) => widget.cards[type.name]?.isNotEmpty == true)
                  .map((type) {
                return ListTile(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(8),
                              child: Text(
                                type.name,
                                style: const TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 12,
                        endIndent: 60,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final cardList = widget.cards[type.name];
                          return CardTile(
                            name: cardList?[index].name ?? emptyString,
                            count: cardList?[index].count,
                            colors: cardList?[index].colorIdentity?.join(''),
                            maxCardCount:
                                widget.constraints?.maxNumberOfCopies ?? 4,
                            onTapCallback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CardDetailsPage(
                                            cardId: cardList?[index].id,
                                            name: cardList?[index].name,
                                          )));
                            },
                            onRemoveCardCallback: () async {
                              await showDialog<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int count = 1;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          backgroundColor:
                                              CustomColors.eggshell,
                                          title: const Text(
                                            'How many to remove?',
                                            style: TextStyle(
                                                color: CustomColors.blackOlive),
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (count > 0) {
                                                      count -= 1;
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove),
                                              ),
                                              Text(
                                                count.toString(),
                                                style: const TextStyle(
                                                    color: CustomColors
                                                        .blackOlive),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    count += 1;
                                                  });
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, count),
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: CustomColors.orange),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, null),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: CustomColors.orange),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }).then((removeCount) {
                                if ((removeCount ?? -1) > 0) {
                                  context
                                      .read<DeckDetailsCubit>()
                                      .removeCardsFromDeck(
                                          category: type,
                                          card: cardList![index],
                                          count: removeCount!);
                                }
                              });
                            },
                            backgroundUrl: cardList?[index].imageUris?.artCrop,
                          );
                        },
                        itemCount: widget.cards[type.name]?.length,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            color: CustomColors.blackOlive,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Main deck: ',
                    style: const TextStyle(
                        color: CustomColors.orange, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${_getCardsCount()} / ${widget.constraints?.minDeckSize ?? '60'}',
                        style: TextStyle(
                            color: _getCardsCount() >
                                    (widget.constraints?.minDeckSize ?? 60)
                                ? CustomColors.darkErrorRed
                                : CustomColors.orange),
                      )
                    ],
                  ),
                ),
                Text(
                  'Value: ${_getDeckValue().toStringAsFixed(2)} €',
                  style: const TextStyle(color: CustomColors.orange),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  int _getCardsCount() {
    int count = 0;

    for (var type in BaseCardTypes.values) {
      if (widget.cards[type.name]?.isNotEmpty == true) {
        for (var card in widget.cards[type.name]!) {
          count += card.count ?? 0;
        }
      }
    }

    return count;
  }

  double _getDeckValue() {
    double value = 0;

    for (var type in BaseCardTypes.values) {
      if (widget.cards[type.name]?.isNotEmpty == true) {
        for (var card in widget.cards[type.name]!) {
          value += double.parse(card.prices?.eur ?? '0.0') * (card.count ?? 0);
        }
      }
    }

    return value;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    searchFieldController.dispose();
    super.dispose();
  }
}
