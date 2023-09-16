part of 'advanced_search_page.dart';

class AdvancedSearchPageData extends StatelessWidget {
  const AdvancedSearchPageData({
    Key? key,
    required this.types,
    required this.rarities,
    required this.blocks,
    required this.sets,
    required this.formats,
    required this.showStateCallback,
    required this.colors,
    required this.textEditingController,
  }) : super(key: key);

  final Function() showStateCallback;

  final List<ColorIdentities> colors;
  final List<String> types;
  final List<String> rarities;
  final List<String> blocks;
  final List<String> sets;
  final List<String> formats;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ColorPickerField(
                    title: 'Colors',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeColors();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'colors', value: value);
                    },
                    addElementCallback: (color) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .addColor(color as ColorIdentities);
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetColor(value as ColorIdentities);
                    },
                    elements: colors,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: AdvancedSearchField(
                    title: 'Types',
                    hint: 'Add a type (ex. creature)',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeTypes();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'types', value: value);
                    },
                    addElementCallback: () {
                      context.read<AdvancedSearchPageCubit>().addType();
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetType(value as String);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateTypeSelection(value);
                    },
                    elements: types,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: AdvancedSearchField(
                    title: 'Rarities',
                    hint: 'Add a rarity (ex. mythic)',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeRarities();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'rarities', value: value);
                    },
                    addElementCallback: () {
                      context.read<AdvancedSearchPageCubit>().addRarity();
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetRarity(value as String);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateRaritySelection(value);
                    },
                    elements: rarities,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: SingleSearchField(
                    title: 'Text',
                    hint: 'Add oracle text',
                    textEditingController: textEditingController,
                    onTextFieldChangedCallback: (value) {
                      context.read<AdvancedSearchPageCubit>().updateText(value);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ComparisonSearchField(
                    title: 'Power',
                    hint: 'Type power value',
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'power', value: value);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updatePower(value);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ComparisonSearchField(
                    title: 'Toughness',
                    hint: 'Type toughness value',
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'toughness', value: value);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateToughness(value);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ComparisonSearchField(
                    title: 'Loyalty',
                    hint: 'Type loyalty value',
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'loyalty', value: value);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateLoyalty(value);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: AdvancedSearchField(
                    title: 'Blocks',
                    hint: 'Add a block (ex. BRO)',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeBlocks();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'blocks', value: value);
                    },
                    addElementCallback: () {
                      context.read<AdvancedSearchPageCubit>().addBlock();
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetBlock(value as String);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateBlocksSelection(value);
                    },
                    elements: blocks,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: AdvancedSearchField(
                    title: 'Sets',
                    hint: 'Add a set (ex. MOM)',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeSets();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'sets', value: value);
                    },
                    addElementCallback: () {
                      context.read<AdvancedSearchPageCubit>().addSet();
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetSet(value as String);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateSetsSelection(value);
                    },
                    elements: sets,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: AdvancedSearchField(
                    title: 'Formats',
                    hint: 'Add format (ex. pauper)',
                    removeAddedElementsCallback: () {
                      context.read<AdvancedSearchPageCubit>().removeFormats();
                    },
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'formats', value: value);
                    },
                    addElementCallback: () {
                      context.read<AdvancedSearchPageCubit>().addFormat();
                    },
                    removeTargetElementCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .removeTargetFormat(value as String);
                    },
                    onTextFieldChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateFormatSelection(value);
                    },
                    elements: formats,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ComparisonSearchField(
                    title: 'Year',
                    hint: 'Type year (ex. 1993)',
                    onDropdownChangedCallback: (value) {
                      context
                          .read<AdvancedSearchPageCubit>()
                          .updateMatchAll(key: 'year', value: value);
                    },
                    onTextFieldChangedCallback: (value) {
                      context.read<AdvancedSearchPageCubit>().updateYear(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  final searchRequest = context
                      .read<AdvancedSearchPageCubit>()
                      .buildSearchRequest();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => AdvancedSearchResultPage(
                              searchRequest: searchRequest)));
                },
                child: const Text('Search')),
          ],
        )
      ],
    );
  }
}
