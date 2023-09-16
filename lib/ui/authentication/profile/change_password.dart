import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/colors.dart';
import 'package:playground/ui/bloc/profile/change_password_cubit.dart';
import 'package:playground/ui/cards_page.dart';
import 'package:playground/ui/partitions/fields/fields.dart';
import 'package:playground/utils/constants.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChangePasswordPageCubit(),
        child: const ChangePasswordView());
  }
}

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

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
              'Change password',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ChangePasswordPageCubit, ChangePasswordPageState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return ChangePasswordData(
                        state: state,
                      );
                    case Status.success:
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Password change completed"),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            textColor: CustomColors.orange,
                            label: 'OK',
                            onPressed: () {},
                          ),
                        ));
                        Navigator.pop(context);
                      });
                      return ChangePasswordData(
                        state: state,
                      );
                    case Status.loading:
                      return Container(
                        constraints: const BoxConstraints(maxHeight: 500),
                        child: const PageLoading(),
                      );
                    case Status.failure:
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                                ((state.exception)?.getPasswordUpdateError ??
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
                      return ChangePasswordData(
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

class ChangePasswordData extends StatefulWidget {
  const ChangePasswordData({Key? key, required this.state}) : super(key: key);

  final ChangePasswordPageState state;

  @override
  State<ChangePasswordData> createState() => _ChangePasswordDataState();
}

class _ChangePasswordDataState extends State<ChangePasswordData> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    currentPasswordController.addListener(_onCurrentPasswordTextChanged);
    newPasswordController.addListener(_onNewPasswordTextChanged);
    confirmNewPasswordController.addListener(_onConfirmNewPasswordTextChanged);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            child: TogglePasswordField(
              controller: currentPasswordController,
              isVisible: false,
              hint: 'Current password',
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: TogglePasswordField(
              controller: newPasswordController,
              isVisible: false,
              hint: 'New password',
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: TogglePasswordField(
              controller: confirmNewPasswordController,
              isVisible: false,
              hint: 'Confirm new password',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.state.confirmPasswordValid) {
                  context.read<ChangePasswordPageCubit>().changeUserPassword();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                        "Confirm password doesn't match new password"),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      textColor: CustomColors.orange,
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ));
                }
              },
              child: const Text('Confirm'))
        ],
      ),
    );
  }

  void _onCurrentPasswordTextChanged() {
    context
        .read<ChangePasswordPageCubit>()
        .updateCurrentPassword(currentPasswordController.text);
  }

  void _onNewPasswordTextChanged() {
    context
        .read<ChangePasswordPageCubit>()
        .updateNewPassword(newPasswordController.text);
  }

  void _onConfirmNewPasswordTextChanged() {
    context
        .read<ChangePasswordPageCubit>()
        .updateConfirmNewPassword(confirmNewPasswordController.text);
  }
}
