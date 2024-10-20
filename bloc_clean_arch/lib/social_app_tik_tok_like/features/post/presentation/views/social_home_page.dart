import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/post/presentation/post_components/social_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //APP BAR
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBlocCubits>().logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),

        //DRAWER
        drawer: const MySocialDrawer());
  }
}
