part of 'change_password_cubit.dart';

class ChangePasswordPageState extends Equatable {
  ChangePasswordPageState(
      {this.status = Status.initial,
      User? user,
      this.exception,
      String? currentPassword,
      String? newPassword,
      String? confirmNewPassword})
      : user = user ?? FirebaseAuth.instance.currentUser,
        currentPassword = currentPassword ?? emptyString,
        newPassword = newPassword ?? emptyString,
        confirmNewPassword = confirmNewPassword ?? emptyString;

  final Status status;
  final User? user;
  final FirebaseAuthenticationException? exception;

  // UI data
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  bool get confirmPasswordValid => newPassword == confirmNewPassword;

  ChangePasswordPageState copyWith({
    Status? status,
    User? user,
    FirebaseAuthenticationException? exception,
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return ChangePasswordPageState(
      status: status ?? this.status,
      user: user ?? this.user,
      currentPassword: currentPassword?.isEmpty == true
          ? this.currentPassword
          : currentPassword ?? this.currentPassword,
      newPassword: newPassword?.isEmpty == true
          ? this.newPassword
          : newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword?.isEmpty == true
          ? this.confirmNewPassword
          : confirmNewPassword ?? this.confirmNewPassword,
      exception: exception,
    );
  }

  @override
  List<Object?> get props =>
      [status, currentPassword, newPassword, confirmNewPassword];
}
