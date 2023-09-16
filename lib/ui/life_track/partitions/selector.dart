import 'package:flutter/material.dart';
import 'package:playground/colors.dart';

class SelectorWithIcons<T> extends StatelessWidget {
  SelectorWithIcons(
      {Key? key,
      required this.title,
      required this.onChoiceClicked,
      this.iconPaths,
      T? selected,
      required this.options})
      : selected = selected ?? options.first,
        super(key: key);

  final String title;
  final List<String>? iconPaths;
  final Function(T) onChoiceClicked;
  final T selected;
  final List<T> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: options[index] == selected
                          ? CustomColors.darkGray
                          : Colors.transparent,
                      child: iconPaths != null
                          ? RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                onPressed: () {
                                  onChoiceClicked(options[index]);
                                },
                                icon: Image.asset(iconPaths![index]),
                              ),
                            )
                          : RotatedBox(
                              quarterTurns: 1,
                              child: TextButton(
                                onPressed: () {
                                  onChoiceClicked(options[index]);
                                },
                                child: Text(
                                  options[index].toString(),
                                  style: TextStyle(
                                      color: options[index] == selected
                                          ? CustomColors.orange
                                          : CustomColors.blackOlive),
                                ),
                              ),
                            ),
                    );
                  },
                  itemCount: options.length),
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
