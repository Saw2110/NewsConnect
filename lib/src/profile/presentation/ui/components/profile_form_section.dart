import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';
import 'package:news_connect/core/utils/connection_check.dart';
import 'package:news_connect/src/profile/profile.dart';

import '../../../../../app/app.dart';

class UserProfileForm extends StatelessWidget {
  final UserModel user;

  UserProfileForm({super.key, required this.user});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextFormField(
                initialValue: user.email,
                title: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.validateEmail(),
                onSaved: (value) {
                  user.email = value!;
                },
              ),
              10.yGap,
              AppTextFormField(
                initialValue: user.fullName,
                title: 'Full Name',
                validator: (value) => value!.emptyValidation(),
                onSaved: (value) {
                  user.fullName = value!;
                },
              ),
              10.yGap,
              AppTextFormField(
                initialValue: user.contactNo,
                title: 'Contact Number',
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  user.contactNo = value!;
                },
              ),
              10.yGap,
              Text("Gender", style: AppTextStyle.labelStyle),
              8.yGap,
              DropdownButtonFormField<String>(
                value: user.gender,
                items: const ["Male", "Female", "Other"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  user.gender = value!;
                },
              ),
              10.yGap,
              AppTextFormField(
                initialValue: user.bio,
                title: 'Bio',
                onSaved: (value) {
                  user.bio = value!;
                },
              ),
              10.yGap,
              AppTextFormField(
                initialValue: user.address,
                title: 'Address',
                onSaved: (value) {
                  user.address = value!;
                },
              ),
              20.yGap,
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    if (await ConnectionCheck.internet()) {
                      await userCubit.updateUser(user);
                    } else {
                      await _noInternetConnection();
                    }
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        );
      },
    );
  }

  _noInternetConnection() {
    final context = AppConst.scaffoldMessengerKey.currentContext!;
    context.showSnackBar(message: "No internet connection");
  }
}
