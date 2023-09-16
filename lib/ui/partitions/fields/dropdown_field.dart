import 'package:flutter/material.dart';

class DropdownField<T> extends StatefulWidget {
  const DropdownField({
    Key? key,
    required this.label,
    required this.dropdownList,
    required this.onDropdownChangedCallback,
    this.hint,
  }) : super(key: key);

  final String label;
  final List<T> dropdownList;
  final Function(T?) onDropdownChangedCallback;
  final String? hint;

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  T? currentSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 25),
          ),
          const Divider(
            thickness: 2,
            endIndent: 48,
          ),
          DropdownButtonFormField<T>(
            value: currentSelection,
            items: widget.dropdownList
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              border: const OutlineInputBorder(),
              hintText: widget.hint,
            ),
            onChanged: (value) {
              widget.onDropdownChangedCallback.call(value);
              setState(() {
                currentSelection = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
