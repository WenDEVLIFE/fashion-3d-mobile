import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/widgets/capitalized_word.dart';
import '/widgets/field_error_text.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controller/login/login_bloc.dart';
import 'guest_button.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          BlocBuilder<LoginBloc, LoginModelState>(
            //buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              final loginState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    initialValue: state.email,
                    onChanged: (value) =>
                        loginBloc.add(LoginEventUserName(value)),
                    decoration: InputDecoration(
                      hintText: Language.usernameOrEmail.capitalizeByWord(),
                    ),
                  ),
                  if (loginState is LoginStateFormError) ...[
                    if (loginState.errors.email.isNotEmpty)
                      ErrorText(text: loginState.errors.email.first)
                  ]
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<LoginBloc, LoginModelState>(
            builder: (context, state) {
              final loginState = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    initialValue: state.password,
                    onChanged: (value) =>
                        loginBloc.add(LoginEventPassword(value)),
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
                        onPressed: () => loginBloc
                            .add(LoginEventShowPassword(state.showPassword)),
                      ),
                    ),
                  ),
                  if (loginState is LoginStateFormError) ...[
                    if (loginState.errors.password.isNotEmpty)
                      ErrorText(text: loginState.errors.password.first)
                  ]
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          _rememberMe(),
          const SizedBox(height: 20),
          BlocBuilder<LoginBloc, LoginModelState>(
            buildWhen: (previous, current) => previous.state != current.state,
            builder: (context, state) {
              if (state.state is LoginStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return PrimaryButton(
                text: Language.login.capitalizeByWord(),
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  loginBloc.add(const LoginEventSubmit());
                },
              );
            },
          ),
          const SizedBox(height: 16),
          //  Text(
          //    Language.socialLogin.capitalizeByWord(),
          //   style: simpleTextStyle(textGreyColor),
          // ),
          // const SizedBox(height: 12),
          // const SocialButtons(),
          // const SizedBox(height: 28),
          const GuestButton(),
        ],
      ),
    );
  }

  Widget _rememberMe() {
    final loginBloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginModelState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(110.0)))),
                  child: Checkbox(
                      value: state.active,
                      onChanged: (bool? v) {
                        if (v == null) return;
                        loginBloc.add(LoginEventActive(state.active));
                      }),
                ),
                const SizedBox(width: 10.0),
                Text(
                  Language.rememberMe.capitalizeByWord(),
                  style: TextStyle(color: blackColor.withOpacity(.5)),
                ),
              ],
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.forgotScreen),
              child: Text(
                '${Language.forgotPassword.capitalizeByWord()}?',
                style: simpleTextStyle(redColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
