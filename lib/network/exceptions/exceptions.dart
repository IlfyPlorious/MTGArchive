import 'package:dio/dio.dart';

class ServerErrorException implements Exception {
  final String? message;
  final int? statusCode;

  ServerErrorException(this.message, this.statusCode);

  String getServerError() {
    switch (statusCode) {
      case 400:
        return 'Bad request. The Server could not process the action.';
      case 403:
        return 'Forbidden. You exceeded the rate limit.';
      case 404:
        return 'The requested resource could not be found.';
      case 500:
        return 'There was a problem with the server. Please try again later';
      case 503:
        return 'The server is temporarily offline for maintenance. Please try again later';
      default:
        return 'Something went wrong. Please try again later.';
    }
  }
}

class ScryfallError implements Exception {
  ScryfallError({
    this.response,
  });

  Response<dynamic>? response;

  String getErrorMessage() {
    switch (response?.statusCode) {
      case 404:
        return 'There are no cards to match your filters. Try other combos.';
      case 400:
        return response?.data['details'] ?? 'Something went wrong with your search query.';
      default:
        return 'Something went wrong while retrieving the cards.';
    }
  }
}

class FirebaseAuthenticationException {
  FirebaseAuthenticationException({required this.code});

  final String code;

  /**
   **invalid-email**:
      Thrown if the email address is not valid.
   **user-disabled**:
      Thrown if the user corresponding to the given email has been disabled.
   **user-not-found**:
      Thrown if there is no user corresponding to the given email.
   **wrong-password**:
      Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
   **/

  String get getLoginError {
    switch (code) {
      case 'invalid-email':
        return 'Email is invalid, planeswalker! Identify yourself!';
      case 'user-disabled':
        return 'What have you done?! Your account is disabled!';
      case 'user-not-found':
        return "It seems I can't remember you... there's no account with this email";
      case 'wrong-password':
        return "Password incorrect! You may try again, but gods forbid I find you are a thief!...";
      default:
        return 'Something went wrong.';
    }
  }

  /**
   * **email-already-in-use**:
      Thrown if there already exists an account with the given email address.
   **invalid-email**:
      Thrown if the email address is not valid.
   **operation-not-allowed**:
      Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
   **weak-password**:
      Thrown if the password is not strong enough.
   */

  String get getRegisterError {
    switch (code) {
      case 'email-already-in-use':
        return 'It seems there is another one like you. That email is in use!';
      case 'invalid-email':
        return 'Please type a valid email. I am not allowed to register invalid ones.';
      case 'operation-not-allowed':
        return 'Hmm... the registration process is not available. I will check with the High Archive.';
      case 'weak-password':
        return 'There are evil people out there. Use a stronger password.\nTry minimum 6 characters.';
      default:
        return 'Something went wrong.';
    }
  }

  /**
   **invalid-email**:
      Thrown if the email used is invalid.
   **email-already-in-use**:
      Thrown if the email is already used by another user.
   **requires-recent-login**:
      Thrown if the user's last sign-in time does not meet the security threshold.
   */

  String get getUpdateEmailError {
    switch (code) {
      case 'invalid-email':
        return 'Email used is invalid.';
      case 'email-already-in-use':
        return 'Email is already used by another user.';
      case 'requires-recent-login':
        return 'Last sign-in time does not meet the security threshold.';
      default:
        return 'Something went wrong.';
    }
  }

  /**
   * **user-mismatch**:
      Thrown if the credential given does not correspond to the user.
   **user-not-found**:
      Thrown if the credential given does not correspond to any existing user.
   **invalid-credential**:
      Thrown if the provider's credential is not valid. This can happen if it has already expired when calling link, or if it used invalid token(s). See the Firebase documentation for your provider, and make sure you pass in the correct parameters to the credential method.
   **invalid-email**:
      Thrown if the email used in a EmailAuthProvider.credential is invalid.
   **wrong-password**:
      Thrown if the password used in a EmailAuthProvider.credential is not correct or when the user associated with the email does not have a password.
   **invalid-verification-code**:
      Thrown if the credential is a PhoneAuthProvider.credential and the verification code of the credential is not valid.
   **invalid-verification-id**:
      Thrown if the credential is a PhoneAuthProvider.credential and the verification ID of the credential is not valid.
   */

  String get getPasswordUpdateError {
    switch (code) {
      case 'user-mismatch':
        return 'Credentials given does not correspond to the user.';
      case 'user-not-found':
        return 'Credential given does not correspond to any existing user.';
      case 'invalid-credential':
        return 'Credential is not valid. This can happen if it has already expired when calling link, or if it used invalid token(s).';
      case 'invalid-email':
        return 'The email used in credential data is invalid.';
      case 'wrong-password':
        return 'The current password introduced is not correct or the user associated with the email does not have a password.';
      default:
        return 'Something went wrong.';
    }
  }
}
