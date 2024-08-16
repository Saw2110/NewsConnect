import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_connect/core/core.dart';
import 'package:news_connect/dependency_injection/dependency_injection.dart';

import '../../profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
        updateUserUseCase: sl(),
        getUserUseCase: sl(),
        firebaseAuth: sl(),
      )..getUser(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      removeAllPadding: true,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const CustomLoading();
          } else if (state is UserSuccess) {
            final user = state.user;
            return _buildProfileUI(user);
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No user data'));
          }
        },
      ),
    );
  }

  Widget _buildProfileUI(UserModel user) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile",
                style: AppTextStyle.h1Bold.copyWith(fontSize: 26.0),
              ),
              TextButton.icon(
                onPressed: () async {
                  await SharedPref.removeAllData();
                  await sl<DatabaseProvider>().onDropDatabase();
                  NavigationService.pushReplacementNamed(AppRoutes.loginScreen);
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text("Logout"),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.yGap,
                  Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.cover,
                        imageUrl: user.image,
                        placeholder: (context, url) => const CustomLoading(),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.lightGrey,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person, size: 30.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  20.yGap,

                  ///
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: UserProfileForm(user: user),
                  ),

                  ///
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
