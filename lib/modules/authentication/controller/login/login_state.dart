part of 'login_bloc.dart';

class LoginModelState extends Equatable {
  final String email;
  final String password;
  final bool showPassword;
  final bool active;
  final LoginState state;

  const LoginModelState({
    /*   this.email = 'hijigov511@pahed.com',
    this.password = '1234',*/
    this.email = 'user@gmail.com',
    this.password = '1234',
    this.showPassword = true,
    this.active = false,
    this.state = const LoginStateInitial(),
  });

  LoginModelState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    bool? active,
    LoginState? state,
  }) {
    return LoginModelState(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      active: active ?? this.active,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email.trim()});
    result.addAll({'password': password});
    // result.addAll({'state': state});

    return result;
  }

  factory LoginModelState.fromMap(Map<String, dynamic> map) {
    return LoginModelState(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModelState.fromJson(String source) =>
      LoginModelState.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(username: $email, password: $password, state: $state)';

  @override
  List<Object> get props => [email, password, state, showPassword, active];
}

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class LoginStateLogOutLoading extends LoginState {
  const LoginStateLogOutLoading();
}

class LoginStateLoaded extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateUpdatedProfile extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateUpdatedProfile(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class LoginStateFormError extends LoginState {
  final Errors errors;

  const LoginStateFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class LoginStateSignOutError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateSignOutError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class AccountActivateSuccess extends LoginState {
  final String msg;

  const AccountActivateSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class SendAccountCodeSuccess extends LoginState {
  final String msg;

  const SendAccountCodeSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class LoginStateLogOut extends LoginState {
  final String msg;
  final int statusCode;

  const LoginStateLogOut(this.msg, this.statusCode);

  @override
  List<Object> get props => [msg, statusCode];
}
