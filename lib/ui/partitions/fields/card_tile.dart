import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/partitions/fields/mana_symbols.dart';
import 'package:playground/utils/constants.dart';

class CardTile extends StatelessWidget {
  const CardTile(
      {Key? key,
      required this.name,
      this.colors,
      this.backgroundUrl,
      this.count,
      this.maxCardCount = 4,
      required this.onRemoveCardCallback,
      required this.onTapCallback})
      : super(key: key);

  final String name;
  final String? colors;
  final String? backgroundUrl;
  final int? count;
  final int maxCardCount;
  final Function() onRemoveCardCallback;
  final Function() onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (count != null)
          Text(
            '${count}x',
            style: TextStyle(
                color: count! > maxCardCount
                    ? CustomColors.darkErrorRed
                    : CustomColors.blackOlive),
          ),
        Expanded(
          child: GestureDetector(
            onTap: onTapCallback,
            child: Card(
              color: CustomColors.blackOlive,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(12),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Container(
                  decoration: backgroundUrl != null
                      ? BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(backgroundUrl ?? emptyString),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            name,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: CustomColors.eggshell,
                                fontSize: 18,
                                shadows: [Shadow(blurRadius: 8)]),
                          ),
                        ),
                        ManaSymbols(
                          colors: colors,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onRemoveCardCallback,
          icon: Image.asset('assets/images/bin.png'),
        ),
      ],
    );
  }
}
