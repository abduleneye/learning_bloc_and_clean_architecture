import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthBlocCubits>();

  // current user
  late AppUser? currentUser = authCubit.currentuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentUser!.email)),
    );
  }
}
