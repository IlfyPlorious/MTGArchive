import 'package:flutter/material.dart';
import 'package:playground/colors.dart';

class SendMessageBar extends StatelessWidget {
  SendMessageBar(
      {Key? key,
      required this.onSendCallback,
      this.hint,
      TextEditingController? controller})
      : controller = controller ?? TextEditingController(),
        super(key: key);

  final Function(String) onSendCallback;
  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            onFieldSubmitted: (value) {
              onSendCallback(controller.text);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              onSendCallback(controller.text);
            },
            icon: const Icon(
              Icons.send_outlined,
              color: CustomColors.orange,
            ))
      ],
    );
  }
}
