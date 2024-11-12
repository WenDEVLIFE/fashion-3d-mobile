import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../utils/utils.dart';
import '../../../authentication/models/auth_error_model.dart';
import '../../model/contact_us_mesage_model.dart';
import '../repository/setting_repository.dart';

part 'contact_us_form_event.dart';
part 'contact_us_form_state.dart';

class ContactUsFormBloc extends Bloc<ContactUsFormEvent, ContactUsFormState> {
  final SettingRepository settingRepository;

  ContactUsFormBloc(this.settingRepository)
      : super(const ContactUsFormState()) {
    on<ContactUsFormNameChange>(_nameChange);
    on<ContactUsFormEmailChange>((event, emit) {
      emit(state.copyWith(
          email: event.email, status: const ContactUsFormStatusInitial()));
    });
    on<ContactUsFormPhoneChange>((event, emit) {
      emit(state.copyWith(
          phone: event.phone, status: const ContactUsFormStatusInitial()));
    });
    on<ContactUsFormSubjectChange>((event, emit) {
      emit(state.copyWith(
          subject: event.subject, status: const ContactUsFormStatusInitial()));
    });
    on<ContactUsFormMessageChange>((event, emit) {
      emit(state.copyWith(
          message: event.message, status: const ContactUsFormStatusInitial()));
    });
    on<ContactUsFormSubmit>(_formSubmitChange);
  }

  void _nameChange(
      ContactUsFormNameChange event, Emitter<ContactUsFormState> emit) {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _formSubmitChange(
    ContactUsFormSubmit event,
    Emitter<ContactUsFormState> emit,
  ) async {
    emit(state.copyWith(status: const ContactLoading()));
    final messageModel = ContactUsMessageModel.fromMap(state.toMap());

    final result =
        await settingRepository.getContactUsMessageSend(messageModel);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              status: ContactUsFormValidateError(failure.errors)));
        } else {
          emit(
            state.copyWith(
              status: ContactUsFormStatusError(failure.message),
            ),
          );
        }
      },
      (success) {
        emit(
          state.copyWith(
              name: '',
              email: '',
              subject: '',
              phone: '',
              message: '',
              status: const ContactUsFormStatusLoaded("Thank you")),
        );
        emit(state.clear());
      },
    );
  }
}
