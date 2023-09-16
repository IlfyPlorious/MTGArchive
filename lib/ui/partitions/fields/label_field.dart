import 'package:flutter/material.dart';

class TopLabelField extends StatelessWidget {
  const TopLabelField(
      {Key? key,
      required this.label,
      required this.onTextChangedCallback,
      this.hint})
      : super(key: key);

  final Function(String) onTextChangedCallback;
  final String label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 25),
          ),
          const Divider(
            thickness: 2,
            endIndent: 48,
          ),
          TextFormField(
            onChanged: onTextChangedCallback,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
          ),
        ],
      ),
    );
  }
}
