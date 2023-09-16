import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/utils/constants.dart';

part 'register_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit()
      : _firestoreRepository = GetIt.instance<FirestoreServiceRepository>(
            instanceName: 'FirestoreRepository'),
        super(const RegisterPageState());

  final FirestoreServiceRepository _firestoreRepository;

  Future<void> registerWithEmailAndPassword() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      final user = FirebaseAuth.instance.currentUser;
      await _firestoreRepository.addUser(user);
      emit(state.copyWith(status: Status.success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      }
      emit(state.copyWith(
          status: Status.failure,
          exception: FirebaseAuthenticationException(code: e.code)));
    } on Exception catch (err) {
      Logger().e(err.toString());
    }
  }

  void updateFields({String? email, String? password}) {
    emit(state.copyWith(
        email: email, password: password, status: Status.loading));
  }
}
