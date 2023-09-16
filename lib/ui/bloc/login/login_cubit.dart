import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/utils/constants.dart';

part 'login_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit()
      : _firestoreRepository = GetIt.instance<FirestoreServiceRepository>(
            instanceName: 'FirestoreRepository'),
        super(const LoginPageState());
  final FirestoreServiceRepository _firestoreRepository;

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      await _firestoreRepository.addUser(user);

      emit(state.copyWith(status: Status.success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
        emit(state.copyWith(
            status: Status.failure,
            exception: FirebaseAuthenticationException(code: e.code),
            attempts: 0));
        return;
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            status: Status.failure,
            exception: FirebaseAuthenticationException(code: e.code),
            attempts: state.attempts + 1));
        Logger().e('Wrong password provided for that user.');
        return;
      }
      emit(state.copyWith(
          status: Status.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    } on Exception catch (e) {
      Logger().e(e.toString());
      emit(state.copyWith(
          status: Status.failure,
          exception:
              FirebaseAuthenticationException(code: 'something went wrong')));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.email, password: state.password);

      emit(state.copyWith(status: Status.success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
        emit(state.copyWith(
            status: Status.failure,
            exception: FirebaseAuthenticationException(code: e.code),
            attempts: 0));
        return;
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
        emit(state.copyWith(
            status: Status.failure,
            exception: FirebaseAuthenticationException(code: e.code),
            attempts: state.attempts + 1));
        return;
      }

      emit(state.copyWith(
          status: Status.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    }
  }

  void updateFields({String? email, String? password}) {
    emit(state.copyWith(email: email, password: password));
  }

  Future<void> sendResetEmail(String email) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(state.copyWith(status: Status.success, attempts: -1));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: Status.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    }
  }
}
