import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/ui/bloc/details/details_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/utils/constants.dart';
import 'package:playground/utils/utils.dart';

part 'partitions/error/card_details_page_error.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({Key? key, this.cardId, this.name}) : super(key: key);

  final String? cardId;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (cardId != null) {
          return DetailsCubit()..fetchCardById(cardId ?? emptyString);
        } else {
          return DetailsCubit()..fetchCardByName(name);
        }
      },
      child: const CardDetailsView(),
    );
  }
}

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({Key? key}) : super(key: key);

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
              'Card details',
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
                  BlocBuilder<DetailsCubit, DetailsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case DetailsStatus.initial:
                          return const Expanded(child: PageLoading());
                        case DetailsStatus.success:
                          return CardDetails(
                              card: state.cardDetails, rulings: state.rulings);
                        case DetailsStatus.loading:
                          return const Expanded(child: PageLoading());
                        case DetailsStatus.failure:
                          return CardDetailsPageError(
                            state.exception ?? Exception('Error loading data'),
                            id: state.cardDetails.multiverseIds?.first
                                    .toString() ??
                                '',
                          );
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

class CardDetails extends StatefulWidget {
  CardDetails({Key? key, required this.card, required this.rulings})
      : super(key: key);

  final ScryfallCard card;
  final String rulings;
  final MtgSymbolUtil symbolsUtil =
      GetIt.instance<MtgSymbolUtil>(instanceName: 'Symbols list util');

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  bool imageExpanded = false;
  final FlipCardController _controller = FlipCardController();
  final manaUrls = <String>[];

  @override
  void initState() {
    super.initState();
    manaUrls.addAll(widget.symbolsUtil
        .getSymbolsUrls(widget.card.getManaCost() ?? emptyString));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 700),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      imageExpanded = !imageExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      widget.card.getImageUrl() != null
                          //mediaquery
                          ? Expanded(
                              child: Stack(children: [
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: FlipCard(
                                    flipOnTouch: false,
                                    controller: _controller,
                                    front: Image.network(
                                        widget.card.getImageUrl() ?? '',
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const PageLoading();
                                    }),
                                    back: Image.network(
                                        widget.card.getImageUrl(
                                                firstFace: false) ??
                                            '',
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const PageLoading();
                                    }),
                                  ),
                                ),
                                if (widget.card.cardFaces != null)
                                  Align(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 42,
                                      onPressed: () {
                                        Logger().i('testing gestures');
                                        _controller.toggleCard();
                                      },
                                      icon: const Icon(
                                        Icons.rotate_90_degrees_ccw_outlined,
                                        color: CustomColors.gray,
                                      ),
                                    ),
                                  ),
                              ]),
                            )
                          : Image.asset('assets/images/card_placeholder.png'),
                    ],
                  ),
                ),
              ),
            ),
            if (!imageExpanded)
              const Text(
                'Tap card to preview',
                style: TextStyle(fontSize: 12, color: CustomColors.gray),
              ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.card.getPrices()['usd'] != null)
                    Text('${widget.card.getPrices()['usd']} \$'),
                  if (widget.card.getPrices()['eur'] != null)
                    Text('${widget.card.getPrices()['eur']} €')
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              child: !imageExpanded
                  ? ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 300, maxHeight: 400),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 2, 8, 16),
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        decoration: const BoxDecoration(
                          color: CustomColors.darkGray,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Text(
                                        widget.card.name ?? '',
                                        style: const TextStyle(
                                            fontSize: 32,
                                            color: CustomColors.eggshell),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Text(
                                        widget.card.typeLine ?? '',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: CustomColors.eggshell),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Mana cost: ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: CustomColors.eggshell),
                                          ),
                                          Expanded(
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 50),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: manaUrls.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    margin:
                                                        const EdgeInsets.all(2),
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
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Text(
                                        'Text: \n${widget.card.getText()}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: CustomColors.eggshell),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Text(
                                        'Set: ${widget.card.setName}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: CustomColors.eggshell),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 18),
                                      child: Text(
                                        'Legality:\n${widget.card.legalities.toString()}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.eggshell,
                                        ),
                                      ),
                                    ),
                                    if (widget.rulings.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 18),
                                        child: Text(
                                          'Rules:\n\n${widget.rulings}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: CustomColors.eggshell),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
