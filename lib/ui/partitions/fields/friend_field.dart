import 'package:flutter/material.dart';

class FriendField extends StatelessWidget {
  const FriendField({
    Key? key,
    required this.email,
    this.imageUrl,
    this.onUnfriendCallback,
    this.onChatNavigationCallback,
  }) : super(key: key);

  final String email;
  final String? imageUrl;
  final Function()? onUnfriendCallback;
  final Function()? onChatNavigationCallback;

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
                    child: Text(email)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onChatNavigationCallback != null)
              Container(
                constraints: const BoxConstraints(maxHeight: 38, maxWidth: 38),
                child: IconButton(
                  onPressed: onChatNavigationCallback,
                  icon: Image.asset('assets/images/chat.png'),
                ),
              ),
            const SizedBox(
              width: 12,
            ),
            if (onUnfriendCallback != null)
              Container(
                constraints: const BoxConstraints(maxHeight: 38, maxWidth: 38),
                child: IconButton(
                  onPressed: onUnfriendCallback,
                  icon: Image.asset('assets/images/unfriend.png'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
