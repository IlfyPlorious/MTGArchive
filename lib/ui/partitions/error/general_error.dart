import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/exceptions/exceptions.dart';

class GeneralErrorPage extends StatelessWidget {
  const GeneralErrorPage(
    this.exception, {
    Key? key,
    this.hasRetryButton = false,
    required this.retryCallback,
  }) : super(key: key);

  final Exception exception;
  final bool hasRetryButton;
  final void Function() retryCallback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((exception as ServerErrorException).getServerError(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40, color: CustomColors.blackOlive)),
          if (hasRetryButton)
            Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: retryCallback,
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.blackOlive,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8)),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: CustomColors.orange, fontSize: 20),
                ),
              ),
            )
        ],
      ),
    );
  }
}
