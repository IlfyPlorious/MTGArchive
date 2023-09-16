part of 'search_page.dart';

class SearchPageData extends StatefulWidget {
  SearchPageData(
      {Key? key,
      List<String?>? autocompleteSuggestions,
      List<ScryfallCard>? searchResultCards,
      String? autocompleteQuery,
      this.searchOnFocus = false,
      this.showSearchResults = false,
      this.loadingPagination = false,
      this.autocompleteLoading = false})
      : autocompleteQuery = autocompleteQuery ?? emptyString,
        autocompleteSuggestions = autocompleteSuggestions ?? <String?>[],
        searchResultCards = searchResultCards ?? <ScryfallCard>[],
        super(key: key);

  final bool autocompleteLoading;
  final bool searchOnFocus;
  final String autocompleteQuery;
  final bool showSearchResults;
  final bool loadingPagination;
  final List<String?> autocompleteSuggestions;
  final List<ScryfallCard> searchResultCards;

  @override
  State<SearchPageData> createState() => _SearchPageDataState();
}

class _SearchPageDataState extends State<SearchPageData> {
  final searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFieldController.addListener(() {
      context.read<SearchPageCubit>().changeFocus(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedAlign(
        curve: Curves.fastOutSlowIn,
        alignment:
            widget.searchOnFocus ? Alignment.topCenter : Alignment.center,
        duration: const Duration(milliseconds: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(12, widget.searchOnFocus ? 8 : 0, 12, 0),
              child: SearchField(
                controller: searchFieldController,
                onFocus: widget.searchOnFocus,
                onTextChangedCallback: (value) {
                  context
                      .read<SearchPageCubit>()
                      .getAutocompleteSuggestions(value);
                },
                onQuerySubmittedCallback: (value) {
                  if (value.length >= 3) {
                    context.read<SearchPageCubit>().showSearchResults(value);
                  }
                },
                onActionButtonCallback: () {
                  searchFieldController.text = emptyString;
                  context.read<SearchPageCubit>().changeFocus(false);
                  context.read<SearchPageCubit>().changeShowResults(false);
                },
              ),
            ),
            widget.searchOnFocus && searchFieldController.text.length > 2
                ? Container(
                    constraints: const BoxConstraints(maxHeight: 150),
                    decoration: const BoxDecoration(
                      color: CustomColors.darkGray,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: widget.autocompleteLoading
                        ? const PageLoading()
                        : ListView.separated(
                            itemCount: widget.autocompleteSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion =
                                  widget.autocompleteSuggestions[index];
                              return ListTile(
                                title: TextButton(
                                  style: const ButtonStyle(
                                      alignment: Alignment.centerLeft),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CardDetailsPage(
                                                    name: suggestion,)));
                                  },
                                  child: Text(
                                    suggestion ?? emptyString,
                                    style: const TextStyle(
                                        color: CustomColors.orange),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                  )
                : widget.showSearchResults
                    ? CardsList<ScryfallCard>(
                        cards: widget.searchResultCards,
                        onRefreshCallback: () async {
                          context
                              .read<SearchPageCubit>()
                              .showSearchResults(null);
                        },
                        onBottomReachedCallback: () {
                          context.read<SearchPageCubit>().loadNextPage();
                        },
                        loadingPagination: widget.loadingPagination)
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdvancedSearchPage()));
                        },
                        child: const Text('Advanced search'),
                      ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    searchFieldController.dispose();
    super.dispose();
  }
}
