import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/src/auth/auth.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/connection_check.dart';
import '../../../../../dependency_injection/dependency_injection.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterBloc(sl()),
      child: const RegisterViewScreen(),
    );
  }
}

class RegisterViewScreen extends StatelessWidget {
  const RegisterViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, state) {
        if (state is RegisterLoading) {
          AppLoadingOverlay.of(context).show();
        }
        if (state is RegisterSuccess) {
          "Register Successfully".successToast();
          AppLoadingOverlay.of(context).hide();
          NavigationService.pop();
        }
        if (state is RegisterError) {
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
            key: registerBloc.formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  AppAssets.transparentAppIcon,
                  height: context.screenHeight / 5,
                ),
                Text(
                  "Register",
                  style: AppTextStyle.h1Bold.copyWith(fontSize: 20.0),
                ),
                30.yGap,
                AppTextFormField(
                  prefixIcon: const Icon(Icons.person),
                  title: "Full Name",
                  hintText: "Enter full name",
                  controller: registerBloc.fullnameController,
                  onChanged: (value) {
                    registerBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.emptyValidation(),
                ),
                20.yGap,
                AppTextFormField(
                  prefixIcon: const Icon(Icons.email_outlined),
                  title: "Email",
                  hintText: "example@gmail.com",
                  controller: registerBloc.emailController,
                  onChanged: (value) {
                    registerBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.validateEmail(),
                ),
                20.yGap,
                AppTextFormField(
                  prefixIcon: const Icon(Icons.password_outlined),
                  title: "Password",
                  hintText: "xxxxxxx",
                  controller: registerBloc.passwordController,
                  onChanged: (value) {
                    registerBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.validatePassword(),
                ),
                20.yGap,

                AppTextFormField(
                  prefixIcon: const Icon(Icons.password_outlined),
                  title: "Confirm Password",
                  hintText: "xxxxxxx",
                  controller: registerBloc.cPasswordController,
                  onChanged: (value) {
                    registerBloc.formKey.currentState!.validate();
                  },
                  validator: (value) => value!.validateConfirmPassword(
                    registerBloc.passwordController.text,
                  ),
                ),
                30.yGap,
                AppPrimaryButton(
                  buttonText: "Register",
                  onPressed: () async {
                    if (await ConnectionCheck.internet()) {
                      registerBloc.add(const OnRegisterButtonPressed());
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
                      child: Text("Already have an account?"),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                      child: const Text("Login Now."),
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
