import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/field_error_text.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/contact_us_form_bloc/contact_us_form_bloc.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactUsFormBloc, ContactUsFormState>(
      listener: (context, state) {
        if (state.status is ContactUsFormStatusError) {
          final status = state.status as ContactUsFormStatusError;
          Utils.errorSnackBar(context, status.errorMessage);
        } else if (state.status is ContactUsFormStatusLoaded) {
          final status = state.status as ContactUsFormStatusLoaded;
          Utils.showSnackBar(context, status.message);
        }
      },
      child: const _FormWidget(),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final contactUsFormBloc = context.read<ContactUsFormBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Language.sendUsMessage.capitalizeByWord(),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
        ),
        const SizedBox(height: 8),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            // buildWhen: (previous, current) => previous.name != current.name,
            builder: (context, state) {
          final contact = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormNameChange(value)),
                decoration: InputDecoration(
                  hintText: Language.name.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (contact is ContactUsFormValidateError) ...[
                if (contact.errors.name.isNotEmpty)
                  ErrorText(text: contact.errors.name.first)
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            builder: (context, state) {
          final contact = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: state.email,
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormEmailChange(value)),
                decoration: InputDecoration(
                  hintText: Language.emailAddress.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (contact is ContactUsFormValidateError) ...[
                if (contact.errors.email.isNotEmpty)
                  ErrorText(text: contact.errors.email.first)
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            builder: (context, state) {
          return TextFormField(
            keyboardType: TextInputType.phone,
            initialValue: state.phone,
            onChanged: (value) =>
                contactUsFormBloc.add(ContactUsFormPhoneChange(value)),
            decoration: InputDecoration(
              hintText: Language.phoneNumber.capitalizeByWord(),
              fillColor: borderColor.withOpacity(.10),
            ),
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            builder: (context, state) {
          final contact = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormSubjectChange(value)),
                decoration: InputDecoration(
                  hintText: Language.subject.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (contact is ContactUsFormValidateError) ...[
                if (contact.errors.subject.isNotEmpty)
                  ErrorText(text: contact.errors.subject.first)
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            builder: (context, state) {
          final contact = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormMessageChange(value)),
                decoration: InputDecoration(
                  hintText: Language.message.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
                minLines: 5,
                maxLines: null,
              ),
              if (contact is ContactUsFormValidateError) ...[
                if (contact.errors.message.isNotEmpty)
                  ErrorText(text: contact.errors.message.first)
              ]
            ],
          );
        }),
        const SizedBox(height: 20),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
          builder: (context, state) {
            return state.status is ContactLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    text: Language.sendNow.capitalizeByWord(),
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      contactUsFormBloc.add(const ContactUsFormSubmit());
                    },
                  );
          },
        )
      ],
    );
  }
}
