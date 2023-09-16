import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/responsemodels/friends/chat/message.dart';
import 'package:playground/network/responsemodels/friends/friendship.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/ui/bloc/friends/chat/chat_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/chat_message.dart';
import 'package:playground/ui/partitions/fields/message_bar.dart';
import 'package:playground/utils/constants.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.correspondent}) : super(key: key);

  final FirebaseUser correspondent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..initData(corespondent: correspondent),
      child: const ChatView(),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: const EdgeInsets.all(0),
            icon: Image.asset('assets/images/back_arrow_light.png'),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Chatting with ',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return ChatData(
                        corespondent: state.corespondent,
                      );
                    case Status.success:
                      return ChatData(
                        corespondent: state.corespondent,
                        friendship: state.friendship,
                      );
                    case Status.loading:
                      return const PageLoading();
                    case Status.failure:
                      return Center(
                        child: Text(state.exception.toString()),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatData extends StatelessWidget {
  ChatData({
    Key? key,
    required this.corespondent,
    FirebaseFriendship? friendship,
  })  : friendship = friendship ?? const FirebaseFriendship(),
        super(key: key);

  final FirebaseUser corespondent;
  final FirebaseFriendship friendship;
  final ScrollController _controller = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: BlocProvider.of<ChatCubit>(context).messagesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (_controller.hasClients) {
                  _controller.animateTo(_controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
              });

              final messagesList = snapshot.data?.docs
                  .map((doc) => FirebaseMessage.fromJson(
                      doc.data() as Map<String, dynamic>))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  controller: _controller,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Logger().i(
                            '${messagesList?[index].idFrom} vs ${corespondent.id}');
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            messagesList?[index].idTo == corespondent.id
                                ? 0
                                : 24,
                            6,
                            messagesList?[index].idTo == corespondent.id
                                ? 24
                                : 0,
                            6),
                        child: ChatMessage(
                          content: messagesList?[index].content ?? emptyString,
                          timestamp:
                              messagesList?[index].timestamp ?? emptyString,
                          isSent: messagesList?[index].idTo == corespondent.id,
                        ),
                      ),
                    );
                  },
                  itemCount: messagesList?.length,
                ),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: SendMessageBar(
            controller: _textController,
            onSendCallback: (value) {
              _textController.text = emptyString;
              context.read<ChatCubit>().sendMessage(FirebaseMessage(
                  idFrom: FirebaseAuth.instance.currentUser?.uid,
                  idTo: corespondent.id,
                  content: value,
                  timestamp: DateTime.now().toString()));
            },
            hint: 'Type your message here',
          ),
        ),
      ],
    );
  }
}
