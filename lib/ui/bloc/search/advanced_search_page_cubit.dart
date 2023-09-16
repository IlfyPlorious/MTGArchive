import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/utils/constants.dart';

part 'advanced_search_page_state.dart';

class AdvancedSearchPageCubit extends Cubit<AdvancedSearchPageState> {
  AdvancedSearchPageCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(AdvancedSearchPageState());

  final ApiServiceRepository _apiRepository;

  void updateMatchAll({required String key, required dynamic value}) {
    emit(state.copyWith(matchAll: state.matchAll..[key] = value));
  }

  // ----- colors ----- //

  void addColor(ColorIdentities color) {
    if (!state.colors.contains(color)) {
      emit(state.copyWith(
        colors: state.colors..add(color),
      ));
    }
  }

  void removeColors() {
    emit(state.copyWith(colors: state.colors..clear()));
  }

  void removeTargetColor(ColorIdentities color) {
    emit(state.copyWith(colors: state.colors..remove(color)));
  }

  // ----- types ----- //

  void updateTypeSelection(String value) {
    emit(state.copyWith(typeSelection: value));
  }

  void addType() {
    if (state.typeSelection != emptyString &&
        !state.types.contains(state.typeSelection)) {
      emit(state.copyWith(
        types: state.types..add(state.typeSelection),
      ));
    }
  }

  void removeTypes() {
    emit(state.copyWith(types: state.types..clear()));
  }

  void removeTargetType(String value) {
    emit(state.copyWith(types: state.types..remove(value)));
  }

  // ----- rarities ----- //

  void updateRaritySelection(String value) {
    emit(state.copyWith(raritySelection: value));
  }

  void addRarity() {
    if (state.raritySelection != emptyString &&
        !state.rarities.contains(state.raritySelection)) {
      emit(state.copyWith(
        rarities: state.rarities..add(state.raritySelection),
      ));
    }
  }

  void removeRarities() {
    emit(state.copyWith(rarities: state.rarities..clear()));
  }

  void removeTargetRarity(String value) {
    emit(state.copyWith(rarities: state.rarities..remove(value)));
  }

  // ----- text ----- //

  void updateText(String value) {
    emit(state.copyWith(text: value));
  }

  // ----- power ----- //

  void updatePower(String value) {
    emit(state.copyWith(power: value));
  }

  // ----- toughness ----- //

  void updateToughness(String value) {
    emit(state.copyWith(toughness: value));
  }

  // ----- loyalty ----- //

  void updateLoyalty(String value) {
    emit(state.copyWith(loyalty: value));
  }

  // ----- blocks ----- //

  void updateBlocksSelection(String value) {
    emit(state.copyWith(blocksSelection: value));
  }

  void addBlock() {
    if (state.blocksSelection != emptyString &&
        !state.blocks.contains(state.blocksSelection)) {
      emit(state.copyWith(
        blocks: state.blocks..add(state.blocksSelection),
      ));
    }
  }

  void removeBlocks() {
    emit(state.copyWith(blocks: state.blocks..clear()));
  }

  void removeTargetBlock(String value) {
    emit(state.copyWith(blocks: state.blocks..remove(value)));
  }

  // ----- sets ----- //

  void updateSetsSelection(String value) {
    emit(state.copyWith(setsSelection: value));
  }

  void addSet() {
    if (state.setsSelection != emptyString &&
        !state.sets.contains(state.setsSelection)) {
      emit(state.copyWith(
        sets: state.sets..add(state.setsSelection),
      ));
    }
  }

  void removeSets() {
    emit(state.copyWith(sets: state.sets..clear()));
  }

  void removeTargetSet(String value) {
    emit(state.copyWith(sets: state.sets..remove(value)));
  }

  // ----- formats ----- //

  void updateFormatSelection(String value) {
    emit(state.copyWith(formatsSelection: value));
  }

  void addFormat() {
    if (state.formatsSelection != emptyString &&
        !state.formats.contains(state.formatsSelection)) {
      emit(state.copyWith(
        formats: state.formats..add(state.formatsSelection),
      ));
    }
  }

  void removeFormats() {
    emit(state.copyWith(formats: state.formats..clear()));
  }

  void removeTargetFormat(String value) {
    emit(state.copyWith(formats: state.formats..remove(value)));
  }

  // ----- year ----- //

  void updateYear(String value) {
    emit(state.copyWith(year: value));
  }

  SearchRequest buildSearchRequest() {
    return SearchRequest(
      query: FullTextSearchQuery(
        colors: state.colors.isNotEmpty ? state.colors : null,
        types: state.types.isNotEmpty ? state.types : null,
        text: state.text?.isNotEmpty == true ? state.text : null,
        power: state.power?.isNotEmpty == true ? state.power : null,
        toughness: state.toughness?.isNotEmpty == true ? state.toughness : null,
        loyalty: state.loyalty?.isNotEmpty == true ? state.loyalty : null,
        rarities: state.rarities.isNotEmpty ? state.rarities : null,
        blocks: state.blocks.isNotEmpty ? state.blocks : null,
        sets: state.sets.isNotEmpty ? state.sets : null,
        formats: state.formats.isNotEmpty ? state.formats : null,
        year: state.year?.isNotEmpty == true ? state.year : null,
      ),
      matchAll: state.matchAll,
    );
  }
}
