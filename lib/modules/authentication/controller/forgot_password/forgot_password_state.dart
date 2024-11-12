part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStateInitial extends ForgotPasswordState {
  const ForgotPasswordStateInitial();
}

class ForgotPasswordStateLoading extends ForgotPasswordState {
  const ForgotPasswordStateLoading();
}

class ForgotPasswordStateError extends ForgotPasswordState {
  const ForgotPasswordStateError(this.errorMsg, this.statusCode);

  final String errorMsg;
  final int statusCode;

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class ForgotPasswordStateLoaded extends ForgotPasswordState {
  const ForgotPasswordStateLoaded(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordSetStateLoaded extends ForgotPasswordState {
  const PasswordSetStateLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ForgotPasswordFormValidate extends ForgotPasswordState {
  const ForgotPasswordFormValidate(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}
