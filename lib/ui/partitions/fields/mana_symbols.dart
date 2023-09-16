import 'package:flutter/material.dart';

class ManaSymbols extends StatelessWidget {
  const ManaSymbols({Key? key, this.colors}) : super(key: key);

  final String? colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 30),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: getPathsByColors()
                .map((e) => Container(
                    margin: const EdgeInsets.all(4),
                    child: Image.asset('assets/images/$e.png')))
                .toList(),
          ),
        )
      ],
    );
  }

  List<String> getPathsByColors() {
    final paths = <String>[];

    if (colors?.toLowerCase().contains('w') == true) {
      paths.add('white_mana');
    }

    if (colors?.toLowerCase().contains('u') == true) {
      paths.add('blue_mana');
    }

    if (colors?.toLowerCase().contains('b') == true) {
      paths.add('black_mana');
    }

    if (colors?.toLowerCase().contains('r') == true) {
      paths.add('red_mana');
    }

    if (colors?.toLowerCase().contains('g') == true) {
      paths.add('green_mana');
    }

    return paths;
  }
}
