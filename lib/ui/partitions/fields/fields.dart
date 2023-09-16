import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/responsemodels/card.dart' as cards_models;
import 'package:playground/ui/partitions/bottomsheets/cards_bottomsheets.dart';
import 'package:playground/utils/constants.dart';

class EditableField extends StatelessWidget {
  const EditableField(
      {Key? key,
      required this.label,
      required this.initialValue,
      required this.onEditButtonCallback,
      required this.editable,
      required this.controller,
      this.hint = 'Value not set'})
      : super(key: key);

  final String label;
  final String initialValue;
  final Function() onEditButtonCallback;
  final TextEditingController controller;
  final bool editable;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Text(
            '$label:',
            style:
                const TextStyle(fontSize: 20, color: CustomColors.blackOlive),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            constraints: const BoxConstraints(maxWidth: 200),
            child: TextFormField(
              enabled: editable,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                border: const OutlineInputBorder(),
                hintText: hint,
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
          child: IconButton(
            icon: editable
                ? Image.asset('assets/images/close_button.png')
                : Image.asset('assets/images/edit_pen.png'),
            iconSize: 40,
            onPressed: onEditButtonCallback,
          ),
        )
      ],
    );
  }
}

class RedirectField extends StatelessWidget {
  const RedirectField(
      {Key? key,
      required this.label,
      required this.onRedirectButtonCallback,
      required this.redirectLabel})
      : super(key: key);

  final String label;
  final String redirectLabel;
  final Function() onRedirectButtonCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Text(
            label,
            style:
                const TextStyle(fontSize: 20, color: CustomColors.blackOlive),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: onRedirectButtonCallback,
            child: Text(redirectLabel),
          ),
        ),
      ],
    );
  }
}

class TogglePasswordField extends StatefulWidget {
  TogglePasswordField(
      {Key? key,
      required this.controller,
      this.isVisible = false,
      this.hint = emptyString})
      : super(key: key);

  final TextEditingController controller;
  bool isVisible;
  final String hint;

  @override
  State<TogglePasswordField> createState() => _TogglePasswordFieldState();
}

class _TogglePasswordFieldState extends State<TogglePasswordField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            obscureText: !widget.isVisible,
            enableSuggestions: widget.isVisible,
            autocorrect: widget.isVisible,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              border: const OutlineInputBorder(),
              hintText: widget.hint,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.isVisible = !widget.isVisible;
            });
          },
          icon: widget.isVisible
              ? Image.asset('assets/images/eye_invisible.png')
              : Image.asset('assets/images/eye_visible.png'),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(
      {Key? key,
      required this.onFocus,
      required this.controller,
      required this.onQuerySubmittedCallback,
      required this.onTextChangedCallback,
      required this.onActionButtonCallback,
      this.showIcon = true,
      this.hint = 'Search for cards'})
      : super(key: key);

  final Function() onActionButtonCallback;
  final Function(String) onQuerySubmittedCallback;
  final Function(String) onTextChangedCallback;
  final bool onFocus;
  final TextEditingController controller;
  final bool showIcon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.search,
            onFieldSubmitted: onQuerySubmittedCallback,
            onChanged: onTextChangedCallback,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
          ),
        ),
        if (showIcon)
          Container(
              constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
              child: IconButton(
                icon: onFocus
                    ? Image.asset('assets/images/close_button.png')
                    : Image.asset('assets/images/search_icon.png'),
                onPressed: () {
                  onActionButtonCallback.call();
                },
              )),
      ],
    );
  }
}

class AdvancedSearchField extends StatefulWidget {
  const AdvancedSearchField({
    Key? key,
    required this.removeAddedElementsCallback,
    required this.onDropdownChangedCallback,
    required this.addElementCallback,
    required this.removeTargetElementCallback,
    required this.onTextFieldChangedCallback,
    required this.elements,
    required this.title,
    required this.hint,
  }) : super(key: key);

  final Function() removeAddedElementsCallback;
  final Function(bool) onDropdownChangedCallback;
  final Function() addElementCallback;
  final Function(Object) removeTargetElementCallback;
  final Function(String) onTextFieldChangedCallback;
  final List<String> elements;
  final String title;
  final String hint;

  @override
  State<AdvancedSearchField> createState() => _AdvancedSearchFieldState();
}

class _AdvancedSearchFieldState extends State<AdvancedSearchField> {
  String dropdownValue = 'Either';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: widget.onTextFieldChangedCallback,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  border: const OutlineInputBorder(),
                  hintText: widget.hint,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  widget.addElementCallback.call();
                  setState(() {});
                },
                child: const Text('Add')),
          ],
        ),
        Row(
          children: [
            DropdownButton<String>(
              underline: const SizedBox(),
              value: dropdownValue,
              items: const [
                DropdownMenuItem<String>(
                  value: 'Either',
                  child: Text('Either'),
                ),
                DropdownMenuItem<String>(
                  value: 'All',
                  child: Text('All'),
                )
              ],
              onChanged: (value) {
                widget.onDropdownChangedCallback(value == 'All');
                setState(() {
                  dropdownValue == 'Either'
                      ? dropdownValue = 'All'
                      : dropdownValue = 'Either';
                });
              },
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 60),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.elements.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Text(widget.elements[index]),
                          Container(
                            constraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 30),
                            child: IconButton(
                              onPressed: () {
                                widget.removeTargetElementCallback(
                                    widget.elements[index]);
                                setState(() {});
                              },
                              icon:
                                  Image.asset('assets/images/close_button.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                widget.removeAddedElementsCallback.call();
                setState(() {});
              },
              icon: Image.asset('assets/images/bin.png'),
            ),
          ],
        )
      ],
    );
  }
}

class ColorPickerField extends StatefulWidget {
  const ColorPickerField({
    Key? key,
    required this.removeAddedElementsCallback,
    required this.onDropdownChangedCallback,
    required this.addElementCallback,
    required this.removeTargetElementCallback,
    required this.elements,
    required this.title,
  }) : super(key: key);

  final Function() removeAddedElementsCallback;
  final Function(bool) onDropdownChangedCallback;
  final Function(Object) addElementCallback;
  final Function(Object) removeTargetElementCallback;
  final List<cards_models.ColorIdentities> elements;
  final String title;

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  String dropdownValue = 'Either';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.W),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.W)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.W);
                  setState(() {});
                },
                iconPath: 'assets/images/white_mana.png'),
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.U),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.U)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.U);
                  setState(() {});
                },
                iconPath: 'assets/images/blue_mana.png'),
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.B),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.B)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.B);
                  setState(() {});
                },
                iconPath: 'assets/images/black_mana.png'),
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.R),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.R)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.R);
                  setState(() {});
                },
                iconPath: 'assets/images/red_mana.png'),
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.G),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.G)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.G);
                  setState(() {});
                },
                iconPath: 'assets/images/green_mana.png'),
            ManaIconCheckbox(
                value: widget.elements.contains(cards_models.ColorIdentities.C),
                onChanged: (value) {
                  value == true
                      ? widget.addElementCallback
                          .call(cards_models.ColorIdentities.C)
                      : widget.removeTargetElementCallback
                          .call(cards_models.ColorIdentities.C);
                  setState(() {});
                },
                iconPath: 'assets/images/colorless_mana.png'),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                underline: const SizedBox(),
                value: dropdownValue,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Either',
                    child: Text('Either'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'All',
                    child: Text('All'),
                  )
                ],
                onChanged: (value) {
                  widget.onDropdownChangedCallback(value == 'All');
                  setState(() {
                    dropdownValue == 'Either'
                        ? dropdownValue = 'All'
                        : dropdownValue = 'Either';
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                widget.removeAddedElementsCallback.call();
                setState(() {});
              },
              icon: Image.asset('assets/images/bin.png'),
            ),
          ],
        )
      ],
    );
  }
}

class ComparisonSearchField extends StatefulWidget {
  const ComparisonSearchField({
    Key? key,
    required this.onDropdownChangedCallback,
    required this.onTextFieldChangedCallback,
    required this.title,
    required this.hint,
  }) : super(key: key);

  final Function(String) onDropdownChangedCallback;
  final Function(String) onTextFieldChangedCallback;
  final String title;
  final String hint;

  @override
  State<ComparisonSearchField> createState() => _ComparisonSearchFieldState();
}

class _ComparisonSearchFieldState extends State<ComparisonSearchField> {
  String dropdownValue = '=';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            DropdownButton<String>(
              underline: const SizedBox(),
              value: dropdownValue,
              items: const [
                DropdownMenuItem<String>(
                  value: '<',
                  child: Text('<'),
                ),
                DropdownMenuItem<String>(
                  value: '<=',
                  child: Text('<='),
                ),
                DropdownMenuItem<String>(
                  value: '=',
                  child: Text('='),
                ),
                DropdownMenuItem<String>(
                  value: '>=',
                  child: Text('>='),
                ),
                DropdownMenuItem<String>(
                  value: '>',
                  child: Text('>'),
                )
              ],
              onChanged: (value) {
                widget.onDropdownChangedCallback(value ?? '=');
                setState(() {
                  dropdownValue = value ?? '=';
                });
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextFormField(
                onChanged: widget.onTextFieldChangedCallback,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  border: const OutlineInputBorder(),
                  hintText: widget.hint,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SingleSearchField extends StatelessWidget {
  const SingleSearchField({
    Key? key,
    required this.onTextFieldChangedCallback,
    required this.title,
    required this.hint,
    required this.textEditingController,
  }) : super(key: key);

  final Function(String) onTextFieldChangedCallback;
  final String title;
  final String hint;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                onChanged: onTextFieldChangedCallback,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  border: const OutlineInputBorder(),
                  hintText: hint,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onTextFieldChangedCallback.call(emptyString);
                textEditingController.text = emptyString;
              },
              icon: Image.asset('assets/images/bin.png'),
            ),
          ],
        ),
      ],
    );
  }
}
