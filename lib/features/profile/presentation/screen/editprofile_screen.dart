import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/features/profile/business/cubit/user_profile_cubit.dart';
import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:cakes_store_frontend/features/profile/presentation/widget/addaddress.dart';
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
  final _phoneController = TextEditingController();
  ProfileModel? _originalProfile;

  final List<TextEditingController> _addressControllers = [];

  void _addAddressField() {
    setState(() {
      _addressControllers.add(TextEditingController());
    });
  }

  void _removeAddressField(int index) {
    setState(() {
      _addressControllers.removeAt(index);
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate() && _originalProfile != null) {
      final allAddresses = _addressControllers
          .map((c) => c.text.trim())
          .where((address) => address.isNotEmpty)
          .toList();

      final updatedProfile = _originalProfile!.copyWith(
        username: _usernameController.text.trim().isNotEmpty
            ? _usernameController.text.trim()
            : _originalProfile!.username,
        phoneNumber: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : _originalProfile!.phoneNumber,
        addresses: allAddresses,
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
            Navigator.pop(context);
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
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error),
                ),
              );
            } else if (state is UserProfileLoaded) {
              if (_originalProfile == null) {
                _originalProfile = state.profile;
                _usernameController.text = _originalProfile!.username ?? '';
                _phoneController.text = _originalProfile!.phoneNumber ?? '';

                _addressControllers.clear();
                final existingAddresses = _originalProfile!.addresses ?? [];
                if (existingAddresses.isEmpty) {
                  _addressControllers.add(TextEditingController());
                } else {
                  for (final addr in existingAddresses) {
                    _addressControllers
                        .add(TextEditingController(text: addr));
                  }
                }
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: _originalProfile!.email ?? '',
                        ),
                        enabled: false,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6)),
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
                       const SizedBox(height: 16),
                      ..._addressControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController controller = entry.value;
                        return Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                title: 'Address ${index + 1}',
                                hintText: 'Enter your address',
                                controller: controller,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeAddressField(index),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                
                    addaddresas(context, _addAddressField),

                      const SizedBox(height: 70),
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
