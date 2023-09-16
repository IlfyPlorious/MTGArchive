import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/utils/utils.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {Key? key,
      required this.content,
      required this.timestamp,
      this.isSent = true})
      : super(key: key);

  final String content;
  final String timestamp;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        color: isSent ? CustomColors.gray : CustomColors.darkGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Utils.getFormattedDate(timestamp),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSent
                        ? CustomColors.blackOlive
                        : CustomColors.eggshell,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    textAlign: isSent ? TextAlign.start : TextAlign.end,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSent
                          ? CustomColors.blackOlive
                          : CustomColors.eggshell,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
