import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failure.dart';
import '../../models/auth_error_model.dart';
import '../../models/set_password_model.dart';
import '../../repository/auth_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository repository;

  final emailController = TextEditingController();
  final paswordController = TextEditingController();
  final paswordConfirmController = TextEditingController();
  final codeController = TextEditingController();

  ForgotPasswordCubit(this.repository)
      : super(const ForgotPasswordStateInitial());

  Future<void> forgotPassWord() async {
    emit(const ForgotPasswordStateLoading());

    final body = {"email": emailController.text.trim()};

    final result = await repository.sendForgotPassCode(body);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(ForgotPasswordFormValidate(failure.errors));
        } else {
          emit(ForgotPasswordStateError(failure.message, failure.statusCode));
        }
      },
      (data) {
        emit(ForgotPasswordStateLoaded(data));
      },
    );
  }

  Future<void> setNewPassword() async {
    emit(const ForgotPasswordStateLoading());

    final model = SetPasswordModel(
      code: codeController.text,
      email: emailController.text.trim(),
      password: paswordController.text,
      passwordConfirmation: paswordController.text,
    );

    final result = await repository.setPassword(model);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(ForgotPasswordFormValidate(failure.errors));
        }
        emit(ForgotPasswordStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(PasswordSetStateLoaded(data));
      },
    );
  }
}
