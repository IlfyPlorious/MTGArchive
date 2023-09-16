part of 'advanced_search_result_page.dart';

class AdvancedSearchResultPageData extends StatelessWidget {
  AdvancedSearchResultPageData({
    Key? key,
    List<ScryfallCard>? cards,
    this.loadingPagination = false,
  })  : cards = cards ?? <ScryfallCard>[],
        super(key: key);

  final List<ScryfallCard> cards;
  final bool loadingPagination;

  @override
  Widget build(BuildContext context) {
    return CardsList<ScryfallCard>(
      cards: cards,
      onBottomReachedCallback: () {
        context.read<AdvancedSearchResultPageCubit>().loadNextPage();
      },
      onRefreshCallback: () async {
        context.read<AdvancedSearchResultPageCubit>().fetchCards();
      },
      loadingPagination: loadingPagination,
    );
  }
}
