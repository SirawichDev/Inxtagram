part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final Failure failure;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;
  @override
  bool get stringify => true;

  factory LoginState.initial() {
    return const LoginState(
        email: '',
        password: '',
        status: LoginStatus.initial,
        failure: Failure());
  }

  @override
  List<Object> get props => [email, password, status, failure];

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
