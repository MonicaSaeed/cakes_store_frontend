import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/features/profile/business/cubit/user_profile_cubit.dart';
import 'package:cakes_store_frontend/features/profile/data/model/profile_mongo_model.dart';
import 'package:cakes_store_frontend/features/profile/data/repository/profile_repository.dart';
import 'package:cakes_store_frontend/features/profile/presentation/components/profilemenuItem.dart';
import 'package:cakes_store_frontend/features/profile/presentation/screen/editprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
          UserProfileCubit(ProfileRepository())..fetchProfile(),
      child: Scaffold(
          appBar: AppBar(
        title: const Text("Profile"),),
        backgroundColor: Colors.white,
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading)
             {
              return const Center(child: CircularProgressIndicator());
            }
             else if (state is UserProfileError)
              {
              return Center(child: Text(state.message));
            } 
            else if (state is UserProfileLoaded) {
        return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.black,
                      backgroundImage: state.profile.image != null? NetworkImage(state.profile.image!): null,
                      child: state.profile.image == null? const Icon(Icons.person, size: 45, color: Colors.white): null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.edit, size: 14, color: Colors.purple),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  state.profile.username ?? "No Name",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  state.profile.email,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),

                CustomElevatedButton(
                  textdata: 'Edit Profile',
                   onPressed: ()async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<UserProfileCubit>(), // ✅ Pass existing Cubit
                          child: const EditProfileScreen(),
                        ),
                      ),
                    );
                    context.read<UserProfileCubit>().fetchProfile();
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                 ProfileMenuItem(
                  icon: Icons.person,
                  title: "Personal Information",
                  subtitle: "${state.profile.username}, ${state.profile.email}, ${state.profile.phoneNumber}",
                ),
                ProfileMenuItem(
                  icon: Icons.location_on,
                  title: "My Addresses",
                  subtitle: "${state.profile.addresses}",
                ),
                const Divider(color: Colors.grey, height: 32),
                SwitchListTile(
                  value: false,
                  onChanged: (_) {},
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(color: Colors.black),
                  ),
                  secondary: const Icon(Icons.dark_mode, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomElevatedButton(
                    textdata: "Logout", 
                  onPressed:(){
                    
                  })
                ),
              ],
            ),
          ),
        ],
      );
      } else 
      {
        return const Center(child: Text("No profile data found."));
      }
    },
        ),
      ),
    );
  }
}