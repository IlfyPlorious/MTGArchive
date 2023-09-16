part of 'login_cubit.dart';

class LoginPageState extends Equatable {
  const LoginPageState(
      {this.status = Status.initial,
      this.email = emptyString,
      this.attempts = 0,
      this.exception,
      this.password = emptyString});

  final Status status;
  final String email;
  final String password;
  final FirebaseAuthenticationException? exception;

  final int attempts;

  LoginPageState copyWith(
      {Status? status,
      String? email,
      String? password,
        int? attempts,
      FirebaseAuthenticationException? exception}) {
    return LoginPageState(
        status: status ?? this.status,
        email: email ?? this.email,
        exception: exception,
        attempts: attempts ?? this.attempts,
        password: password ?? this.password);
  }

  @override
  List<Object> get props => [status, email, password, attempts];
}
