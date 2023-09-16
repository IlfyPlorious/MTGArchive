import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/requestmodels/cardsrequest.dart';
import 'package:playground/network/responsemodels/card.dart' as card_models;
import 'package:playground/ui/bloc/cards/cards_cubit.dart';
import 'package:playground/utils/constants.dart';

class CardsFiltersBottomSheet extends StatefulWidget {
  CardsFiltersBottomSheet({Key? key, CardsFilters? cardsFilters})
      : cardsFilters = cardsFilters ?? CardsFilters(),
        _cardTypeSelection = card_models.CardTypes.Any.name,
        _cardRaritySelection = card_models.Rarities.Any,
        _subtypesSelectedList = cardsFilters?.subTypes ?? <String>[],
        _formatSelection = card_models.Legality(
            format: 'Any', legality: card_models.LegalityValues.Legal.name),
        super(key: key);

  final CardsFilters cardsFilters;
  String _cardTypeSelection;
  card_models.Rarities _cardRaritySelection;
  final List<String?> _subtypesSelectedList;
  card_models.Legality _formatSelection;

  @override
  State<CardsFiltersBottomSheet> createState() =>
      _CardsFiltersBottomSheetState();
}

class _CardsFiltersBottomSheetState extends State<CardsFiltersBottomSheet> {
  final _textController = TextEditingController();
  final _subtypesTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.text = widget.cardsFilters.text ?? emptyString;
    return BlocBuilder<CardsListCubit, CardsListState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            color: CustomColors.eggshell,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Center(
                          child: Text(
                        'Filters',
                        style: TextStyle(
                            fontSize: 30, color: CustomColors.blackOlive),
                      )),
                      const Divider(
                        height: 12,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Layout: '),
                                    Expanded(
                                      child: DropdownButton<
                                              card_models.Layouts>(
                                          underline: const SizedBox(),
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          value: state.cardsFilters.layout,
                                          hint: const Text('pick layout'),
                                          selectedItemBuilder: (context) {
                                            return card_models.Layouts.values
                                                .map((item) {
                                              return Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 150),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  item.name,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          items: card_models.Layouts.values
                                              .map((layout) => DropdownMenuItem<
                                                      card_models.Layouts>(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  value: layout,
                                                  child: Text(layout.apiName ??
                                                      card_models
                                                          .Layouts.any.name)))
                                              .toList(),
                                          onChanged: (value) {
                                            context
                                                .read<CardsListCubit>()
                                                .applyFilters(state.cardsFilters
                                                  ..layout = value);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                            'Converted mana cost (CMC): ${state.cardsFilters.cmc ?? 'any'}'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Slider(
                                          min: 0,
                                          max: 20,
                                          divisions: 20,
                                          label: state.cardsFilters.cmc
                                              ?.toString(),
                                          value: state.cardsFilters.cmc
                                                  ?.toDouble() ??
                                              0,
                                          onChanged: (value) {
                                            context
                                                .read<CardsListCubit>()
                                                .applyFilters(state.cardsFilters
                                                  ..cmc = value.toInt());
                                          }),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<CardsListCubit>()
                                            .applyFilters(
                                                state.cardsFilters..cmc = null);
                                        print(state.cardsFilters.cmc);
                                      },
                                      icon: Container(
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0),
                                          constraints: const BoxConstraints(
                                              maxHeight: 15, maxWidth: 15),
                                          child: Image.asset(
                                              'assets/images/close_button.png')),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Colors: '),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models.Colors.White] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(
                                                      state.cardsFilters
                                                        ..colors[card_models
                                                                .Colors.White] =
                                                            value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/white_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models.Colors.Blue] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(
                                                      state.cardsFilters
                                                        ..colors[card_models
                                                                .Colors.Blue] =
                                                            value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/blue_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models.Colors.Black] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(
                                                      state.cardsFilters
                                                        ..colors[card_models
                                                                .Colors.Black] =
                                                            value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/black_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models.Colors.Red] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(state
                                                      .cardsFilters
                                                    ..colors[card_models.Colors
                                                        .Red] = value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/red_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models.Colors.Green] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(
                                                      state.cardsFilters
                                                        ..colors[card_models
                                                                .Colors.Green] =
                                                            value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/green_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters.colors[
                                                    card_models
                                                        .Colors.Colorless] ??
                                                false,
                                            onChanged: (value) {
                                              context
                                                  .read<CardsListCubit>()
                                                  .applyFilters(
                                                      state.cardsFilters
                                                        ..colors[card_models
                                                                .Colors
                                                                .Colorless] =
                                                            value ?? false);
                                            },
                                            iconPath:
                                                'assets/images/colorless_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Color identity: '),
                                      Row(
                                        children: [
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors.White] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                            .colorIdentities[
                                                        card_models
                                                            .Colors.White] =
                                                    value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/white_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors.Blue] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors
                                                        .Blue] = value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/blue_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors.Black] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                            .colorIdentities[
                                                        card_models
                                                            .Colors.Black] =
                                                    value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/black_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors.Red] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors
                                                        .Red] = value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/red_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models.Colors.Green] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                            .colorIdentities[
                                                        card_models
                                                            .Colors.Green] =
                                                    value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/green_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                          ManaIconCheckbox(
                                            value: state.cardsFilters
                                                        .colorIdentities[
                                                    card_models
                                                        .Colors.Colorless] ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                state.cardsFilters
                                                            .colorIdentities[
                                                        card_models
                                                            .Colors.Colorless] =
                                                    value ?? false;
                                              });
                                            },
                                            iconPath:
                                                'assets/images/colorless_mana.png',
                                            constraints: const BoxConstraints(
                                                maxWidth: 20, maxHeight: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Type: '),
                                    Expanded(
                                      child: DropdownButton<String>(
                                          underline: const SizedBox(),
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          value: widget._cardTypeSelection,
                                          hint: const Text('pick layout'),
                                          selectedItemBuilder: (context) {
                                            return card_models.CardTypes.values
                                                .map((item) {
                                              return Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 150),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  item.name,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          items: card_models.CardTypes.values
                                              .map((type) =>
                                                  DropdownMenuItem<String>(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .centerStart,
                                                      value: type.name,
                                                      child: Text(type.name)))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              widget._cardTypeSelection =
                                                  value ??
                                                      card_models
                                                          .CardTypes.Any.name;
                                            });
                                          }),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (widget._cardTypeSelection !=
                                                    'Any' &&
                                                !(state.cardsFilters.types
                                                        ?.contains(widget
                                                            ._cardTypeSelection) ??
                                                    true)) {
                                              state.cardsFilters.types?.add(
                                                  widget._cardTypeSelection);
                                            }
                                          });
                                        },
                                        child: const Text('Add')),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Selected types: '),
                                    Expanded(
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500, maxHeight: 40),
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Card(
                                                color: CustomColors.darkGray,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 8, 0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          state.cardsFilters
                                                                      .types?[
                                                                  index] ??
                                                              'Any',
                                                          style: const TextStyle(
                                                              color: CustomColors
                                                                  .eggshell),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        IconButton(
                                                          iconSize: 10,
                                                          constraints:
                                                              const BoxConstraints(),
                                                          onPressed: () {
                                                            setState(() {
                                                              state.cardsFilters
                                                                  .types
                                                                  ?.removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          icon: Image.asset(
                                                            'assets/images/close_button_light.png',
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: state
                                                .cardsFilters.types?.length,
                                            scrollDirection: Axis.horizontal,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Subtype: '),
                              //       Expanded(
                              //         child: SizedBox(
                              //           height: 30,
                              //           child: TextFormField(
                              //             controller: _subtypesTextController,
                              //             onFieldSubmitted: (value) {
                              //               setState(() {
                              //                 if (value.isNotEmpty &&
                              //                     !widget.cardsFilters.subTypes
                              //                         .contains(value)) {
                              //                   widget.cardsFilters.subTypes
                              //                       .add(value);
                              //                 }
                              //               });
                              //             },
                              //             decoration: InputDecoration(
                              //                 contentPadding:
                              //                     const EdgeInsets.fromLTRB(
                              //                         12, 12, 12, 0),
                              //                 border:
                              //                     const OutlineInputBorder(),
                              //                 hintText:
                              //                     'Fill subtype. Enter to add',
                              //                 suffixIcon: IconButton(
                              //                   icon: Image.asset(
                              //                       'assets/images/close_button.png'),
                              //                   onPressed:
                              //                       _subtypesTextController
                              //                           .clear,
                              //                 )),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Selected subtypes: '),
                              //       Expanded(
                              //         child: Container(
                              //           constraints: const BoxConstraints(
                              //               maxWidth: 500, maxHeight: 40),
                              //           child: ListView.builder(
                              //             itemBuilder: (context, index) {
                              //               return Card(
                              //                 color: CustomColors.darkGray,
                              //                 child: Container(
                              //                   padding:
                              //                       const EdgeInsets.fromLTRB(
                              //                           8, 0, 8, 0),
                              //                   child: Center(
                              //                     child: Row(
                              //                       mainAxisSize:
                              //                           MainAxisSize.min,
                              //                       children: [
                              //                         Text(
                              //                           widget._subtypesSelectedList[
                              //                                   index] ??
                              //                               '',
                              //                           style: const TextStyle(
                              //                               color: CustomColors
                              //                                   .eggshell),
                              //                         ),
                              //                         const SizedBox(
                              //                           width: 4,
                              //                         ),
                              //                         IconButton(
                              //                           iconSize: 10,
                              //                           constraints:
                              //                               const BoxConstraints(),
                              //                           onPressed: () {
                              //                             setState(() {
                              //                               widget.cardsFilters
                              //                                   .subTypes
                              //                                   .remove(widget
                              //                                           ._subtypesSelectedList[
                              //                                       index]);
                              //                             });
                              //                           },
                              //                           icon: Image.asset(
                              //                             'assets/images/close_button_light.png',
                              //                             width: 10,
                              //                             height: 10,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             itemCount: widget
                              //                 ._subtypesSelectedList.length,
                              //             scrollDirection: Axis.horizontal,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     children: [
                              //       const Text('Rarity: '),
                              //       Expanded(
                              //         child: DropdownButton<
                              //                 card_models.Rarities>(
                              //             underline: const SizedBox(),
                              //             alignment: AlignmentDirectional
                              //                 .centerEnd,
                              //             value: widget._cardRaritySelection,
                              //             hint: const Text('pick layout'),
                              //             selectedItemBuilder: (context) {
                              //               return card_models.Rarities.values
                              //                   .map((item) {
                              //                 return Container(
                              //                   constraints:
                              //                       const BoxConstraints(
                              //                           minWidth: 150),
                              //                   alignment:
                              //                       Alignment.centerRight,
                              //                   child: Text(
                              //                     item.name,
                              //                   ),
                              //                 );
                              //               }).toList();
                              //             },
                              //             items: card_models.Rarities.values
                              //                 .map((type) => DropdownMenuItem<
                              //                         card_models.Rarities>(
                              //                     alignment:
                              //                         AlignmentDirectional
                              //                             .centerStart,
                              //                     value: type,
                              //                     child: Text(type.name)))
                              //                 .toList(),
                              //             onChanged: (value) {
                              //               setState(() {
                              //                 widget._cardRaritySelection =
                              //                     value ??
                              //                         card_models.Rarities.Any;
                              //               });
                              //             }),
                              //       ),
                              //       TextButton(
                              //           onPressed: () {
                              //             setState(() {
                              //               if (widget._cardRaritySelection
                              //                       .nameApi !=
                              //                   null) {
                              //                 if (widget.cardsFilters.rarities
                              //                         .contains(widget
                              //                             ._cardRaritySelection) ==
                              //                     false) {
                              //                   widget.cardsFilters.rarities
                              //                       .add(widget
                              //                           ._cardRaritySelection);
                              //                 }
                              //               }
                              //             });
                              //           },
                              //           child: const Text('Add')),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Selected rarities: '),
                              //       Expanded(
                              //         child: Container(
                              //           constraints: const BoxConstraints(
                              //               maxWidth: 500, maxHeight: 40),
                              //           child: ListView.builder(
                              //             itemBuilder: (context, index) {
                              //               return Card(
                              //                 color: CustomColors.darkGray,
                              //                 child: Container(
                              //                   padding:
                              //                       const EdgeInsets.fromLTRB(
                              //                           8, 0, 8, 0),
                              //                   child: Center(
                              //                     child: Row(
                              //                       mainAxisSize:
                              //                           MainAxisSize.min,
                              //                       children: [
                              //                         Text(
                              //                           widget
                              //                                   .cardsFilters
                              //                                   .rarities[index]
                              //                                   ?.nameApi ??
                              //                               '',
                              //                           style: const TextStyle(
                              //                               color: CustomColors
                              //                                   .eggshell),
                              //                         ),
                              //                         const SizedBox(
                              //                           width: 4,
                              //                         ),
                              //                         IconButton(
                              //                           iconSize: 10,
                              //                           constraints:
                              //                               const BoxConstraints(),
                              //                           onPressed: () {
                              //                             setState(() {
                              //                               widget.cardsFilters
                              //                                   .rarities
                              //                                   .removeAt(
                              //                                       index);
                              //                             });
                              //                           },
                              //                           icon: Image.asset(
                              //                             'assets/images/close_button_light.png',
                              //                             width: 10,
                              //                             height: 10,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             itemCount: widget
                              //                 .cardsFilters.rarities.length,
                              //             scrollDirection: Axis.horizontal,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Text: '),
                              //       Expanded(
                              //         child: TextFormField(
                              //           textInputAction: TextInputAction.go,
                              //           controller: _textController,
                              //           keyboardType: TextInputType.multiline,
                              //           maxLines: 5,
                              //           minLines: 1,
                              //           decoration: InputDecoration(
                              //               contentPadding:
                              //                   const EdgeInsets.fromLTRB(
                              //                       12, 12, 12, 0),
                              //               border: const OutlineInputBorder(),
                              //               hintText:
                              //                   'Fill text. Enter to submit',
                              //               suffixIconConstraints:
                              //                   const BoxConstraints(
                              //                       maxHeight: 30,
                              //                       maxWidth: 30),
                              //               suffixIcon: IconButton(
                              //                 icon: Image.asset(
                              //                     'assets/images/close_button.png'),
                              //                 onPressed: _textController.clear,
                              //               )),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     children: [
                              //       const Text('Formats: '),
                              //       BlocBuilder<CardsFiltersCubit,
                              //           CardsFiltersState>(
                              //         builder: (context, state) {
                              //           switch (state.status) {
                              //             case Status.initial:
                              //               return const PageLoading();
                              //             case Status.success:
                              //               // return Text(
                              //               //     widget._formatSelection.format ??
                              //               //         emptyString);
                              //               // return Expanded(
                              //               //     child: Text(
                              //               //         state.legalities.toString()));
                              //               return Expanded(
                              //                 child: DropdownButton<
                              //                         card_models.Legality>(
                              //                     underline: const SizedBox(),
                              //                     value: widget
                              //                         ._formatSelection,
                              //                     alignment:
                              //                         AlignmentDirectional
                              //                             .centerEnd,
                              //                     hint: const Text(
                              //                         'pick format'),
                              //                     selectedItemBuilder:
                              //                         (context) {
                              //                       return state.legalities
                              //                           .map((item) {
                              //                         return Container(
                              //                           constraints:
                              //                               const BoxConstraints(
                              //                                   minWidth: 150),
                              //                           alignment: Alignment
                              //                               .centerRight,
                              //                           child: Text(
                              //                             item.format ??
                              //                                 emptyString,
                              //                           ),
                              //                         );
                              //                       }).toList();
                              //                     },
                              //                     items: state.legalities
                              //                         .map((legality) =>
                              //                             DropdownMenuItem<
                              //                                     card_models
                              //                                         .Legality>(
                              //                                 alignment:
                              //                                     AlignmentDirectional
                              //                                         .centerStart,
                              //                                 value: legality,
                              //                                 child: Text(legality
                              //                                         .format ??
                              //                                     emptyString)))
                              //                         .toList(),
                              //                     onChanged: (value) {
                              //                       setState(() {
                              //                         widget._formatSelection =
                              //                             value ??
                              //                                 card_models
                              //                                     .Legality();
                              //                       });
                              //                     }),
                              //               );
                              //             case Status.loading:
                              //               return const PageLoading();
                              //             case Status.failure:
                              //               Logger().d(state.exception);
                              //               return Expanded(
                              //                 child: FittedBox(
                              //                   fit: BoxFit.fitWidth,
                              //                   child: Row(
                              //                     children: [
                              //                       const Text(
                              //                           'Error loading Data'),
                              //                       const SizedBox(
                              //                         width: 15,
                              //                       ),
                              //                       ElevatedButton(
                              //                         onPressed: () {
                              //                           context
                              //                               .read<
                              //                                   CardsFiltersCubit>()
                              //                               .fetchFormats();
                              //                         },
                              //                         style: ElevatedButton.styleFrom(
                              //                             backgroundColor:
                              //                                 CustomColors
                              //                                     .blackOlive,
                              //                             padding:
                              //                                 const EdgeInsets
                              //                                         .fromLTRB(
                              //                                     16,
                              //                                     8,
                              //                                     16,
                              //                                     8)),
                              //                         child: const Text(
                              //                           'Retry',
                              //                           style: TextStyle(
                              //                               color: CustomColors
                              //                                   .orange,
                              //                               fontSize: 20),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               );
                              //             default:
                              //               return const PageLoading();
                              //           }
                              //         },
                              //       ),
                              //       TextButton(
                              //           onPressed: () {
                              //             setState(() {
                              //               if (widget._formatSelection
                              //                           .format !=
                              //                       null &&
                              //                   widget._formatSelection
                              //                           .format !=
                              //                       'Any') {
                              //                 if (widget.cardsFilters.legalities
                              //                         .contains(widget
                              //                             ._formatSelection) ==
                              //                     false) {
                              //                   widget.cardsFilters.legalities
                              //                       .add(widget
                              //                           ._formatSelection);
                              //                 }
                              //               }
                              //             });
                              //           },
                              //           child: const Text('Add')),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text('Selected formats: '),
                              //       Expanded(
                              //         child: Container(
                              //           constraints: const BoxConstraints(
                              //               maxWidth: 500, maxHeight: 40),
                              //           child: ListView.builder(
                              //             itemBuilder: (context, index) {
                              //               return Card(
                              //                 color: CustomColors.darkGray,
                              //                 child: Container(
                              //                   padding:
                              //                       const EdgeInsets.fromLTRB(
                              //                           8, 0, 8, 0),
                              //                   child: Center(
                              //                     child: Row(
                              //                       mainAxisSize:
                              //                           MainAxisSize.min,
                              //                       children: [
                              //                         Text(
                              //                           widget
                              //                                   .cardsFilters
                              //                                   .legalities[
                              //                                       index]
                              //                                   ?.format ??
                              //                               '',
                              //                           style: const TextStyle(
                              //                               color: CustomColors
                              //                                   .eggshell),
                              //                         ),
                              //                         const SizedBox(
                              //                           width: 4,
                              //                         ),
                              //                         IconButton(
                              //                           iconSize: 10,
                              //                           constraints:
                              //                               const BoxConstraints(),
                              //                           onPressed: () {
                              //                             setState(() {
                              //                               widget.cardsFilters
                              //                                   .legalities
                              //                                   .removeAt(
                              //                                       index);
                              //                             });
                              //                           },
                              //                           icon: Image.asset(
                              //                             'assets/images/close_button_light.png',
                              //                             width: 10,
                              //                             height: 10,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             },
                              //             itemCount: widget
                              //                 .cardsFilters.legalities.length,
                              //             scrollDirection: Axis.horizontal,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: const Text('Apply filters'),
                              onPressed: () {
                                widget.cardsFilters.text = _textController.text;
                                context
                                    .read<CardsListCubit>()
                                    .applyFilters(state.cardsFilters);
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Reset filters'),
                              onPressed: () {
                                context
                                    .read<CardsListCubit>()
                                    .applyFilters(CardsFilters());
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ManaIconCheckbox extends StatelessWidget {
  const ManaIconCheckbox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.iconPath,
      this.constraints})
      : super(key: key);

  final bool value;
  final void Function(bool?)? onChanged;
  final String iconPath;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          onChanged?.call(!value);
        },
        icon: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: value ? 1 : 0.3,
          child: Container(
            constraints: constraints,
            child: Image.asset(
              iconPath,
            ),
          ),
        ));
  }
}
