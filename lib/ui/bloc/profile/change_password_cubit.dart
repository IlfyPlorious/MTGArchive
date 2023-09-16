import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/utils/constants.dart';

part 'change_password_state.dart';

class ChangePasswordPageCubit extends Cubit<ChangePasswordPageState> {
  ChangePasswordPageCubit() : super(ChangePasswordPageState());

  void updateCurrentPassword(String newCurrentPassword) {
    emit(state.copyWith(
        status: Status.initial, currentPassword: newCurrentPassword));
  }

  void updateNewPassword(String newNewPassword) {
    emit(state.copyWith(status: Status.initial, newPassword: newNewPassword));
  }

  void updateConfirmNewPassword(String newConfirmNewPassword) {
    emit(state.copyWith(
        status: Status.initial, confirmNewPassword: newConfirmNewPassword));
  }

  Future<void> changeUserPassword() async {
    emit(state.copyWith(status: Status.loading));

    try {
      User? user = FirebaseAuth.instance.currentUser;
      await checkUserPassword(user).then((value) => {
            user
                ?.updatePassword(state.newPassword)
                .then((value) => {emit(state.copyWith(status: Status.success))})
          });
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      emit(state.copyWith(
          status: Status.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    }
  }

  Future<void> checkUserPassword(User? user) async {
    final credentials = EmailAuthProvider.credential(
        email: user?.email ?? emptyString, password: state.currentPassword);

    await user?.reauthenticateWithCredential(credentials);
  }
}
