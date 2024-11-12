part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventUserName extends LoginEvent {
  final String name;

  const LoginEventUserName(this.name);

  @override
  List<Object> get props => [name];
}

class LoginEventPassword extends LoginEvent {
  final String password;

  const LoginEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class LoginEventSubmit extends LoginEvent {
  const LoginEventSubmit();
}

class LoginEventLogout extends LoginEvent {
  const LoginEventLogout();
}

class LoginEventCheckProfile extends LoginEvent {
  const LoginEventCheckProfile();
}

class SentAccountActivateCodeSubmit extends LoginEvent {
  const SentAccountActivateCodeSubmit();
}

class AccountActivateCodeSubmit extends LoginEvent {
  const AccountActivateCodeSubmit(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class LoginEventShowPassword extends LoginEvent {
  final bool value;

  const LoginEventShowPassword(this.value);

  @override
  List<Object> get props => [value];
}

class LoginEventActive extends LoginEvent {
  final bool value;

  const LoginEventActive(this.value);

  @override
  List<Object> get props => [value];
}
