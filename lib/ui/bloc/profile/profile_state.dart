part of 'profile_cubit.dart';

enum ProfilePageStatus { initial, loading, loadingPictureUpload, success, failure }

extension ProfilePageStatusX on ProfilePageStatus {
  bool get isInitial => this == ProfilePageStatus.initial;

  bool get isLoadingPicture => this == ProfilePageStatus.loadingPictureUpload;

  bool get isLoading => this == ProfilePageStatus.loading;

  bool get isSuccess => this == ProfilePageStatus.success;

  bool get isFailure => this == ProfilePageStatus.failure;
}

class ProfilePageState extends Equatable {
  ProfilePageState({
    this.status = ProfilePageStatus.initial,
    User? user,
    this.exception,
    String? displayName,
    String? email,
    String? phoneNumber,
    this.displayNameEditable = false,
    this.emailEditable = false,
    this.phoneNumberEditable = false,
  })
      : user = user ?? FirebaseAuth.instance.currentUser,
        displayName = displayName?.isEmpty == true
            ? FirebaseAuth.instance.currentUser?.displayName ?? emptyString
            : displayName ?? emptyString,
        email = email?.isEmpty == true
            ? FirebaseAuth.instance.currentUser?.email ?? emptyString
            : email ?? emptyString,
        phoneNumber = phoneNumber?.isEmpty == true
            ? FirebaseAuth.instance.currentUser?.phoneNumber ?? emptyString
            : phoneNumber ?? emptyString;

  final ProfilePageStatus status;
  final User? user;
  final FirebaseAuthenticationException? exception;

  // UI data
  final String displayName;
  final String email;
  final String phoneNumber;

  // UI state handling
  final bool displayNameEditable;
  final bool emailEditable;
  final bool phoneNumberEditable;

  get anyChanges => displayNameEditable || emailEditable;

  ProfilePageState copyWith({ProfilePageStatus? status,
    User? user,
    FirebaseAuthenticationException? exception,
    String? displayName,
    String? email,
    String? phoneNumber,
    bool? displayNameEditable,
    bool? emailEditable,
    bool? phoneNumberEditable}) {
    return ProfilePageState(
      status: status ?? this.status,
      user: user ?? this.user,
      displayName:
      displayName?.isNotEmpty == true ? displayName : this.displayName,
      email: email?.isNotEmpty == true ? email : this.email,
      phoneNumber:
      phoneNumber?.isNotEmpty == true ? phoneNumber : this.phoneNumber,
      displayNameEditable: displayNameEditable ?? this.displayNameEditable,
      emailEditable: emailEditable ?? this.emailEditable,
      phoneNumberEditable: phoneNumberEditable ?? this.phoneNumberEditable,
      exception: exception,
    );
  }

  @override
  List<Object> get props =>
      [
        status,
        displayName,
        email,
        phoneNumber,
        displayNameEditable,
        emailEditable,
        phoneNumberEditable
      ];
}
