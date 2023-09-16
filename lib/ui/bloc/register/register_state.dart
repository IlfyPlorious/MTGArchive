part of 'register_cubit.dart';

class RegisterPageState extends Equatable {
  const RegisterPageState(
      {this.status = Status.initial,
        this.email = emptyString,
        this.exception,
        this.password = emptyString});

  final Status status;
  final String email;
  final String password;
  final FirebaseAuthenticationException? exception;

  RegisterPageState copyWith(
      {Status? status, String? email, String? password, FirebaseAuthenticationException? exception}) {
    return RegisterPageState(
        status: status ?? this.status,
        email: email ?? this.email,
        exception: exception,
        password: password ?? this.password);
  }

  @override
  List<Object> get props => [status, email, password];
}
