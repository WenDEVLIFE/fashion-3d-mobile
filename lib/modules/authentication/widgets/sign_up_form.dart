import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/widgets/capitalized_word.dart';
import '/widgets/field_error_text.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../controller/sign_up/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    final appSettingBloc = context.read<AppSettingCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          BlocBuilder<SignUpBloc, SignUpModelState>(
            builder: (context, state) {
              final signUpState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: state.name,
                    onChanged: (value) => bloc.add(SignUpEventName(value)),
                    decoration: InputDecoration(
                        hintText: Language.name.capitalizeByWord()),
                  ),
                  if (signUpState is SignUpStateFormValidateError) ...[
                    if (signUpState.errors.name.isNotEmpty)
                      ErrorText(
                        text: signUpState.errors.name.first,
                        space: 2.0,
                      )
                  ]
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<SignUpBloc, SignUpModelState>(
            builder: (context, state) {
              final signUpState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    initialValue: state.email,
                    onChanged: (value) => bloc.add(SignUpEventEmail(value)),
                    decoration: InputDecoration(
                        hintText: Language.email.capitalizeByWord()),
                  ),
                  if (signUpState is SignUpStateFormValidateError) ...[
                    if (signUpState.errors.email.isNotEmpty)
                      ErrorText(
                        text: signUpState.errors.email.first,
                        space: 2.0,
                      )
                  ]
                ],
              );
            },
          ),
          if (appSettingBloc.settingModel!.setting!.phoneNumberRequired ==
              1) ...[
            const SizedBox(height: 10),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      initialValue: state.phone,
                      onChanged: (value) => bloc.add(SignUpEventPhone(value)),
                      decoration: InputDecoration(
                        hintText: Language.phoneNumber.capitalizeByWord(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: CountryCodePicker(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            onChanged: (country) {
                              bloc.add(
                                SignUpEventCountryCode(
                                    country.dialCode ?? '+880'),
                              );
                              // profileEdBlc
                              //     .changePhoneCode(country.dialCode ?? '');
                            },
                            flagWidth: 30,
                            //showFlagMain: true,
                            initialSelection: 'BD',
                            favorite: const ['+880', 'BD'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                        // hintText: Language.phoneNumber.capitalizeByWord(),
                      ),
                    ),
                    if (s is SignUpStateFormValidateError) ...[
                      if (s.errors.phone.isNotEmpty)
                        ErrorText(
                          text: s.errors.phone.first,
                          space: 2.0,
                        ),
                    ]
                  ],
                );
              },
            ),
          ],
          const SizedBox(height: 10),
          BlocBuilder<SignUpBloc, SignUpModelState>(
            builder: (context, state) {
              final signUpState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    initialValue: state.password,
                    onChanged: (value) => bloc.add(SignUpEventPassword(value)),
                    obscureText: state.showPassword,
                    decoration: InputDecoration(
                      hintText: Language.password.capitalizeByWord(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: blackColor,
                        ),
                        onPressed: () => bloc
                            .add(SignUpEventShowPassword(state.showPassword)),
                      ),
                    ),
                  ),
                  if (signUpState is SignUpStateFormValidateError) ...[
                    if (signUpState.errors.password.isNotEmpty)
                      ErrorText(
                        text: signUpState.errors.password.first,
                        space: 2.0,
                      )
                  ]
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<SignUpBloc, SignUpModelState>(
            builder: (context, state) {
              final signUpState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    initialValue: state.passwordConfirmation,
                    onChanged: (value) =>
                        bloc.add(SignUpEventPasswordConfirm(value)),
                    obscureText: state.showConfirmPassword,
                    decoration: InputDecoration(
                      hintText: Language.confirmPassword.capitalizeByWord(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: blackColor,
                        ),
                        onPressed: () => bloc.add(
                            SignUpEventShowConfirmPassword(
                                state.showConfirmPassword)),
                      ),
                    ),
                  ),
                  if (signUpState is SignUpStateFormValidateError) ...[
                    if (signUpState.errors.password.isNotEmpty)
                      ErrorText(
                        text: signUpState.errors.password.first,
                        space: 2.0,
                      )
                  ]
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          _buildRememberMe(),
          const SizedBox(height: 6),
          BlocBuilder<SignUpBloc, SignUpModelState>(
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              if (state.state is SignUpStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return PrimaryButton(
                text: Language.singUp.capitalizeByWord(),
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  bloc.add(SignUpEventSubmit());
                },
              );
            },
          ),
          // const SizedBox(height: 16),
          // Text(Language.socialLogin.capitalizeByWord(),style: simpleTextStyle(textGreyColor)),
          // const SizedBox(height: 12),
          // const SocialButtons(),
          // const SizedBox(height: 28),
          // const GuestButton(),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return BlocBuilder<SignUpBloc, SignUpModelState>(
      buildWhen: (previous, current) => previous.agree != current.agree,
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0))),
          ),
          child: CheckboxListTile(
            value: state.agree == 1,
            dense: true,
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            activeColor: deepGreenColor,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              Language.signUpCondition.capitalizeByWord(),
              style: TextStyle(color: blackColor.withOpacity(.5)),
            ),
            onChanged: (v) {
              if (v == null) return;
              context.read<SignUpBloc>().add(SignUpEventAgree(v ? 1 : 0));
            },
          ),
        );
      },
    );
  }
}
