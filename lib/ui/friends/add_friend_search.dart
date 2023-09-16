import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/ui/bloc/friends/add_friends_dialog_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/utils/constants.dart';

class FriendSearch extends StatelessWidget {
  const FriendSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFriendsDialogCubit()..initData(),
      child: const FriendSearchView(),
    );
  }
}

class FriendSearchView extends StatelessWidget {
  const FriendSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendsDialogCubit, AddFriendsDialogState>(
        builder: (context, state) {
      switch (state.status) {
        case Status.initial:
          return const Expanded(child: PageLoading());
        case Status.success:
          return FriendSearchData(
            users: state.getDisplayedUsers(),
            onFocus: state.onFocus,
          );
        case Status.loading:
          return FriendSearchData(
            users: state.getDisplayedUsers(),
            onFocus: state.onFocus,
            isLoading: true,
          );
        case Status.failure:
          return Center(
            child: Text(state.exception.toString()),
          );
      }
    });
  }
}

// ignore: must_be_immutable
class FriendSearchData extends StatefulWidget {
  const FriendSearchData(
      {Key? key, required this.users, bool? onFocus, this.isLoading = false})
      : onFocus = onFocus ?? false,
        super(key: key);

  final Map<FirebaseUser, FriendStatus> users;
  final bool onFocus;
  final bool isLoading;

  @override
  State<FriendSearchData> createState() => _FriendSearchDataState();
}

class _FriendSearchDataState extends State<FriendSearchData> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchField(
          onFocus: widget.onFocus,
          controller: searchController,
          hint: 'Search user',
          onQuerySubmittedCallback: (query) {
            context.read<AddFriendsDialogCubit>().updateQuery(query);
            context.read<AddFriendsDialogCubit>().changeFocus(false);
          },
          onTextChangedCallback: (query) {
            context.read<AddFriendsDialogCubit>().updateQuery(query);
            context.read<AddFriendsDialogCubit>().changeFocus(true);
          },
          onActionButtonCallback: () {
            if (widget.onFocus == true) {
              context.read<AddFriendsDialogCubit>().updateQuery(emptyString);
              context.read<AddFriendsDialogCubit>().changeFocus(false);
              searchController.text = emptyString;
            }
          },
        ),
        SizedBox(
          height: 175,
          width: 500,
          child: widget.isLoading
              ? const PageLoading()
              : ListView.builder(
                  itemCount: widget.users.length,
                  itemBuilder: (listContext, index) {
                    final users = widget.users.keys.toList();
                    return ListTile(
                      title: Text(users[index].email ?? emptyString),
                      trailing: IconButton(
                        onPressed:
                            widget.users[users[index]] == FriendStatus.friend ||
                                    widget.users[users[index]] ==
                                        FriendStatus.incoming
                                ? null
                                : () {
                                    setState(() {
                                      SnackBar snackBar;

                                      if (widget.users[users[index]] ==
                                          FriendStatus.pending) {
                                        context
                                            .read<AddFriendsDialogCubit>()
                                            .cancelFriendRequest(
                                                toUser: users[index]);
                                        snackBar = SnackBar(
                                          duration: const Duration(seconds: 1),
                                          content: Text(
                                              'Removed friend request for ${users[index].email}'),
                                        );
                                        ScaffoldMessenger.of(listContext)
                                            .showSnackBar(snackBar);
                                      } else {
                                        context
                                            .read<AddFriendsDialogCubit>()
                                            .sendFriendRequest(
                                                toUser: users[index]);
                                        snackBar = SnackBar(
                                          duration: const Duration(seconds: 1),
                                          content: Text(
                                              'Sent friend request to ${users[index].email}'),
                                        );
                                        ScaffoldMessenger.of(listContext)
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  },
                        icon: widget.users[users[index]] == FriendStatus.friend
                            ? const Icon(
                                Icons.handshake_outlined,
                                color: CustomColors.orange,
                              )
                            : widget.users[users[index]] == FriendStatus.pending
                                ? const Icon(
                                    Icons.cancel_presentation_rounded,
                                    color: CustomColors.errorRed,
                                  )
                                : widget.users[users[index]] ==
                                        FriendStatus.incoming
                                    ? const Icon(
                                        Icons.inbox,
                                        color: CustomColors.green,
                                      )
                                    : const Icon(
                                        Icons.add,
                                        color: CustomColors.blackOlive,
                                      ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
