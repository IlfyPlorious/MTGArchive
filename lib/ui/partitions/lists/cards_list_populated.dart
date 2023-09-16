part of 'package:playground/ui/cards_page.dart';

class CardsList<T> extends StatefulWidget {
  CardsList(
      {Key? key,
      List<T>? cards,
      CardsRequest? request,
      required this.onBottomReachedCallback,
      required this.onRefreshCallback,
      required this.loadingPagination})
      : cards = cards ?? <T>[],
        request = request ?? CardsRequest(),
        super(key: key);

  final List<T> cards;
  final CardsRequest request;
  final bool loadingPagination;
  final Function() onBottomReachedCallback;
  final Future<void> Function() onRefreshCallback;
  final MtgSymbolUtil symbolsUtil =
      GetIt.instance<MtgSymbolUtil>(instanceName: 'Symbols list util');

  @override
  State<CardsList<T>> createState() => _CardsListState();
}

class _CardsListState<T> extends State<CardsList<T>> {
  final cardListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cardListScrollController.addListener(onBottomReachedListener);
  }

  void onBottomReachedListener() {
    if (cardListScrollController.position.atEdge) {
      bool isTop = cardListScrollController.position.pixels == 0;
      if (!isTop) {
        widget.onBottomReachedCallback.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: widget.onRefreshCallback,
        child: Column(
          children: [
            Expanded(
              child: widget.cards.isEmpty
                  ? Container(
                      margin: const EdgeInsets.all(12),
                      child: const Text('Cards list is empty',
                          style: TextStyle(fontSize: 18)))
                  : ListView.builder(
                      controller: cardListScrollController,
                      itemCount: widget.cards.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final BaseCard card;
                        final List<String?> imageUrl = <String?>[];

                        switch (T) {
                          case ScryfallCard:
                            card = (widget.cards[index] as ScryfallCard);
                            imageUrl.add((card as ScryfallCard).getImageUrl());
                            if (card.cardFaces?.first?.imageUris?.normal !=
                                null) {
                              imageUrl.add(card.getImageUrl(firstFace: false));
                            }
                            break;
                          default:
                            card = (widget.cards[index] as card_models.Card);
                            imageUrl
                                .add((card as card_models.Card).getImageUrl());
                        }

                        final manaUrls = widget.symbolsUtil
                            .getSymbolsUrls(card.getManaCost() ?? emptyString);

                        return ListTile(
                          onTap: () {
                            final String? cardId = card.getId();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CardDetailsPage(
                                          cardId: cardId,
                                        )));
                          },
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 200,
                                  child: imageUrl.length == 1
                                      ? Image.network(
                                          imageUrl.first ?? '',
                                          height: 200,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const PageLoading();
                                          },
                                        )
                                      : FlipCard(
                                          front: Image.network(
                                            imageUrl.first ?? '',
                                            height: 200,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return Hero(
                                                    tag: card.getId() ??
                                                        'details',
                                                    child: child);
                                              }
                                              return const PageLoading();
                                            },
                                          ),
                                          back: Image.network(
                                            imageUrl[1] ?? '',
                                            height: 200,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return Hero(
                                                    tag: card.getId() ??
                                                        'details',
                                                    child: child);
                                              }
                                              return const PageLoading();
                                            },
                                          ),
                                        ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: 200,
                                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(card.getName() ?? ''),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Text('Mana cost: '),
                                        Expanded(
                                          child: Container(
                                            constraints:
                                                const BoxConstraints(maxHeight: 50),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: manaUrls.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  margin: const EdgeInsets.all(2),
                                                  elevation: 0,
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 16,
                                                            maxWidth: 16),
                                                    child: SvgPicture.network(
                                                      manaUrls[index],
                                                      placeholderBuilder:
                                                          (BuildContext
                                                                  context) =>
                                                              const PageLoading(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Type: ${card.getType()}',
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (card.getPrices()['usd'] != null)
                                          Text('${card.getPrices()['usd']} \$'),
                                        if (card.getPrices()['eur'] != null)
                                          Text('${card.getPrices()['eur']} €')
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text('Details'),
                                          SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                  'assets/images/double_arrow.png'))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
            ),
            if (widget.loadingPagination)
              const SizedBox(
                height: 70,
                child: PageLoading(),
              )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cardListScrollController.removeListener(onBottomReachedListener);
  }
}
