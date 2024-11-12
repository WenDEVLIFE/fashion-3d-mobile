import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../models/auth_error_model.dart';
import '../../repository/auth_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpModelState> {
  final AuthRepository repository;

  SignUpBloc(this.repository) : super(const SignUpModelState()) {
    on<SignUpEventName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<SignUpEventEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<SignUpEventPassword>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<SignUpEventPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<SignUpEventCountryCode>((event, emit) {
      emit(state.copyWith(countryCode: event.code));
    });
    on<SignUpEventPasswordConfirm>((event, emit) {
      emit(state.copyWith(passwordConfirmation: event.passwordConfirm));
    });
    on<SignUpEventAgree>((event, emit) {
      emit(state.copyWith(agree: event.agree));
    });

    on<SignUpEventShowPassword>((event, emit) {
      emit(state.copyWith(showPassword: !(event.value)));
    });
    on<SignUpEventShowConfirmPassword>((event, emit) {
      emit(state.copyWith(showConfirmPassword: !(event.value)));
    });
    on<SignUpEventActive>((event, emit) {
      emit(state.copyWith(active: !(event.value)));
    });
    on<SignUpEventSubmit>(_submitForm);
  }

  void _submitForm(
      SignUpEventSubmit event, Emitter<SignUpModelState> emit) async {
    if (state.agree == 0) {
      const stateError =
          SignUpStateFormError('Please agree with privacy policy');
      emit(state.copyWith(state: const SignUpStateInitial()));
      emit(state.copyWith(state: stateError));
      return;
    }
    emit(state.copyWith(state: const SignUpStateLoading()));
    final bodyData = state.toMap();

    final result = await repository.signUp(bodyData);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = SignUpStateFormValidateError(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          final error = SignUpStateLoadedError(failure.message);
          emit(state.copyWith(state: error));
        }
      },
      (user) {
        emit(state.copyWith(state: SignUpStateLoaded(user)));
      },
    );
  }
}
