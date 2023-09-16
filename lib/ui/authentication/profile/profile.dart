import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/authentication/profile/change_password.dart';
import 'package:playground/ui/bloc/profile/profile_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfilePageCubit(), child: const ProfileView());
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

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
        actions: const [
          SizedBox(
            width: 40,
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Your profile',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ProfilePageStatus.initial:
                      return ProfileData(
                        state: state,
                      );
                    case ProfilePageStatus.success:
                      return ProfileData(
                        state: state,
                      );
                    case ProfilePageStatus.loading:
                      return const PageLoading();
                    case ProfilePageStatus.loadingPictureUpload:
                      return ProfileData(
                        state: state,
                        imageLoading: true,
                      );
                    case ProfilePageStatus.failure:
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                                ((state.exception)?.getUpdateEmailError ??
                                    'Something went wrong.')),
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
                        );
                      });
                      return ProfileData(
                        state: state,
                      );
                    default:
                      return const PageLoading();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key, required this.state, this.imageLoading = false})
      : super(key: key);

  final ProfilePageState state;
  final bool imageLoading;

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final emailController = TextEditingController();
  final displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    emailController.text =
        FirebaseAuth.instance.currentUser?.email ?? widget.state.email;
    emailController.addListener(_onEmailChangedListener);

    displayNameController.text =
        FirebaseAuth.instance.currentUser?.displayName ??
            widget.state.displayName;
    displayNameController.addListener(_onDisplayNameChangedListener);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    emailController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  void _onEmailChangedListener() {
    context.read<ProfilePageCubit>().updateEmail(emailController.text);
  }

  void _onDisplayNameChangedListener() {
    context
        .read<ProfilePageCubit>()
        .updateDisplayName(displayNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: GestureDetector(
                onTap: () async {
                  await startImagePickerForResult().then((result) => {
                        if (result == null)
                          {
                            Logger().e('Failed file fetch'),
                          }
                        else
                          {
                            context
                                .read<ProfilePageCubit>()
                                .updateProfilePic(result)
                          }
                      });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                          minWidth: 10, minHeight: 10, maxHeight: 300),
                      child: widget.imageLoading == true
                          ? const PageLoading()
                          : widget.state.user?.photoURL != null
                              // child: widget.state.user?.photoURL != null
                              ? CircleAvatar(
                                  radius: 180,
                                  backgroundImage: const AssetImage(
                                      'assets/images/profile_placeholder_m.png'),
                                  child: CircleAvatar(
                                    radius: 180,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        widget.state.user?.photoURL ??
                                            emptyString),
                                  ),
                                )
                              // widget.state.user?.photoURL ?? emptyString)
                              : Image.asset(
                                  'assets/images/profile_placeholder_m.png'),
                    ),
                    Image.asset('assets/images/profile_frame.png'),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Tap image to change profile picture',
                  style: TextStyle(color: CustomColors.gray, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          EditableField(
            label: 'Name',
            initialValue: widget.state.displayName,
            editable: widget.state.displayNameEditable,
            controller: displayNameController,
            onEditButtonCallback: () {
              if (widget.state.displayNameEditable == true) {
                displayNameController.text =
                    FirebaseAuth.instance.currentUser?.displayName ??
                        emptyString;
              }
              context.read<ProfilePageCubit>().updateDisplayNameEditable(
                  displayNameEditable: !widget.state.displayNameEditable);
            },
          ),
          EditableField(
            label: 'Email',
            initialValue: widget.state.email,
            editable: widget.state.emailEditable,
            controller: emailController,
            onEditButtonCallback: () {
              if (widget.state.emailEditable == true) {
                emailController.text =
                    FirebaseAuth.instance.currentUser?.email ?? emptyString;
              }
              context.read<ProfilePageCubit>().updateEmailEditable(
                  emailEditable: !widget.state.emailEditable);
            },
          ),
          RedirectField(
              label: 'Password',
              onRedirectButtonCallback: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage()),
                );
              },
              redirectLabel: 'Change password'),
          const SizedBox(
            height: 20,
          ),
          if (widget.state.anyChanges)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (widget.state.displayNameEditable) {
                        context
                            .read<ProfilePageCubit>()
                            .updateFirebaseUserDisplayName();
                      }
                      if (widget.state.emailEditable) {
                        context
                            .read<ProfilePageCubit>()
                            .updateFirebaseUserEmail();
                      }
                    },
                    child: const Text('Apply changes')),
                ElevatedButton(
                    onPressed: () {
                      emailController.text =
                          FirebaseAuth.instance.currentUser?.email ??
                              widget.state.email;
                      displayNameController.text =
                          FirebaseAuth.instance.currentUser?.displayName ??
                              widget.state.displayName;
                      context.read<ProfilePageCubit>().revertAllChanges();
                    },
                    child: const Text('Revert all')),
              ],
            )
        ],
      ),
    );
  }

  Future<File?> startImagePickerForResult() async {
    try {
      final filePath = await getFileAbsolutePath();

      if (filePath == null) throw Exception('Illegal path');

      return File(filePath);
    } on Exception catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<String?> getFileAbsolutePath() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image?.path;
  }
}
