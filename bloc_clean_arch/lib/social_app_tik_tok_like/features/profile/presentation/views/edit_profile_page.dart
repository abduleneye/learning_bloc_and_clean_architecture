import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  //update profile button pressed
  void updateProfile() async {
    // profile cubit_bloc
    final updateprofile = context.read<ProfileBlocCubit>();

    if (bioTextController.text.isNotEmpty) {
      updateprofile.updateProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text,
      );
    }
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<ProfileBlocCubit, ProfileState>(
      builder: (context, profileState) {
        //profile loading
        if (profileState is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Updating profile...')
                ],
              ),
            ),
          );
        }
        //profile error
        //profile loaded
        //kiss
        else {
          return buildEditPage();
        }
      },
      listener: (context, profileState) {
        print(profileState);
        if (profileState is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // save button
          IconButton(
              onPressed: () {
                updateProfile();
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: Column(
        children: [
          // profile picture

          //bio
          const Text('bio'),

          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextFieldSocialApp(
              controller: bioTextController,
              hintText: 'Write something',
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
