import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_components.dart/bio_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthBlocCubits>();
  late final profileCubit = context.read<ProfileBlocCubit>();

  // current user
  late AppUser? currentUser = authCubit.currentuser;

  // on startup

  @override
  void initState() {
    profileCubit.fecthUserProfile(widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SCAFOLD

    return BlocBuilder<ProfileBlocCubit, ProfileState>(
        builder: (context, profileState) {
      if (profileState is ProfileLoaded) {
        // get loaded user
        final user = profileState.profileUser;
        return Scaffold(
          //APP BAR
          appBar: AppBar(
            title: Text(
              user.name,
            ),
            foregroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              //edit profile button
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
            ],
          ),
          body: Column(children: [
            //email
            Text(
              user.email,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(
              height: 25,
            ),

            //profile pic
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 120,
              width: 120,
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //bio box
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Text(
                    'Bio',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //bio box
            BioBox(text: user.bio),

            const SizedBox(
              height: 10,
            ),

            //posts
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Text(
                    'Posts',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ]),
        );
      } else if (profileState is ProfileLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return const Center(
          child: Text('No profile found...'),
        );
      }
    });
  }
}
