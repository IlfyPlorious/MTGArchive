import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/utils/constants.dart';

part 'profile_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(ProfilePageState());

  Future<void> updateProfilePic(File file) async {
    emit(state.copyWith(status: ProfilePageStatus.loadingPictureUpload));

    try {
      final storageRef = FirebaseStorage.instance.ref();
      final profilePicRef =
          storageRef.child("images/profile/${state.user?.uid}/profile.jpg");

      await profilePicRef.putFile(file);
      profilePicRef.getDownloadURL().then((url) async => {
            state.user?.updatePhotoURL(url).then((_) =>
                {emit(state.copyWith(status: ProfilePageStatus.success))})
          });
    } on Exception catch (e) {
      emit(state.copyWith(
          status: ProfilePageStatus.failure,
          exception: FirebaseAuthenticationException(code: e.toString())));
      Logger().e(e.toString());
    }
  }

  Future<void> updateFirebaseUserDisplayName() async {
    emit(state.copyWith(status: ProfilePageStatus.loading));
    try {
      await state.user?.updateDisplayName(state.displayName);
      emit(state.copyWith(
          status: ProfilePageStatus.success, displayNameEditable: false));
    } on Exception catch (e) {
      Logger().e(e);
      emit(state.copyWith(
          status: ProfilePageStatus.failure,
          exception: FirebaseAuthenticationException(code: e.toString())));
    }
  }

  Future<void> updateFirebaseUserEmail() async {
    emit(state.copyWith(status: ProfilePageStatus.loading));
    try {
      await state.user?.updateEmail(state.email);
      emit(state.copyWith(
          status: ProfilePageStatus.success, emailEditable: false));
    } on FirebaseAuthException catch (e) {
      Logger().e(e.runtimeType);
      emit(state.copyWith(
          status: ProfilePageStatus.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    }
  }

  Future<void> updateFirebaseUserPhoneNumber() async {
    emit(state.copyWith(status: ProfilePageStatus.loading));
    try {
      //todo implement phone number authentication eventually
      // final phoneAuthCredentials = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      // await state.user?.updatePhoneNumber(phoneAuthCredentials);
      emit(state.copyWith(
          status: ProfilePageStatus.success, emailEditable: false));
    } on FirebaseAuthException catch (e) {
      Logger().e(e.runtimeType);
      emit(state.copyWith(
          status: ProfilePageStatus.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    }
  }

  void updateDisplayNameEditable({bool? displayNameEditable}) {
    if (displayNameEditable == false) {
      emit(state.copyWith(
          displayNameEditable: displayNameEditable,
          displayName: state.user?.displayName ?? emptyString));
    } else {
      emit(state.copyWith(displayNameEditable: displayNameEditable));
    }
  }

  void updateEmailEditable({bool? emailEditable}) {
    if (emailEditable == false) {
      emit(state.copyWith(
          emailEditable: emailEditable,
          email: state.user?.email ?? emptyString));
    } else {
      emit(state.copyWith(emailEditable: emailEditable));
    }
  }

  void updatePhoneNumberEditable({bool? phoneNumberEditable}) {
    if (phoneNumberEditable == false) {
      emit(state.copyWith(
          phoneNumberEditable: phoneNumberEditable,
          phoneNumber: state.user?.phoneNumber ?? emptyString));
    } else {
      emit(state.copyWith(phoneNumberEditable: phoneNumberEditable));
    }
  }

  void updateDisplayName(String updatedName) {
    emit(state.copyWith(displayName: updatedName));
  }

  void updateEmail(String updatedEmail) {
    emit(state.copyWith(email: updatedEmail));
  }

  void updatePhoneNumber(String updatedPhoneNumber) {
    emit(state.copyWith(email: updatedPhoneNumber));
  }

  void revertAllChanges() {
    emit(state.copyWith(
      emailEditable: false,
      email: state.user?.email ?? emptyString,
      displayNameEditable: false,
      displayName: state.user?.displayName ?? emptyString,
      phoneNumberEditable: false,
      phoneNumber: state.user?.phoneNumber ?? emptyString,
    ));
  }
}
