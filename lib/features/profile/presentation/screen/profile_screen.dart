import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/constants/api_constants.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/core/theme/theme_controller.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:cakes_store_frontend/features/profile/business/cubit/user_profile_cubit.dart';
import 'package:cakes_store_frontend/features/profile/data/repository/profile_repository.dart';
import 'package:cakes_store_frontend/features/profile/data/webservice/profile_mongoservice.dart';
import 'package:cakes_store_frontend/features/profile/presentation/components/profilemenuItem.dart';
import 'package:cakes_store_frontend/features/profile/presentation/screen/editprofile_screen.dart';
import 'package:cakes_store_frontend/features/profile/presentation/widget/delete_dialog.dart';
import 'package:cakes_store_frontend/features/profile/presentation/widget/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          UserProfileCubit(ProfileRepository())..fetchProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              return Center(child: Text(state.message));
            } else if (state is UserProfileLoaded) {
              final profile = state.profile;

              return SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showImageSourceDialog(context,
                                      (XFile file) async {
                                    try {
                                      await ProfileService().uploadImage(file);
                                      ToastHelper.showToast(
                                        context: context,
                                        message: 'Image uploaded successfully',
                                        toastType: ToastType.success,
                                      );
                                      context
                                          .read<UserProfileCubit>()
                                          .fetchProfile();
                                    } catch (e) {
                                      ToastHelper.showToast(
                                        context: context,
                                        message:
                                            "Failed to upload image: $e",
                                        toastType: ToastType.error,
                                      );
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      backgroundImage: profile.image != null
                                          ? NetworkImage(
                                              '${ApiConstance.baseUrl}${profile.image}')
                                          : null,
                                      child: profile.image == null
                                          ? Icon(
                                              Icons.person,
                                              size: 45,
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor:
                                            theme.colorScheme.surface,
                                        child: Icon(
                                          Icons.edit,
                                          size: 14,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                profile.username ?? "No Name",
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                profile.email,
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50),
                                child: CustomElevatedButton(
                                  textdata: 'Edit Profile',
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value:
                                              context.read<UserProfileCubit>(),
                                          child: const EditProfileScreen(),
                                        ),
                                      ),
                                    );
                                    context
                                        .read<UserProfileCubit>()
                                        .fetchProfile();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        ListView(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 16),
                            ProfileMenuItem(
                              icon: Icons.person,
                              title: "Personal Information",
                              subtitle:
                                  "${profile.username}, ${profile.email}",
                            ),
                            ProfileMenuItem(
                              icon: Icons.location_on,
                              title: "My Addresses",
                              subtitle:
                                  profile.addresses?.join(', ') ?? "",
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.manage_accounts,
                                color: theme.colorScheme.primary,
                              ),
                              title: Text(
                                "Manage Account",
                                style: theme.textTheme.bodyMedium,
                              ),
                              onTap: () => confirmDeleteAccount(context),
                              contentPadding: EdgeInsets.zero,
                            ),
                            ValueListenableBuilder(
                              valueListenable: ThemeController.themeNotifier,
                              builder: (_, mode, __) {
                                final isDark = ThemeController.isDark();
                                return SwitchListTile(
                                  value: isDark,
                                  onChanged: (_) =>
                                      ThemeController.toggleTheme(),
                                  title: Text(
                                    isDark
                                        ? "Dark Mode"
                                        : "Light Mode",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  secondary: Icon(
                                    isDark
                                        ? Icons.dark_mode
                                        : Icons.light_mode,
                                    color: theme.colorScheme.primary,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            SwitchListTile(
                              title: Text(
                                "Logout",
                                style: theme.textTheme.bodyMedium,
                              ),
                              value: false,
                              onChanged: (value) async {
                                if (value) {
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context,
                                            rootNavigator: true)
                                        .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const LoginScreen()),
                                      (route) => false,
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text('Logout failed: $e'),
                                      ),
                                    );
                                  }
                                }
                              },
                              secondary: Icon(
                                Icons.logout,
                                color: theme.colorScheme.primary,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text("No profile data found."));
            }
          },
        ),
      ),
    );
  }
}
