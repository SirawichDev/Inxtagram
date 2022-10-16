part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String username;
  final String password;
  final SignupStatus status;
  final Failure failure;

  bool get isFormValid =>
      email.isNotEmpty && password.isNotEmpty && username.isNotEmpty;

  @override
  bool get stringify => true;

  factory SignupState.initial() {
    return const SignupState(
        username: '',
        email: '',
        password: '',
        status: SignupStatus.initial,
        failure: Failure());
  }

  @override
  List<Object> get props => [email, username, password, status, failure];

  const SignupState(
      {required this.username,
      required this.email,
      required this.password,
      required this.status,
      required this.failure});

  SignupState copyWith({
    String? email,
    String? username,
    String? password,
    SignupStatus? status,
    Failure? failure,
  }) {
    return SignupState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
