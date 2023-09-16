import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/partitions/fields/mana_symbols.dart';
import 'package:playground/utils/constants.dart';

class DeckListTile extends StatelessWidget {
  const DeckListTile({
    Key? key,
    required this.tapCallback,
    required this.deckName,
    required this.format,
    this.colors,
    this.backgroundUrl,
  }) : super(key: key);

  final Function() tapCallback;
  final List<String?>? colors;
  final String deckName;
  final String format;
  final List<String?>? backgroundUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback,
      child: Card(
        color: CustomColors.blackOlive,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Container(
            decoration: backgroundUrl != null && backgroundUrl?.isNotEmpty == true
                ? BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(_getBackgroundUrl() ?? emptyString),
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                  child: ManaSymbols(
                    colors: _getColors(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 28, 0, 0),
                  child: Text(
                    deckName,
                    style: const TextStyle(
                      fontSize: 24,
                      color: CustomColors.eggshell,
                      shadows: [Shadow(blurRadius: 8)],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 3,
                  endIndent: 100,
                  indent: 12,
                  color: CustomColors.eggshell,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                  child: Text(
                    format,
                    style: const TextStyle(
                      fontSize: 18,
                      color: CustomColors.eggshell,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getColors() {
    String colorsToReturn = emptyString;

    for (var colorCombo in colors ?? []) {
      final colorList = colorCombo.split('');
      for (var color in colorList) {
        if (colorsToReturn.contains(color) == false) {
          colorsToReturn += color;
        }
      }
    }

    return colorsToReturn;
  }

  String? _getBackgroundUrl() {
    try {
      return backgroundUrl?.first;
    } on StateError catch(err) {
      return null;
    }
  }
}
