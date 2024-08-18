import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/auth/auth.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/connection_check.dart';
import '../../../../../dependency_injection/dependency_injection.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(sl()),
      child: const LoginViewScreen(),
    );
  }
}

class LoginViewScreen extends StatelessWidget {
  const LoginViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if (state is LoginLoading) {
          AppLoadingOverlay.of(context).show();
        }
        if (state is LoginSuccess) {
          "Login Successfully".successToast();
          AppLoadingOverlay.of(context).hide();
          NavigationService.pushNamed(AppRoutes.indexScreen);
        }
        if (state is LoginError) {
          state.message.errorToast();
          AppLoadingOverlay.of(context).hide();
        }
      },
      child: PageWrapper(
        canPop: false,
        extraPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "News Connect",
            style: AppTextStyle.hintStyle,
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Form(
            key: loginBloc.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  AppAssets.transparentAppIcon,
                  height: context.screenHeight / 5,
                ),
                Text(
                  "Login",
                  style: AppTextStyle.h1Bold.copyWith(fontSize: 20.0),
                ),
                30.yGap,
                AppTextFormField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  title: "Email",
                  hintText: "example@gmail.com",
                  controller: loginBloc.emailController,
                  onChanged: (value) {
                    loginBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.validateEmail(),
                ),
                20.yGap,
                AppTextFormField(
                  prefixIcon: const Icon(Icons.password_outlined),
                  title: "Password",
                  hintText: "xxxxxxx",
                  controller: loginBloc.passwordController,
                  onChanged: (value) {
                    loginBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.validatePassword(),
                ),
                30.yGap,
                AppPrimaryButton(
                  buttonText: "LOGIN",
                  onPressed: () async {
                    if (await ConnectionCheck.internet()) {
                      loginBloc.add(const OnLoginButtonPressed());
                    } else {
                      "No internet connection".errorToast();
                    }
                  },
                ),

                ///
                10.yGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextButton(
                      onPressed: null,
                      child: Text("Don't have an account?"),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.pushNamed(AppRoutes.registerScreen);
                      },
                      child: const Text("Register Now."),
                    ),
                  ],
                ),

                ///
                60.yGap,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
