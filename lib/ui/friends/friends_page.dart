import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/responsemodels/friends/friend_request.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/ui/bloc/friends/friends_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/friends/add_friend_search.dart';
import 'package:playground/ui/friends/chat/chat_page.dart';
import 'package:playground/ui/partitions/fields/accept_request_field.dart';
import 'package:playground/ui/partitions/fields/friend_field.dart';
import 'package:playground/utils/constants.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsCubit()..initData(),
      child: const FriendsView(),
    );
  }
}

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Friends',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 50)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: CustomColors.eggshell,
              title: const Text(
                'Type to send friend request',
                style: TextStyle(color: CustomColors.blackOlive),
              ),
              content: FriendSearch(),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: CustomColors.orange),
                  ),
                ),
              ],
            ),
          ).then((value) => context.read<FriendsCubit>().initData());
        },
        label: const Text('Add friend'),
        icon: const Icon(Icons.add_circle),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  BlocBuilder<FriendsCubit, FriendsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case Status.initial:
                          return FriendsData();
                        case Status.success:
                          return FriendsData(
                            sentFriendRequests: state.sentFriendRequests,
                            sentToUsers: state.sentToUsers,
                            receivedFriendRequests:
                                state.receivedFriendRequests,
                            receivedFromUsers: state.receivedFromUsers,
                            friendsList: state.friendsList,
                          );
                        case Status.loading:
                          return const Expanded(child: PageLoading());
                        case Status.failure:
                          return Center(
                            child: Text(state.exception.toString()),
                          );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendsData extends StatelessWidget {
  FriendsData({
    Key? key,
    List<FirebaseUser>? friendsList,
    List<FirebaseFriendRequest>? receivedFriendRequests,
    List<FirebaseFriendRequest>? sentFriendRequests,
    List<FirebaseUser>? sentToUsers,
    List<FirebaseUser>? receivedFromUsers,
  })  : friendsList = friendsList ?? <FirebaseUser>[],
        receivedFriendRequests =
            receivedFriendRequests ?? <FirebaseFriendRequest>[],
        sentFriendRequests = sentFriendRequests ?? <FirebaseFriendRequest>[],
        sentToUsers = sentToUsers ?? <FirebaseUser>[],
        receivedFromUsers = receivedFromUsers ?? <FirebaseUser>[],
        super(key: key);

  final List<FirebaseUser> friendsList;
  final List<FirebaseFriendRequest> receivedFriendRequests;
  final List<FirebaseFriendRequest> sentFriendRequests;
  final List<FirebaseUser> sentToUsers;
  final List<FirebaseUser> receivedFromUsers;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FriendsCubit>().initData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (receivedFriendRequests.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 12, 0, 4),
                          child: const Text(
                            'People that want you',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Divider(
                          indent: 12,
                          endIndent: 16,
                          thickness: 2,
                          color: CustomColors.orange,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          itemCount: receivedFriendRequests.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: AcceptRequestField(
                              title:
                                  receivedFromUsers[index].email ?? emptyString,
                              imageUrl: receivedFromUsers[index].imageUrl,
                              onRejectCallback: () {
                                context
                                    .read<FriendsCubit>()
                                    .cancelFriendRequest(
                                        toUser: FirebaseUser(
                                            id: FirebaseAuth
                                                .instance.currentUser?.uid),
                                        fromUser: receivedFromUsers[index]);
                              },
                              onAcceptCallback: () {
                                context
                                    .read<FriendsCubit>()
                                    .acceptFriendRequest(
                                        receivedFriendRequests[index]);
                              },
                            ));
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              indent: 6,
                              endIndent: 6,
                              color: CustomColors.blackOlive,
                              thickness: 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (sentFriendRequests.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 12, 0, 4),
                          child: const Text(
                            'People that you want',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const Divider(
                          indent: 12,
                          endIndent: 16,
                          thickness: 2,
                          color: CustomColors.orange,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          itemCount: sentFriendRequests.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: AcceptRequestField(
                              title: sentToUsers[index].email ?? emptyString,
                              imageUrl: sentToUsers[index].imageUrl,
                              onRejectCallback: () {
                                context
                                    .read<FriendsCubit>()
                                    .cancelFriendRequest(
                                        fromUser: FirebaseUser(
                                            id: FirebaseAuth
                                                .instance.currentUser?.uid),
                                        toUser: sentToUsers[index]);
                              },
                            ));
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              indent: 6,
                              endIndent: 6,
                              color: CustomColors.blackOlive,
                              thickness: 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(12, 12, 0, 4),
                        child: const Text(
                          'Friend list',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      const Divider(
                        indent: 12,
                        endIndent: 16,
                        thickness: 2,
                        color: CustomColors.orange,
                      ),
                      friendsList.isEmpty
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(12, 12, 0, 4),
                              child: const Text(
                                "You're pretty lonely... Go make some friends with the button below!",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              itemCount: friendsList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: FriendField(
                                  email:
                                      friendsList[index].email ?? emptyString,
                                  imageUrl: friendsList[index].imageUrl,
                                  onUnfriendCallback: () {
                                    showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Careful there!'),
                                        content: Text(
                                            'Are you sure you want to unfriend ${friendsList[index].email}?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text(
                                              'Yes. Not my friend anymore',
                                              style: TextStyle(
                                                  color: CustomColors.orange),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text(
                                              'No, I will ponder more',
                                              style: TextStyle(
                                                  color: CustomColors.orange),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).then((confirmUnfriend) {
                                      if (confirmUnfriend == true) {
                                        context
                                            .read<FriendsCubit>()
                                            .removeFriend(friendsList[index]);
                                      }
                                    });
                                  },
                                  onChatNavigationCallback: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage(
                                                  correspondent:
                                                      friendsList[index],
                                                )));
                                  },
                                ));
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  indent: 6,
                                  endIndent: 6,
                                  color: CustomColors.blackOlive,
                                  thickness: 1,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
