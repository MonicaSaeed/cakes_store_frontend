import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/features/profile/business/cubit/user_profile_cubit.dart';
import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageUrlController = TextEditingController();
  ProfileModel? _originalProfile;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _imageUrlController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate() && _originalProfile != null) {
      final updatedProfile = _originalProfile!.copyWith(
        username: _usernameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        image: _imageUrlController.text.trim().isEmpty
            ? null
            : _imageUrlController.text.trim(),
      );

      context.read<UserProfileCubit>().updateProfile(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        elevation: 2,
      ),
      body: BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileUpdated) {
            Navigator.pop(context); // Go back on success
          }
        },
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                ),
              );
            } else if (state is UserProfileLoaded) {
              if (_originalProfile == null) {
                _originalProfile = state.profile;
                _usernameController.text = _originalProfile!.username ?? '';
                _phoneController.text = _originalProfile!.phoneNumber ?? '';
                _imageUrlController.text = _originalProfile!.image ?? '';
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        title: 'Email',
                        hintText: _originalProfile!.email,
                        controller: _emailController,
                      ),

                      const SizedBox(height: 16),
                      CustomTextField(
                        title: 'Username',
                        hintText: _originalProfile!.username ?? '',
                        controller: _usernameController,
                      ),

                      const SizedBox(height: 16),
                      CustomTextField(
                        title: 'Phone Number',
                        hintText: _originalProfile!.phoneNumber ?? '',
                        controller: _phoneController,
                      ),

                      const SizedBox(height: 24),
                      CustomElevatedButton(
                        textdata: "Save",
                        onPressed: _saveProfile,
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text("No profile data available."));
          },
        ),
      ),
    );
  }
}
