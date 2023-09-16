import 'package:flutter/material.dart';

class AcceptRequestField extends StatelessWidget {
  const AcceptRequestField({
    Key? key,
    required this.title,
    this.imageUrl,
    this.onAcceptCallback,
    this.onRejectCallback,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final Function()? onAcceptCallback;
  final Function()? onRejectCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    imageUrl ??
                        'https://www.shutterstock.com/image-vector/hand-drawn-modern-man-avatar-260nw-1373616899.jpg',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(title)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onAcceptCallback != null)
              IconButton(
                onPressed: onAcceptCallback,
                icon: Image.asset('assets/images/accept.png'),
              ),
            if (onRejectCallback != null)
              Container(
                constraints: const BoxConstraints(maxHeight: 38, maxWidth: 38),
                child: IconButton(
                  onPressed: onRejectCallback,
                  icon: Image.asset('assets/images/bin.png'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
